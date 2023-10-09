#!/usr/bin/env bash

# Configuration. Tenant ID and cloud server variables need to be set up accordingly during integration initial setup.
tenant_id="3673578"
cloud_server="https://us5-cloud.acronis.com"
service_path="/Library/Application Support/BackupClient/Acronis/sbin/aakore"

installed() {
  echo "<result>Installed</result>"
  exit 0
}

not_installed() {
  echo "<result>Not installed</result>"
  exit 0
}

# Check if Acronis Cyber Protection Agent core service is installed.
if [[ ! -f "${service_path}" ]]; then
  not_installed
fi

# Check if Cloud server is set up correctly.
if ! "${service_path}" info -raw | grep -q "\"server\": \"${cloud_server}"; then
  not_installed
fi

# Check if tenant ID is set up correctly.
if ! "${service_path}" info -raw | grep -q "\"tenantId\": \"${tenant_id}\""; then
  not_installed
fi

installed