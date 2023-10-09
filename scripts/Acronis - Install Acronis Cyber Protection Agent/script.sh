#!/usr/bin/env bash

# Arguments
download_url_x86_64="https://us5-cloud.acronis.com/bc/api/ams/links/agents/redirect?language=multi&channel=CURRENT&system=apple&architecture=64&productType=enterprise&white_labeled=1"
download_url_arm64="https://us5-cloud.acronis.com/bc/api/ams/links/agents/redirect?language=multi&channel=CURRENT&system=apple&architecture=arm&productType=enterprise&white_labeled=1"
registration_url="https://us5-cloud.acronis.com"
registration_token="3493-412C-436A"
protection_plan="1cec4617-58c1-4b07-aec2-6490608cea75"

# Configuration
configuration_profile="Acronis Cyber Protect"
registerer="/Library/Application Support/BackupClient/Acronis/RegisterAgentTool/RegisterAgent"
backup_config="/Library/Application Support/Acronis/Registry/BackupAndRecovery.config"
temp_base_path="/tmp/acronis_agent"
temp_image_path="${temp_base_path}/acronis_agent.dmg"
temp_mount_path="${temp_base_path}/dmg_root"
download_retries=5
download_retry_max_time=300
registration_retries=15
registration_delay=10
plan_retries=5
plan_delay=15

catch() {
  echo "An error has occurred during installation."
  cleanup
  exit 1
}

cleanup() {
  printf "Cleaning up temporary installation files.\n"

  if mount | grep -q "${temp_mount_path}"; then
    printf "Unmounting temporary installation image.\n"
    hdiutil detach "${temp_mount_path}"
  fi

  if [[ -d "${temp_base_path}" ]]; then
    printf "Removing temporary installation files.\n"
    rm -rf "${temp_base_path}"
  fi
}

check_profile() {
  if profiles -C -v | grep -q "attribute: name: ${configuration_profile}"; then
    printf "Required '%s' configuration profile was found. Proceeding with the installation.\n" "${configuration_profile}"
  else
    printf "Required '%s' configuration profile is missing. Aborting the installation.\n" "${configuration_profile}"
    return 1
  fi
}

install_agent() {
  printf "Preparing temporary installation directory.\n"
  if ! mkdir -p "${temp_mount_path}"; then
    printf "Unable to create temporary installation directory.\n"
    return 1
  fi

  current_user=$(id -un)
  chown -R "${current_user}" "${temp_base_path}"
  chmod -R 0700 "${temp_base_path}"

  architecture=$(uname -m)
  if [ "$architecture" == "arm64" ]; then
    printf "Detected architecture is ARM64.\n"
    download_url=$download_url_arm64
  elif [ "$architecture" == "x86_64" ]; then
    printf "Detected architecture is x86-64.\n"
    download_url=$download_url_x86_64
  else
    printf "Failed to recognize system architecture: %s. Aborting the installation.\n." "$architecture"
    return 1
  fi

  printf "Downloading Acronis Cyber Protection Agent for Mac.\n"
  if ! curl --retry $download_retries --retry-max-time $download_retry_max_time -f -L -C - -o "${temp_image_path}" "${download_url}"; then
    printf "Downloading of the installation image failed.\n"
    return 1
  fi

  if ! hdiutil attach "${temp_image_path}" -mountpoint "${temp_mount_path}" -nobrowse -noautoopenro; then
    printf "Mounting of the installation image failed.\n"
    return 1
  fi

  if ! pkgutil --check-signature "${temp_mount_path}/Install.pkg" | grep -q "Acronis International GmbH"; then
    printf "Failed to validate package signature. Aborting the installation.\n"
    return 1
  fi

  if ! installer -pkg "${temp_mount_path}/Install.pkg" -target LocalSystem; then
    printf "Failed to install the package.\n"
    cat /var/log/acronis_install.log
    return 1
  fi
}

unregister_agent() {
  printf "Unregistering agent.\n"

  if ! "${registerer}" -o unregister; then
    printf "Unregistering an agent failed.\n"
  else
    printf "Successfully unregistered an agent.\n"
  fi
}

register_agent() {
  printf "Starting registration of Acronis Cyber Protection Agent for Mac.\n"
  for ((i = 1; i <= registration_retries; i++)); do
    registration_interval=$((registration_delay * i))
    printf "Pausing for %d seconds before registration attempt.\n" $registration_interval
    sleep $registration_interval

    printf "Attempting to register an agent.\n"
    if "${registerer}" -o register -t cloud -a "${registration_url}" --token "${registration_token}"; then
      printf "Registration of an agent succeeded.\n"
      return 0
    fi
    printf "Registration of an agent failed.\n"
  done

  printf "No more registration attempts left.\n"
  return 1
}

apply_protection_plan() {
  if [ -z "$protection_plan" ]; then
    printf "No protection plan has been selected. Skipping protection plan appliance.\n"
    return 0
  fi

  resource_id=$(grep "InstanceID" "${backup_config}" | sed -E 's/.*<value name="InstanceID" type="TString">"(.+)"<\/value>.*/\1/')
  if [ -z "$resource_id" ]; then
    printf "Failed to retrieve resource ID of a machine. Aborting protection plan appliance.\n"
    return 1
  fi

  printf -v payload '{"context":{"items":["%s"]},"policy_id":"%s","disableOnConflict":false}' "${resource_id}" "${protection_plan}"

  for ((i = 1; i <= plan_retries; i++)); do
    plan_interval=$((plan_delay * i))
    printf "Pausing for %d seconds before protection plan appliance attempt.\n" $plan_interval
    sleep $plan_interval

    printf "Attempting to apply protection plan.\n"
    response=$(curl -s -w "\nHTTP STATUS CODE: %{http_code}\n" -L --request POST "${registration_url}/api/policy_management/v4/applications" \
      --header "Authorization: Bearer ${registration_token}" \
      --header "Content-Type: application/json" \
      --data-raw "${payload}")

    if echo "${response}" | grep -q "HTTP STATUS CODE: 200"; then
      printf "Successfully applied protection plan %s to resource %s.\n" "${protection_plan}" "${resource_id}"
      return 0
    elif echo "${response}" | grep -q "ApplicationsAlreadyExist"; then
      printf "Protection plan %s has already been applied to resource %s.\n" "${protection_plan}" "${resource_id}"
      return 0
    else
      printf "Appliance of a protection plan failed.\n"
      echo "${response}"
    fi
  done

  printf "Failed to apply protection plan %s to a resource %s.\n" "${protection_plan}" "${resource_id}"
  return 1
}

printf "Starting installation of Acronis Cyber Protection Agent for Mac.\n"
trap 'catch' ERR
check_profile
cleanup
install_agent
cleanup
unregister_agent
register_agent
apply_protection_plan
printf "Installation of Acronis Cyber Protection Agent for Mac was successful.\n"