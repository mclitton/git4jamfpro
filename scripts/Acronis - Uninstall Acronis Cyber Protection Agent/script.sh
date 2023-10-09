#!/usr/bin/env bash

# Configuration
installation_path="/Library/Application Support/BackupClient/Acronis"
registerer="${installation_path}/RegisterAgentTool/RegisterAgent"
uninstaller="${installation_path}/Cyber Protect Agent Uninstall.app/Contents/MacOS/AgentUninstall"

printf "Starting uninstallation of Acronis Cyber Protection Agent for Mac.\n"

if [[ ! -d "${installation_path}" ]]; then
  printf "Did not find an active installation_path. Skipping uninstallation.\n"
  exit 0
fi

# If you want to only uninstall the client without unregistering from the cloud, comment this section.
printf "Attempting to unregister an agent.\n"
if ! "${registerer}" -o unregister; then
  printf "Warning! Unregistering an agent failed.\n"
else
  printf "Successfully unregistered an agent.\n"
fi

# If you want to only uninstall the client without removing configuration and log files, remove /purge argument.
printf "Attempting to uninstall an agent.\n"
if ! "${uninstaller}" /confirm /purge; then
  printf "Failed to uninstall an agent.\n"
  exit 1
else
  printf "Successfully uninstalled an agent.\n"
fi

printf "Uninstallation of Acronis Cyber Protection Agent for Mac was successful.\n"