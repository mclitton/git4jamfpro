#!/usr/bin/env bash

# Arguments
download_url_x86_64="https://us5-cloud.acronis.com/bc/api/ams/links/agents/redirect?language=multi&channel=CURRENT&system=apple&architecture=64&productType=enterprise&white_labeled=1"
download_url_arm64="https://us5-cloud.acronis.com/bc/api/ams/links/agents/redirect?language=multi&channel=CURRENT&system=apple&architecture=arm&productType=enterprise&white_labeled=1"

# Configuration
configuration_profile="Acronis Cyber Protect"
temp_base_path="/tmp/acronis_agent"
temp_image_path="${temp_base_path}/acronis_agent.dmg"
temp_mount_path="${temp_base_path}/dmg_root"
download_retries=5
download_retry_max_time=300

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

  architecture=$(uname -m);
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

printf "Starting installation of Acronis Cyber Protection Agent for Mac.\n"
trap 'catch' ERR
check_profile
cleanup
install_agent
cleanup
printf "Installation of Acronis Cyber Protection Agent for Mac was successful.\n"