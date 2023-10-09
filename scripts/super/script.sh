#!/bin/bash
# The next line disables specific ShellCheck codes for the entire script.
# https://github.com/koalaman/shellcheck
# shellcheck disable=SC2001,SC2009,SC2207,SC2024

# S.U.P.E.R.M.A.N.
# Software Update/Upgrade Policy Enforcement (with) Recursive Messaging And Notification
# https://github.com/Macjutsu/super
# by Kevin M. White

superVERSION="3.0"
superDATE="2023/06/01"

# MARK: *** Documentation ***
################################################################################

# Show usage documentation. 
showUsage() {
echo "
  S.U.P.E.R.M.A.N.
  Software Update Policy Enforcement (with) Recursive Messaging And Notification
  
  Version $superVERSION
  $superDATE
  https://github.com/Macjutsu/super
  
  Usage:
  sudo ./super
  
  Deferment Timer Options:
  [--default-defer=seconds] [--focus-defer=seconds]
  [--menu-defer=seconds,seconds,etc...] [--error-defer=seconds]
  [--recheck-defer=seconds] [--delete-deferrals]
  
  Deferment Count Deadline Options:
  [--focus-count=number] [--soft-count=number] [--hard-count=number]
  [--restart-counts] [--delete-counts]
  
  Deferment Days Deadline Options:
  [--focus-days=number] [--soft-days=number] [--hard-days=number]
  [--zero-day=YYYY-MM-DD:hh:mm] [--restart-days] [--delete-days]
  
  Deferment Date Deadline Options:
  [--focus-date=YYYY-MM-DD:hh:mm] [--soft-date=YYYY-MM-DD:hh:mm]
  [--hard-date=YYYY-MM-DD:hh:mm] [--delete-dates]
  
  User Interface Options:
  [--defer-dialog-timeout=seconds] [--soft-dialog-timeout=seconds]
  [--display-redraw=seconds] [--display-icon=/local/path or URL]
  [--icon-size-ibm=pixels] [--icon-size-jamf=pixels ]
  [--display-accessory-type=TEXTBOX|HTMLBOX|HTML|IMAGE|VIDEO|VIDEOAUTO]
  [--display-accessory-default=/local/path or URL]
  [--display-accessory-update=/local/path or URL]
  [--display-accessory-upgrade=/local/path or URL]
  [--display-accessory-user-auth=/local/path or URL]
  [--help-button=plain text or URL] [--warning-button=plain text or URL]
  [--display-silently] [--display-silently-off]
  [--prefer-jamf-helper] [--prefer-jamf-helper-off]
  
  Apple Silicon Credential Options:
  [--local-account=AccountName] [--local-password=Password]
  [--admin-account=AccountName] [--admin-password=Password]
  [--super-account=AccountName] [--super-password=Password]
  [--jamf-account=AccountName] [--jamf-password=Password]
  [--delete-accounts] [--user-auth-timeout=seconds]
  [--user-auth-mdm-failover=ALWAYS,NOSERVICE,SOFT,HARD,INSTALLNOW,BOOTSTRAP]
  
  Update, Upgrade, and Restart Options:
  [--allow-upgrade] [--allow-upgrade-off] [--target-upgrade=version]
  [--allow-rsr-updates] [--allow-rsr-updates-off]
  [--enforce-non-system-updates] [--enforce-non-system-updates-off]
  [--only-download] [--only-download-off]
  [--install-now] [--install-now-off]
  [--policy-triggers=PolicyTrigger,PolicyTrigger,etc...]
  [--skip-updates] [--skip-updates-off]
  [--restart-without-updates] [--restart-without-updates-off]
  
  macOS Update/Upgrade Validation Options:
  [--free-space-update=gigabytes] [--free-space-upgrade=gigabytes]
  [--free-space-timeout=seconds] [--battery-level=percentage]
  [--battery-timeout=seconds]
  
  Testing, Validation, and Documentation:
  [--test-mode] [--test-mode-off] [--test-mode-timeout=seconds]
  [--verbose-mode] [--verbose-mode-off] [--open-logs] [--reset-super]
  [--usage] [--help]
  
  * Managed preferences override local options via domain: com.macjutsu.super
  <key>DefaultDefer</key> <string>seconds</string>
  <key>FocusDefer</key> <string>seconds</string>
  <key>MenuDefer</key> <string>seconds,seconds,etc...</string>
  <key>RecheckDefer</key> <string>seconds</string>
  <key>ErrorDefer</key> <string>seconds</string>
  <key>FocusCount</key> <string>number</string>
  <key>SoftCount</key> <string>number</string>
  <key>HardCount</key> <string>number</string>
  <key>FocusDays</key> <string>number</string>
  <key>SoftDays</key> <string>number</string>
  <key>HardDays</key> <string>number</string>
  <key>ZeroDay</key> <string>YYYY-MM-DD:hh:mm</string>
  <key>FocusDate</key> <string>YYYY-MM-DD:hh:mm</string>
  <key>SoftDate</key> <string>YYYY-MM-DD:hh:mm</string>
  <key>HardDate</key> <string>YYYY-MM-DD:hh:mm</string>
  <key>DeferDialogTimeout</key> <string>seconds</string>
  <key>SoftDialogTimeout</key> <string>seconds</string>
  <key>DisplayRedraw</key> <string>seconds</string>
  <key>DisplayIcon</key> <string>path</string>
  <key>IconSizeIbm</key> <string>pixels</string>
  <key>IconSizeJamf</key> <string>pixels</string>
  <key>DisplayAccessoryType</key>
  <string>TEXTBOX|HTMLBOX|HTML|IMAGE|VIDEO|VIDEOAUTO</string>
  <key>DisplayAccessoryDefault</key> <string>path or URL</string>
  <key>DisplayAccessoryUpdate</key> <string>path or URL</string>
  <key>DisplayAccessoryUpgrade</key> <string>path or URL</string>
  <key>DisplayAccessoryUserAuth</key> <string>path or URL</string>
  <key>HelpButton</key> <string>plain text or URL</string>
  <key>WarningButton</key> <string>plain text or URL</string>
  <key>DisplaySilently</key> <true/> | <false/>
  <key>PreferJamfHelper</key> <true/> | <false/>
  <key>UserAuthTimeout</key> <string>seconds</string>
  <key>UserAuthMDMFailover</key>
  <string>ALWAYS,NOSERVICE,SOFT,HARD,INSTALLNOW,BOOTSTRAP</string>
  <key>AllowUpgrade</key> <true/> | <false/>
  <key>TargetUpgrade</key> <string>version</string>
  <key>AllowRSRUpdates</key> <true/> | <false/>
  <key>EnforceNonSystemUpdates</key> <true/> | <false/>
  <key>OnlyDownload</key> <true/> | <false/>
  <key>InstallNow</key> <true/> | <false/>
  <key>PolicyTriggers</key> <string>PolicyTrigger,PolicyTrigger,etc...</string>
  <key>SkipUpdates</key> <true/> | <false/>
  <key>RestartWithoutUpdates</key> <true/> | <false/>
  <key>FreeSpaceUpdate</key> <string>gigabytes</string>
  <key>FreeSpaceUpgrade</key> <string>gigabytes</string>
  <key>FreeSpaceTimeout</key> <string>seconds</string>
  <key>BatteryLevel</key> <string>percentage</string>
  <key>BatteryTimeout</key> <string>seconds</string>
  <key>TestMode</key> <true/> | <false/>
  <key>TestModeTimeout</key> <string>seconds</string>
  <key>VerboseMode</key> <true/> | <false/>
  
  ** For detailed documentation visit: https://github.com/Macjutsu/super/wiki
  ** Or use --help to automatically open the S.U.P.E.R.M.A.N. Wiki.
"

# Error log any unrecognized options.
if [[ -n ${unrecognizedOptionsARRAY[*]} ]]; then
	sendToLog  "Error: Unrecognized Options: ${unrecognizedOptionsARRAY[*]}"; parameterERROR="TRUE"
	[[ "$jamfPARENT" == "TRUE" ]] && sendToLog  "Error: Note that each Jamf Pro Policy Parameter can only contain a single option."
	sendToStatus "Inactive Error: Unrecognized Options: ${unrecognizedOptionsARRAY[*]}"
fi
sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION USAGE EXIT ****"
exit 0
}

# If there is a real current user then open the S.U.P.E.R.M.A.N. Wiki, otherwise run the showUsage() function.
showHelp() {
checkCurrentUser
if [[ "$currentUserNAME" != "FALSE" ]]; then
	sendToLog "Startup: Opening S.U.P.E.R.M.A.N. Wiki for user \"$currentUserNAME\"."
	sudo -u "$currentUserNAME" open "https://github.com/Macjutsu/super/wiki" &
else
	showUsage
fi
sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION HELP EXIT ****"
exit 0
}

# MARK: *** Parameters ***
################################################################################

# Set default parameters that are used throughout the script.
setDefaults() {
# Installation folder:
superFOLDER="/Library/Management/super"

# Symbolic link in default path for super.
superLINK="/usr/local/bin/super"

# Path to a PID file:
superPIDFILE="/var/run/super.pid"

# Path to a local property list file:
superPLIST="$superFOLDER/com.macjutsu.super" # No trailing ".plist"

# Path to a managed property list file:
superMANAGEDPLIST="/Library/Managed Preferences/com.macjutsu.super" # No trailing ".plist"

# Path to the log for the main super workflow:
superLOG="$superFOLDER/super.log"

# Path to the log for the current softwareupdate --list command result:
asuListLOG="$superFOLDER/asuList.log"

# Path to the log for the current erase-install.sh --list command result:
installerListLOG="$superFOLDER/installerList.log"

# Path to the log for all softwareupdate download/install workflows:
asuLOG="$superFOLDER/asu.log"

# Path to the log for all macOS installer application download/install workflows:
installerLOG="$superFOLDER/installer.log"

# Path to the log for filtered MDM client command progress:
mdmCommandLOG="$superFOLDER/mdmCommand.log"

# Path to the log for debug MDM client command progress:
mdmCommandDebugLOG="$superFOLDER/mdmCommandDebug.log"

# Path to the log for filtered MDM update/upgrade workflow progress:
mdmWorkflowLOG="$superFOLDER/mdmWorkflow.log"

# Path to the log for debug MDM update/upgrade workflow progress:
mdmWorkflowDebugLOG="$superFOLDER/mdmWorkflowDebug.log"

# Path to the "hidden" file that triggers a macOS update/upgrade restart validation workflow:
restartValidateFilePATH="$superFOLDER/.RestartValidate"

# This is the name for the LaunchDaemon.
launchDaemonNAME="com.macjutsu.super" # No trailing ".plist"

# Path to the jamf binary:
jamfBINARY="/usr/local/bin/jamf"

# Path to the jamfHELPER binary:
jamfHELPER="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"

# URL to the IBM Notifier.app download:
ibmNotifierURL="https://github.com/IBM/mac-ibm-notifications/releases/download/v-2.9.1-b-96/IBM.Notifier.zip"

# Target version for IBM Notifier.app:
ibmNotifierVERSION="2.9.1"

# Path to the local IBM Notifier.app:
ibmNotifierAPP="$superFOLDER/IBM Notifier.app"

# Path to the local IBM Notifier.app binary:
ibmNotifierBINARY="$ibmNotifierAPP/Contents/MacOS/IBM Notifier"

# URL to the erase-install package installer:
eraseInstallURL="https://github.com/grahampugh/erase-install/releases/download/v27.3/erase-install-27.3.pkg"

# Target version for erase-install.sh:
eraseInstallVERSION="27.3"

# Target checksum for erase-install.sh:
eraseInstallCHECKSUM="890f3ec8fe0e2efa7b33d407eee96358d8a44ca4"

# Path to the local erase-install folder:
eraseInstallFOLDER="/Library/Management/erase-install"
# IMPORTANT DETAIL: super does NOT move the default erase-install folder content to another custom location.
# Changing this folder path to anything besides "/Library/Management/erase-install" requires that you must also deploy the erase-install folder to the custom location prior to using super.

# Path to the local copy of erase-install.sh:
eraseInstallSCRIPT="$eraseInstallFOLDER/erase-install.sh"

# Path to the local copy of installinstallmacOS.py:
installInstallMacOS="$eraseInstallFOLDER/installinstallmacOS.py"

# Path to the local copy of movable Python.framework:
pythonFRAMEWORK="$eraseInstallFOLDER/Python.framework"

# Path to a local softwareupdate property list file:
asuPLIST="/Library/Preferences/com.apple.SoftwareUpdate" # No trailing ".plist"

# Path to for the local cached display icon:
cachedICON="$superFOLDER/icon.png"

# The default icon in the if no $displayIconOPTION is specified or found.
defaultICON="/System/Library/PrivateFrameworks/SoftwareUpdate.framework/Versions/A/Resources/SoftwareUpdate.icns"

# Default icon size for IBM Notifier.app.
ibmNotifierIconSIZE=96

# Default icon size for jamfHelper.
jamfHelperIconSIZE=96

# Deadline date display format.
dateFORMAT="+%B %d, %Y" # Formatting options can be found in the man page for the date command.

# Deadline time display format.
timeFORMAT="+%l:%M %p" # Formatting options can be found in the man page for the date command.

# The default number of seconds to defer if a user choses not to restart now.
defaultDeferSECONDS=3600

# The default number of seconds to defer if there is a workflow error.
errorDeferSECONDS=3600

# The default user authentication dialog timeout.
userAuthTimeoutSECONDS=3600

# The default minium free storage space in gigabytes required for a macOS update.
freeSpaceUpdateGB=15

# The default minium free storage space in gigabytes required for a macOS upgrade.
freeSpaceUpgradeGB=35

# The default macOS upgrade installer estimated size (macOS update sizes are automatically collected via softwareupdate).
macOSInstallerGB=13

# The number of seconds between storage checks when displaying the insufficient free space notification via the notifyStorage() function.
storageRecheckSECONDS=5

# The default insufficient available free space notification timeout.
freeSpaceTimeoutSECONDS=3600

# The default battery level percentage required for a macOS software update/upgrade.
batteryLevelPERCENT=50

# The number of seconds between AC power checks when displaying the insufficient battery notification via the notifyStorage() function.
powerRecheckSECONDS=1

# The default AC Power required for low battery notification timeout.
batteryTimeoutSECONDS=3600

# The number of seconds to timeout various workflow startup processes if no progress is reported.
initialStartTimeoutSECONDS=120

# The number of seconds to timeout the macOS 11+ softwareupdate download/prepare workflow if no progress is reported.
softwareUpdateTimeoutSECONDS=1200

# The number of seconds to timeout the macOS 10.x softwareupdate download/prepare workflow if no progress is reported.
softwareUpdateLegacyTimeoutSECONDS=3600

# The number of seconds to timeout the softwareupdate recommended (non-system) update workflow if no progress is reported.
softwareUpdateRecommendedTimeoutSECONDS=600

# The number of seconds to timeout the macOS installer download workflow if no progress is reported.
macOSInstallerDownloadTimeoutSECONDS=300

# The number of seconds to timeout the macOS installation workflow if no progress is reported.
macOSInstallerTimeoutSECONDS=600

# The number of seconds to timeout MDM commands if no response is reported.
mdmTimeoutSECONDS=300

# The number of seconds to timeout the MDM download/prepare workflow if no progress is reported.
mdmWorkflowTimeoutSECONDS=600

# The default amount of time in seconds to leave test notifications and dialogs open before moving on with the test mode workflow.
testModeTimeoutSECONDS=10

# These parameters identify the relevant system information.
macOSMAJOR=$(sw_vers -productVersion | cut -d'.' -f1) # Expected output: 10, 11, 12
macOSMINOR=$(sw_vers -productVersion | cut -d'.' -f2) # Expected output: 14, 15, 06, 01
macOSVERSION=${macOSMAJOR}$(printf "%02d" "$macOSMINOR") # Expected output: 1014, 1015, 1106, 1203
[[ "$macOSMAJOR" -ge 13 ]] && macOSEXTRA=$(sw_vers -productVersionExtra | cut -d'.' -f2) # Expected output: (a), (b), (c)
macOSBUILD=$(sw_vers -buildVersion) # Expected output: 22D68
macOSNAME="macOS $(awk '/SOFTWARE LICENSE AGREEMENT FOR macOS/' '/System/Library/CoreServices/Setup Assistant.app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf' | awk -F 'macOS ' '{print $NF}' | awk '{print substr($0, 0, length($0)-1)}')" # Expected output: macOS Ventura
macOSARCH=$(arch) # Expected output: i386, arm64
macModelID="$(system_profiler SPHardwareDataType | grep 'Model Identifier' | awk -F ': ' '{print $2}')" # Expected output: MacBookPro18,2
[[ $(echo "$macModelID" | grep -c 'Book') -gt 0 ]] && macBOOK="TRUE" # Expected output: TRUE
lastREBOOT="$(last reboot | head -1 | sed -e 's/reboot    ~                         //' | xargs)" # Expected output: Sat Feb 18 11:45
}

# Collect input options and set associated parameters.
getOptions() {
# If super is running via Jamf Policy installation then the first 3 input parameters are skipped.
if [[ $1 == "/" ]]; then
	shift 3
	jamfPARENT="TRUE"
fi

# getOptions debug mode.
# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: @ is:\n$@"

# This is a standard while/case loop to collect all the input parameters.
while [[ -n $1 ]]; do
	case "$1" in
		--default-defer* )
			defaultDeferOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--focus-defer* )
			focusDeferOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--menu-defer* )
			menuDeferOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--recheck-defer* )
			recheckDeferOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--error-defer* )
			errorDeferOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--delete-deferrals )
			deleteDEFFERALS="TRUE"
		;;
		--focus-count* )
			focusCountOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--soft-count* )
			softCountOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--hard-count* )
			hardCountOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--restart-counts )
			restartCOUNTS="TRUE"
		;;
		--delete-counts )
			deleteCOUNTS="TRUE"
		;;
		--focus-days* )
			focusDaysOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--soft-days* )
			softDaysOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--hard-days* )
			hardDaysOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--zero-day* )
			zeroDayOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--restart-days )
			restartDAYS="TRUE"
		;;
		--delete-days )
			deleteDAYS="TRUE"
		;;
		--focus-date* )
			focusDateOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--soft-date* )
			softDateOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--hard-date* )
			hardDateOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--delete-dates )
			deleteDATES="TRUE"
		;;
		--defer-dialog-timeout* )
			deferDialogTimeoutOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--soft-dialog-timeout* )
			softDialogTimeoutOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--display-redraw* )
			displayRedrawOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--display-icon* )
			displayIconOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--icon-size-ibm* )
			iconSizeIbmOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--icon-size-jamf* )
			iconSizeJamfOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--display-accessory-type* )
			displayAccessoryTypeOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--display-accessory-default* )
			displayAccessoryDefaultOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--display-accessory-update* )
			displayAccessoryUpdateOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--display-accessory-upgrade* )
			displayAccessoryUpgradeOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--display-accessory-user-auth* )
			displayAccessoryUserAuthOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--help-button* )
			helpButtonOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--warning-button* )
			warningButtonOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		-Q|--display-silently|--display-silently-on )
			displaySilentlyOPTION="TRUE"
		;;
		-q|--display-silently-off|--no-display-silently )
			displaySilentlyOPTION="FALSE"
		;;
		-J|--prefer-jamf-helper|--prefer-jamf-helper-on )
			preferJamfHelperOPTION="TRUE"
		;;
		-j|--prefer-jamf-helper-off|--no-prefer-jamf-helper )
			preferJamfHelperOPTION="FALSE"
		;;
		--local-account* )
			localOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--local-password* )
			localPASSWORD=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--admin-account* )
			adminACCOUNT=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--admin-password* )
			adminPASSWORD=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--super-account* )
			superOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--super-password* )
			superPASSWORD=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--jamf-account* )
			jamfOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--jamf-password* )
			jamfPASSWORD=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		-d|-D|--delete-accounts )
			deleteACCOUNTS="TRUE"
		;;
		-M|--allow-upgrade|--allow-upgrade-on )
			allowUpgradeOPTION="TRUE"
		;;
		-m|--allow-upgrade-off|--no-allow-upgrade )
			allowUpgradeOPTION="FALSE"
		;;
		--user-auth-timeout* )
			userAuthTimeoutOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--user-auth-mdm-failover* )
			userAuthMDMFailoverOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--target-upgrade* )
			targetUpgradeOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		-N|--enforce-non-system-updates|--enforce-non-system-updates-on )
			enforceNonSystemUpdatesOPTION="TRUE"
		;;
		-n|--enforce-non-system-updates-off|--no-enforce-non-system-updates )
			enforceNonSystemUpdatesOPTION="FALSE"
		;;
		-R|--allow-rsr-updates|--allow-rsr-updates-on )
			allowRSRUpdatesOPTION="TRUE"
		;;
		-r|--allow-rsr-updates-off|--no-allow-rsr-updates )
			allowRSRUpdatesOPTION="FALSE"
		;;
		-O|--only-download|--only-download-on )
			onlyDownloadOPTION="TRUE"
		;;
		-o|--only-download-off|--no-only-download )
			onlyDownloadOPTION="FALSE"
		;;
		-I|--install-now|--install-now-on )
			installNowOPTION="TRUE"
		;;
		-i|--install-now-off|--no-update-now )
			installNowOPTION="FALSE"
		;;
		--policy-triggers* )
			policyTriggersOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		-S|--skip-updates|--skip-updates-on )
			skipUpdatesOPTION="TRUE"
		;;
		-s|--skip-updates-off|--no-skip-updates )
			skipUpdatesOPTION="FALSE"
		;;
		-W|--restart-without-updates|--restart-without-updates-on )
			restartWithoutUpdatesOPTION="TRUE"
		;;
		-w|--restart-without-updates-off|--no-restart-without-updates )
			restartWithoutUpdatesOPTION="FALSE"
		;;
		--free-space-update* )
			freeSpaceUpdateOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--free-space-upgrade* )
			freeSpaceUpgradeOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--free-space-timeout* )
			freeSpaceTimeoutOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--battery-level* )
			batteryLevelOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		--battery-timeout* )
			batteryTimeoutOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		-T|--test-mode|--test-mode-on )
			testModeOPTION="TRUE"
		;;
		-t|--test-mode-off|--no-test-mode )
			testModeOPTION="FALSE"
		;;
		--test-mode-timeout* )
			testModeTimeoutOPTION=$(echo "$1" | sed -e 's|^[^=]*=||g')
		;;
		-V|--verbose-mode|--verbose-mode-on )
			verboseModeOPTION="TRUE"
		;;
		-v|--verbose-mode-off|--no-verbose-mode )
			verboseModeOPTION="FALSE"
		;;
		-l|-L|--open-logs )
			openLOGS="TRUE"
		;;
		-x|-X|--reset-super )
			resetLocalPROPERTIES="TRUE"
		;;
		-u|-U|--usage )
			showUsage
		;;
		-h|-H|--help )
			showHelp
		;;
		*)
			unrecognizedOptionsARRAY+=("$1")
		;;
	esac
	shift
done

# Error log any unrecognized options.
[[ -n ${unrecognizedOptionsARRAY[*]} ]] && showUsage
}

# Collect any parameters stored in $superMANAGEDPLIST and/or $superPLIST.
getPreferences() {
# If $deleteDEFFERALS is specified, then delete all local deferral preferences.
if [[ "$deleteDEFFERALS" == "TRUE" ]]; then
	sendToLog "Startup: Deleting all local deferral preferences."
	defaults delete "$superPLIST" DefaultDefer 2> /dev/null
	defaults delete "$superPLIST" FocusDefer 2> /dev/null
	defaults delete "$superPLIST" MenuDefer 2> /dev/null
	defaults delete "$superPLIST" ErrorDefer 2> /dev/null
	defaults delete "$superPLIST" RecheckDefer 2> /dev/null
fi

# If $deleteCOUNTS is specified, then delete all local maximum deferral count deadline preferences.
if [[ "$deleteCOUNTS" == "TRUE" ]]; then
	sendToLog "Startup: Deleting all local maximum deferral count deadline preferences."
	defaults delete "$superPLIST" FocusCount 2> /dev/null
	defaults delete "$superPLIST" SoftCount 2> /dev/null
	defaults delete "$superPLIST" HardCount 2> /dev/null
fi

# If $deleteDAYS is specified, then delete all local maximum day deadline preferences.
if [[ "$deleteDAYS" == "TRUE" ]]; then
	sendToLog "Startup: Deleting all local maximum day deadline preferences."
	defaults delete "$superPLIST" FocusDays 2> /dev/null
	defaults delete "$superPLIST" SoftDays 2> /dev/null
	defaults delete "$superPLIST" HardDays 2> /dev/null
	defaults delete "$superPLIST" ZeroDay 2> /dev/null
fi

# If $deleteDATES is specified, then delete all local date deadline preferences.
if [[ "$deleteDATES" == "TRUE" ]]; then
	sendToLog "Startup: Deleting all local date deadline preferences."
	defaults delete "$superPLIST" FocusDate 2> /dev/null
	defaults delete "$superPLIST" SoftDate 2> /dev/null
	defaults delete "$superPLIST" HardDate 2> /dev/null
fi

# If $resetLocalPROPERTIES is specified, then delete all local non-account preferences.
if [[ "$resetLocalPROPERTIES" == "TRUE" ]]; then
	sendToLog "Startup: Deleting all local non-account preferences."
	defaults delete "$superPLIST" DefaultDefer 2> /dev/null
	defaults delete "$superPLIST" FocusDefer 2> /dev/null
	defaults delete "$superPLIST" MenuDefer 2> /dev/null
	defaults delete "$superPLIST" RecheckDefer 2> /dev/null
	defaults delete "$superPLIST" ErrorDefer 2> /dev/null
	defaults delete "$superPLIST" FocusCount 2> /dev/null
	defaults delete "$superPLIST" SoftCount 2> /dev/null
	defaults delete "$superPLIST" HardCount 2> /dev/null
	defaults delete "$superPLIST" FocusDays 2> /dev/null
	defaults delete "$superPLIST" SoftDays 2> /dev/null
	defaults delete "$superPLIST" HardDays 2> /dev/null
	defaults delete "$superPLIST" ZeroDay 2> /dev/null
	defaults delete "$superPLIST" FocusDate 2> /dev/null
	defaults delete "$superPLIST" SoftDate 2> /dev/null
	defaults delete "$superPLIST" HardDate 2> /dev/null
	defaults delete "$superPLIST" DeferDialogTimeout 2> /dev/null
	defaults delete "$superPLIST" SoftDialogTimeout 2> /dev/null
	defaults delete "$superPLIST" DisplayRedraw 2> /dev/null
	defaults delete "$superPLIST" DisplayIcon 2> /dev/null
	rm -r "$cachedICON" > /dev/null 2>&1
	defaults delete "$superPLIST" IconSizeIbm 2> /dev/null
	defaults delete "$superPLIST" IconSizeJamf 2> /dev/null
	defaults delete "$superPLIST" DisplayAccessoryType 2> /dev/null
	defaults delete "$superPLIST" DisplayAccessoryDefault 2> /dev/null
	defaults delete "$superPLIST" DisplayAccessoryUpdate 2> /dev/null
	defaults delete "$superPLIST" DisplayAccessoryUpgrade 2> /dev/null
	defaults delete "$superPLIST" DisplayAccessoryUserAuth 2> /dev/null
	defaults delete "$superPLIST" HelpButton 2> /dev/null
	defaults delete "$superPLIST" WarningButton 2> /dev/null
	defaults delete "$superPLIST" DisplaySilently 2> /dev/null
	defaults delete "$superPLIST" PreferJamfHelper 2> /dev/null
	defaults delete "$superPLIST" UserAuthTimeout 2> /dev/null
	defaults delete "$superPLIST" UserAuthMDMFailover 2> /dev/null
	defaults delete "$superPLIST" AllowUpgrade 2> /dev/null
	defaults delete "$superPLIST" TargetUpgrade 2> /dev/null
	defaults delete "$superPLIST" AllowRSRUpdates 2> /dev/null
	defaults delete "$superPLIST" EnforceNonSystemUpdates 2> /dev/null
	defaults delete "$superPLIST" OnlyDownload 2> /dev/null
	defaults delete "$superPLIST" InstallNow 2> /dev/null
	defaults delete "$superPLIST" PolicyTriggers 2> /dev/null
	defaults delete "$superPLIST" SkipUpdates 2> /dev/null
	defaults delete "$superPLIST" RestartWithoutUpdates 2> /dev/null
	defaults delete "$superPLIST" FreeSpaceUpdate 2> /dev/null
	defaults delete "$superPLIST" FreeSpaceUpgrade 2> /dev/null
	defaults delete "$superPLIST" FreeSpaceTimeout 2> /dev/null
	defaults delete "$superPLIST" BatteryLevel 2> /dev/null
	defaults delete "$superPLIST" BatteryTimeout 2> /dev/null
	defaults delete "$superPLIST" TestMode 2> /dev/null
	defaults delete "$superPLIST" TestModeTimeout 2> /dev/null
	defaults delete "$superPLIST" VerboseMode 2> /dev/null
	restartZeroDay
	restartDeferralCounters
	defaults delete "$superPLIST" SoftwareUpdatesList 2> /dev/null
	defaults delete "$superPLIST" macOSSoftwareUpgradeLabel 2> /dev/null
	defaults delete "$superPLIST" macOSSoftwareUpgradeTitle 2> /dev/null
	defaults delete "$superPLIST" macOSUpgradeName 2> /dev/null
	defaults delete "$superPLIST" macOSUpgradeVersion 2> /dev/null
	defaults delete "$superPLIST" macOSSoftwareUpdateDownloadLabel 2> /dev/null
	defaults delete "$superPLIST" LastReboot 2> /dev/null
	defaults delete "$superPLIST" macOSInstallerDownloadVersion 2> /dev/null
	defaults delete "$superPLIST" macOSInstallerDownloadName 2> /dev/null
	rm -f "$restartValidateFilePATH" 2> /dev/null
	unset restartValidate
	defaults delete "$superPLIST" RestartValidate 2> /dev/null # This line is only here to remove any legacy RestartValidate keys.
	fullCheckREQUIRED="TRUE"
	rm -f "$asuListLOG" 2> /dev/null
	touch "$asuListLOG"
	rm -f "$installerListLOG" 2> /dev/null
	touch "$installerListLOG"
fi

# Collect any managed preferences from $superMANAGEDPLIST.
if [[ -f "$superMANAGEDPLIST.plist" ]]; then
	jamfProIdMANAGED=$(defaults read "$superMANAGEDPLIST" JamfProID 2> /dev/null)
	defaultDeferMANAGED=$(defaults read "$superMANAGEDPLIST" DefaultDefer 2> /dev/null)
	focusDeferMANAGED=$(defaults read "$superMANAGEDPLIST" FocusDefer 2> /dev/null)
	menuDeferMANAGED=$(defaults read "$superMANAGEDPLIST" MenuDefer 2> /dev/null)
	recheckDeferMANAGED=$(defaults read "$superMANAGEDPLIST" RecheckDefer 2> /dev/null)
	errorDeferMANAGED=$(defaults read "$superMANAGEDPLIST" ErrorDefer 2> /dev/null)
	focusCountMANAGED=$(defaults read "$superMANAGEDPLIST" FocusCount 2> /dev/null)
	softCountMANAGED=$(defaults read "$superMANAGEDPLIST" SoftCount 2> /dev/null)
	hardCountMANAGED=$(defaults read "$superMANAGEDPLIST" HardCount 2> /dev/null)
	focusDaysMANAGED=$(defaults read "$superMANAGEDPLIST" FocusDays 2> /dev/null)
	softDaysMANAGED=$(defaults read "$superMANAGEDPLIST" SoftDays 2> /dev/null)
	hardDaysMANAGED=$(defaults read "$superMANAGEDPLIST" HardDays 2> /dev/null)
	zeroDayMANAGED=$(defaults read "$superMANAGEDPLIST" ZeroDay 2> /dev/null)
	focusDateMANAGED=$(defaults read "$superMANAGEDPLIST" FocusDate 2> /dev/null)
	softDateMANAGED=$(defaults read "$superMANAGEDPLIST" SoftDate 2> /dev/null)
	hardDateMANAGED=$(defaults read "$superMANAGEDPLIST" HardDate 2> /dev/null)
	deferDialogTimeoutMANAGED=$(defaults read "$superMANAGEDPLIST" DeferDialogTimeout 2> /dev/null)
	softDialogTimeoutMANAGED=$(defaults read "$superMANAGEDPLIST" SoftDialogTimeout 2> /dev/null)
	displayRedrawMANAGED=$(defaults read "$superMANAGEDPLIST" DisplayRedraw 2> /dev/null)
	displayIconMANAGED=$(defaults read "$superMANAGEDPLIST" DisplayIcon 2> /dev/null)
	iconSizeIbmMANAGED=$(defaults read "$superMANAGEDPLIST" IconSizeIbm 2> /dev/null)
	iconSizeJamfMANAGED=$(defaults read "$superMANAGEDPLIST" IconSizeJamf 2> /dev/null)
	displayAccessoryTypeMANAGED=$(defaults read "$superMANAGEDPLIST" DisplayAccessoryType 2> /dev/null)
	displayAccessoryDefaultMANAGED=$(defaults read "$superMANAGEDPLIST" DisplayAccessoryDefault 2> /dev/null)
	displayAccessoryUpdateMANAGED=$(defaults read "$superMANAGEDPLIST" DisplayAccessoryUpdate 2> /dev/null)
	displayAccessoryUpgradeMANAGED=$(defaults read "$superMANAGEDPLIST" DisplayAccessoryUpgrade 2> /dev/null)
	displayAccessoryUserAuthMANAGED=$(defaults read "$superMANAGEDPLIST" DisplayAccessoryUserAuth 2> /dev/null)
	helpButtonMANAGED=$(defaults read "$superMANAGEDPLIST" HelpButton 2> /dev/null)
	warningButtonMANAGED=$(defaults read "$superMANAGEDPLIST" WarningButton 2> /dev/null)
	displaySilentlyMANAGED=$(defaults read "$superMANAGEDPLIST" DisplaySilently 2> /dev/null)
	preferJamfHelperMANAGED=$(defaults read "$superMANAGEDPLIST" PreferJamfHelper 2> /dev/null)
	userAuthTimeoutMANAGED=$(defaults read "$superMANAGEDPLIST" UserAuthTimeout 2> /dev/null)
	userAuthMDMFailoverMANAGED=$(defaults read "$superMANAGEDPLIST" UserAuthMDMFailover 2> /dev/null)
	allowUpgradeMANAGED=$(defaults read "$superMANAGEDPLIST" AllowUpgrade 2> /dev/null)
	targetUpgradeMANAGED=$(defaults read "$superMANAGEDPLIST" TargetUpgrade 2> /dev/null)
	allowRSRUpdatesMANAGED=$(defaults read "$superMANAGEDPLIST" AllowRSRUpdates 2> /dev/null)
	enforceNonSystemUpdatesMANAGED=$(defaults read "$superMANAGEDPLIST" EnforceNonSystemUpdates 2> /dev/null)
	onlyDownloadMANAGED=$(defaults read "$superMANAGEDPLIST" OnlyDownload 2> /dev/null)
	installNowMANAGED=$(defaults read "$superMANAGEDPLIST" InstallNow 2> /dev/null)
	policyTriggersMANAGED=$(defaults read "$superMANAGEDPLIST" PolicyTriggers 2> /dev/null)
	skipUpdatesMANAGED=$(defaults read "$superMANAGEDPLIST" SkipUpdates 2> /dev/null)
	restartWithoutUpdatesMANAGED=$(defaults read "$superMANAGEDPLIST" RestartWithoutUpdates 2> /dev/null)
	freeSpaceUpdateMANAGED=$(defaults read "$superMANAGEDPLIST" FreeSpaceUpdate 2> /dev/null)
	freeSpaceUpgradeMANAGED=$(defaults read "$superMANAGEDPLIST" FreeSpaceUpgrade 2> /dev/null)
	freeSpaceTimeoutMANAGED=$(defaults read "$superMANAGEDPLIST" FreeSpaceTimeout 2> /dev/null)
	batteryLevelMANAGED=$(defaults read "$superMANAGEDPLIST" BatteryLevel 2> /dev/null)
	batteryTimeoutMANAGED=$(defaults read "$superMANAGEDPLIST" BatteryTimeout 2> /dev/null)
	testModeMANAGED=$(defaults read "$superMANAGEDPLIST" TestMode 2> /dev/null)
	testModeTimeoutMANAGED=$(defaults read "$superMANAGEDPLIST" TestModeTimeout 2> /dev/null)
	verboseModeMANAGED=$(defaults read "$superMANAGEDPLIST" VerboseMode 2> /dev/null)
fi

# Collect any local preferences from $superPLIST.
if [[ -f "$superPLIST.plist" ]]; then
	defaultDeferPROPERTY=$(defaults read "$superPLIST" DefaultDefer 2> /dev/null)
	focusDeferPROPERTY=$(defaults read "$superPLIST" FocusDefer 2> /dev/null)
	menuDeferPROPERTY=$(defaults read "$superPLIST" MenuDefer 2> /dev/null)
	recheckDeferPROPERTY=$(defaults read "$superPLIST" RecheckDefer 2> /dev/null)
	errorDeferPROPERTY=$(defaults read "$superPLIST" ErrorDefer 2> /dev/null)
	focusCountPROPERTY=$(defaults read "$superPLIST" FocusCount 2> /dev/null)
	softCountPROPERTY=$(defaults read "$superPLIST" SoftCount 2> /dev/null)
	hardCountPROPERTY=$(defaults read "$superPLIST" HardCount 2> /dev/null)
	focusDaysPROPERTY=$(defaults read "$superPLIST" FocusDays 2> /dev/null)
	softDaysPROPERTY=$(defaults read "$superPLIST" SoftDays 2> /dev/null)
	hardDaysPROPERTY=$(defaults read "$superPLIST" HardDays 2> /dev/null)
	zeroDayPROPERTY=$(defaults read "$superPLIST" ZeroDay 2> /dev/null)
	focusDatePROPERTY=$(defaults read "$superPLIST" FocusDate 2> /dev/null)
	softDatePROPERTY=$(defaults read "$superPLIST" SoftDate 2> /dev/null)
	hardDatePROPERTY=$(defaults read "$superPLIST" HardDate 2> /dev/null)
	deferDialogTimeoutPROPERTY=$(defaults read "$superPLIST" DeferDialogTimeout 2> /dev/null)
	softDialogTimeoutPROPERTY=$(defaults read "$superPLIST" SoftDialogTimeout 2> /dev/null)
	displayRedrawPROPERTY=$(defaults read "$superPLIST" DisplayRedraw 2> /dev/null)
	iconSizeIbmPROPERTY=$(defaults read "$superPLIST" IconSizeIbm 2> /dev/null)
	iconSizeJamfPROPERTY=$(defaults read "$superPLIST" IconSizeJamf 2> /dev/null)
	displayAccessoryTypePROPERTY=$(defaults read "$superPLIST" DisplayAccessoryType 2> /dev/null)
	displayAccessoryDefaultPROPERTY=$(defaults read "$superPLIST" DisplayAccessoryDefault 2> /dev/null)
	displayAccessoryUpdatePROPERTY=$(defaults read "$superPLIST" DisplayAccessoryUpdate 2> /dev/null)
	displayAccessoryUpgradePROPERTY=$(defaults read "$superPLIST" DisplayAccessoryUpgrade 2> /dev/null)
	displayAccessoryUserAuthPROPERTY=$(defaults read "$superPLIST" DisplayAccessoryUserAuth 2> /dev/null)
	helpButtonPROPERTY=$(defaults read "$superPLIST" HelpButton 2> /dev/null)
	warningButtonPROPERTY=$(defaults read "$superPLIST" WarningButton 2> /dev/null)
	displaySilentlyPROPERTY=$(defaults read "$superPLIST" DisplaySilently 2> /dev/null)
	preferJamfHelperPROPERTY=$(defaults read "$superPLIST" PreferJamfHelper 2> /dev/null)
	userAuthTimeoutPROPERTY=$(defaults read "$superPLIST" UserAuthTimeout 2> /dev/null)
	userAuthMDMFailoverPROPERTY=$(defaults read "$superPLIST" UserAuthMDMFailover 2> /dev/null)
	allowUpgradePROPERTY=$(defaults read "$superPLIST" AllowUpgrade 2> /dev/null)
	targetUpgradePROPERTY=$(defaults read "$superPLIST" TargetUpgrade 2> /dev/null)
	allowRSRUpdatesPROPERTY=$(defaults read "$superPLIST" AllowRSRUpdates 2> /dev/null)
	enforceNonSystemUpdatesPROPERTY=$(defaults read "$superPLIST" EnforceNonSystemUpdates 2> /dev/null)
	onlyDownloadPROPERTY=$(defaults read "$superPLIST" OnlyDownload 2> /dev/null)
	installNowPROPERTY=$(defaults read "$superPLIST" InstallNow 2> /dev/null)
	policyTriggersPROPERTY=$(defaults read "$superPLIST" PolicyTriggers 2> /dev/null)
	skipUpdatesPROPERTY=$(defaults read "$superPLIST" SkipUpdates 2> /dev/null)
	restartWithoutUpdatesPROPERTY=$(defaults read "$superPLIST" RestartWithoutUpdates 2> /dev/null)
	freeSpaceUpdatePROPERTY=$(defaults read "$superPLIST" FreeSpaceUpdate 2> /dev/null)
	freeSpaceUpgradePROPERTY=$(defaults read "$superPLIST" FreeSpaceUpgrade 2> /dev/null)
	freeSpaceTimeoutPROPERTY=$(defaults read "$superPLIST" FreeSpaceTimeout 2> /dev/null)
	batteryLevelPROPERTY=$(defaults read "$superPLIST" BatteryLevel 2> /dev/null)
	batteryTimeoutPROPERTY=$(defaults read "$superPLIST" BatteryTimeout 2> /dev/null)
	testModePROPERTY=$(defaults read "$superPLIST" TestMode 2> /dev/null)
	testModeTimeoutPROPERTY=$(defaults read "$superPLIST" TestModeTimeout 2> /dev/null)
	verboseModePROPERTY=$(defaults read "$superPLIST" VerboseMode 2> /dev/null)
fi

# This logic ensures the priority order of managed preference overrides the new input option which overrides the saved local preference.
if [[ -n $defaultDeferMANAGED ]]; then
	defaultDeferOPTION="$defaultDeferMANAGED"
elif [[ -z $defaultDeferOPTION ]] && [[ -n $defaultDeferPROPERTY ]]; then
	defaultDeferOPTION="$defaultDeferPROPERTY"
fi
if [[ -n $focusDeferMANAGED ]]; then
	focusDeferOPTION="$focusDeferMANAGED"
elif [[ -z $focusDeferOPTION ]] && [[ -n $focusDeferPROPERTY ]]; then
	focusDeferOPTION="$focusDeferPROPERTY"
fi
if [[ -n $menuDeferMANAGED ]]; then
	menuDeferOPTION="$menuDeferMANAGED"
elif [[ -z $menuDeferOPTION ]] && [[ -n $menuDeferPROPERTY ]]; then
	menuDeferOPTION="$menuDeferPROPERTY"
fi
if [[ -n $recheckDeferMANAGED ]]; then
	recheckDeferOPTION="$recheckDeferMANAGED"
elif [[ -z $recheckDeferOPTION ]] && [[ -n $recheckDeferPROPERTY ]]; then
	recheckDeferOPTION="$recheckDeferPROPERTY"
fi
if [[ -n $errorDeferMANAGED ]]; then
	errorDeferOPTION="$errorDeferMANAGED"
elif [[ -z $errorDeferOPTION ]] && [[ -n $errorDeferPROPERTY ]]; then
	errorDeferOPTION="$errorDeferPROPERTY"
fi
if [[ -n $focusCountMANAGED ]]; then
	focusCountOPTION="$focusCountMANAGED"
elif [[ -z $focusCountOPTION ]] && [[ -n $focusCountPROPERTY ]]; then
	focusCountOPTION="$focusCountPROPERTY"
fi
if [[ -n $softCountMANAGED ]]; then
	softCountOPTION="$softCountMANAGED"
elif [[ -z $softCountOPTION ]] && [[ -n $softCountPROPERTY ]]; then
	softCountOPTION="$softCountPROPERTY"
fi
if [[ -n $hardCountMANAGED ]]; then
	hardCountOPTION="$hardCountMANAGED"
elif [[ -z $hardCountOPTION ]] && [[ -n $hardCountPROPERTY ]]; then
	hardCountOPTION="$hardCountPROPERTY"
fi
if [[ -n $focusDaysMANAGED ]]; then
	focusDaysOPTION="$focusDaysMANAGED"
elif [[ -z $focusDaysOPTION ]] && [[ -n $focusDaysPROPERTY ]]; then
	focusDaysOPTION="$focusDaysPROPERTY"
fi
if [[ -n $softDaysMANAGED ]]; then
	softDaysOPTION="$softDaysMANAGED"
elif [[ -z $softDaysOPTION ]] && [[ -n $softDaysPROPERTY ]]; then
	softDaysOPTION="$softDaysPROPERTY"
fi
if [[ -n $hardDaysMANAGED ]]; then
	hardDaysOPTION="$hardDaysMANAGED"
elif [[ -z $hardDaysOPTION ]] && [[ -n $hardDaysPROPERTY ]]; then
	hardDaysOPTION="$hardDaysPROPERTY"
fi
if [[ -n $zeroDayMANAGED ]]; then
	zeroDayOPTION="$zeroDayMANAGED"
elif [[ -z $zeroDayOPTION ]] && [[ -n $zeroDayPROPERTY ]]; then
	zeroDayOPTION="$zeroDayPROPERTY"
fi
if [[ -n $focusDateMANAGED ]]; then
	focusDateOPTION="$focusDateMANAGED"
elif [[ -z $focusDateOPTION ]] && [[ -n $focusDatePROPERTY ]]; then
	focusDateOPTION="$focusDatePROPERTY"
fi
if [[ -n $softDateMANAGED ]]; then
	softDateOPTION="$softDateMANAGED"
elif [[ -z $softDateOPTION ]] && [[ -n $softDatePROPERTY ]]; then
	softDateOPTION="$softDatePROPERTY"
fi
if [[ -n $hardDateMANAGED ]]; then
	hardDateOPTION="$hardDateMANAGED"
elif [[ -z $hardDateOPTION ]] && [[ -n $hardDatePROPERTY ]]; then
	hardDateOPTION="$hardDatePROPERTY"
fi
if [[ -n $deferDialogTimeoutMANAGED ]]; then
	deferDialogTimeoutOPTION="$deferDialogTimeoutMANAGED"
elif [[ -z $deferDialogTimeoutOPTION ]] && [[ -n $deferDialogTimeoutPROPERTY ]]; then
	deferDialogTimeoutOPTION="$deferDialogTimeoutPROPERTY"
fi
if [[ -n $softDialogTimeoutMANAGED ]]; then
	softDialogTimeoutOPTION="$softDialogTimeoutMANAGED"
elif [[ -z $softDialogTimeoutOPTION ]] && [[ -n $softDialogTimeoutPROPERTY ]]; then
	softDialogTimeoutOPTION="$softDialogTimeoutPROPERTY"
fi
if [[ -n $displayRedrawMANAGED ]]; then
	displayRedrawOPTION="$displayRedrawMANAGED"
elif [[ -z $displayRedrawOPTION ]] && [[ -n $displayRedrawPROPERTY ]]; then
	displayRedrawOPTION="$displayRedrawPROPERTY"
fi
[[ -n $displayIconMANAGED ]] && displayIconOPTION="$displayIconMANAGED"
if [[ -n $iconSizeIbmMANAGED ]]; then
	iconSizeIbmOPTION="$iconSizeIbmMANAGED"
elif [[ -z $iconSizeIbmOPTION ]] && [[ -n $iconSizeIbmPROPERTY ]]; then
	iconSizeIbmOPTION="$iconSizeIbmPROPERTY"
fi
if [[ -n $iconSizeJamfMANAGED ]]; then
	iconSizeJamfOPTION="$iconSizeJamfMANAGED"
elif [[ -z $iconSizeJamfOPTION ]] && [[ -n $iconSizeJamfPROPERTY ]]; then
	iconSizeJamfOPTION="$iconSizeJamfPROPERTY"
fi
if [[ -n $displayAccessoryTypeMANAGED ]]; then
	displayAccessoryTypeOPTION="$displayAccessoryTypeMANAGED"
elif [[ -z $displayAccessoryTypeOPTION ]] && [[ -n $displayAccessoryTypePROPERTY ]]; then
	displayAccessoryTypeOPTION="$displayAccessoryTypePROPERTY"
fi
if [[ -n $displayAccessoryDefaultMANAGED ]]; then
	displayAccessoryDefaultOPTION="$displayAccessoryDefaultMANAGED"
elif [[ -z $displayAccessoryDefaultOPTION ]] && [[ -n $displayAccessoryDefaultPROPERTY ]]; then
	displayAccessoryDefaultOPTION="$displayAccessoryDefaultPROPERTY"
fi
if [[ -n $displayAccessoryUpdateMANAGED ]]; then
	displayAccessoryUpdateOPTION="$displayAccessoryUpdateMANAGED"
elif [[ -z $displayAccessoryUpdateOPTION ]] && [[ -n $displayAccessoryUpdatePROPERTY ]]; then
	displayAccessoryUpdateOPTION="$displayAccessoryUpdatePROPERTY"
fi
if [[ -n $displayAccessoryUpgradeMANAGED ]]; then
	displayAccessoryUpgradeOPTION="$displayAccessoryUpgradeMANAGED"
elif [[ -z $displayAccessoryUpgradeOPTION ]] && [[ -n $displayAccessoryUpgradePROPERTY ]]; then
	displayAccessoryUpgradeOPTION="$displayAccessoryUpgradePROPERTY"
fi
if [[ -n $displayAccessoryUserAuthMANAGED ]]; then
	displayAccessoryUserAuthOPTION="$displayAccessoryUserAuthMANAGED"
elif [[ -z $displayAccessoryUserAuthOPTION ]] && [[ -n $displayAccessoryUserAuthPROPERTY ]]; then
	displayAccessoryUserAuthOPTION="$displayAccessoryUserAuthPROPERTY"
fi
if [[ -n $helpButtonMANAGED ]]; then
	helpButtonOPTION="$helpButtonMANAGED"
elif [[ -z $helpButtonOPTION ]] && [[ -n $helpButtonPROPERTY ]]; then
	helpButtonOPTION="$helpButtonPROPERTY"
fi
if [[ -n $warningButtonMANAGED ]]; then
	warningButtonOPTION="$warningButtonMANAGED"
elif [[ -z $warningButtonOPTION ]] && [[ -n $warningButtonPROPERTY ]]; then
	warningButtonOPTION="$warningButtonPROPERTY"
fi
if [[ -n $displaySilentlyMANAGED ]]; then
	displaySilentlyOPTION="$displaySilentlyMANAGED"
elif [[ -z $displaySilentlyOPTION ]] && [[ -n $displaySilentlyPROPERTY ]]; then
	displaySilentlyOPTION="$displaySilentlyPROPERTY"
fi
if [[ -n $preferJamfHelperMANAGED ]]; then
	preferJamfHelperOPTION="$preferJamfHelperMANAGED"
elif [[ -z $preferJamfHelperOPTION ]] && [[ -n $preferJamfHelperPROPERTY ]]; then
	preferJamfHelperOPTION="$preferJamfHelperPROPERTY"
fi
if [[ -n $userAuthTimeoutMANAGED ]]; then
	userAuthTimeoutOPTION="$userAuthTimeoutMANAGED"
elif [[ -z $userAuthTimeoutOPTION ]] && [[ -n $userAuthTimeoutPROPERTY ]]; then
	userAuthTimeoutOPTION="$userAuthTimeoutPROPERTY"
fi
if [[ -n $userAuthMDMFailoverMANAGED ]]; then
	userAuthMDMFailoverOPTION="$userAuthMDMFailoverMANAGED"
elif [[ -z $userAuthMDMFailoverOPTION ]] && [[ -n $userAuthMDMFailoverPROPERTY ]]; then
	userAuthMDMFailoverOPTION="$userAuthMDMFailoverPROPERTY"
fi
if [[ -n $allowUpgradeMANAGED ]]; then
	allowUpgradeOPTION="$allowUpgradeMANAGED"
elif [[ -z $allowUpgradeOPTION ]] && [[ -n $allowUpgradePROPERTY ]]; then
	allowUpgradeOPTION="$allowUpgradePROPERTY"
fi
if [[ -n $targetUpgradeMANAGED ]]; then
	targetUpgradeOPTION="$targetUpgradeMANAGED"
elif [[ -z $targetUpgradeOPTION ]] && [[ -n $targetUpgradePROPERTY ]]; then
	targetUpgradeOPTION="$targetUpgradePROPERTY"
fi
if [[ -n $allowRSRUpdatesMANAGED ]]; then
	allowRSRUpdatesOPTION="$allowRSRUpdatesMANAGED"
elif [[ -z $allowRSRUpdatesOPTION ]] && [[ -n $allowRSRUpdatesPROPERTY ]]; then
	allowRSRUpdatesOPTION="$allowRSRUpdatesPROPERTY"
fi
if [[ -n $enforceNonSystemUpdatesMANAGED ]]; then
	enforceNonSystemUpdatesOPTION="$enforceNonSystemUpdatesMANAGED"
elif [[ -z $enforceNonSystemUpdatesOPTION ]] && [[ -n $enforceNonSystemUpdatesPROPERTY ]]; then
	enforceNonSystemUpdatesOPTION="$enforceNonSystemUpdatesPROPERTY"
fi
if [[ -n $onlyDownloadMANAGED ]]; then
	onlyDownloadOPTION="$onlyDownloadMANAGED"
elif [[ -z $onlyDownloadOPTION ]] && [[ -n $onlyDownloadPROPERTY ]]; then
	onlyDownloadOPTION="$onlyDownloadPROPERTY"
fi
if [[ -n $installNowMANAGED ]]; then
	installNowOPTION="$installNowMANAGED"
elif [[ -z $installNowOPTION ]] && [[ -n $installNowPROPERTY ]]; then
	installNowOPTION="$installNowPROPERTY"
fi
if [[ -n $policyTriggersMANAGED ]]; then
	policyTriggersOPTION="$policyTriggersMANAGED"
elif [[ -z $policyTriggersOPTION ]] && [[ -n $policyTriggersPROPERTY ]]; then
	policyTriggersOPTION="$policyTriggersPROPERTY"
fi
if [[ -n $skipUpdatesMANAGED ]]; then
	skipUpdatesOPTION="$skipUpdatesMANAGED"
elif [[ -z $skipUpdatesOPTION ]] && [[ -n $skipUpdatesPROPERTY ]]; then
	skipUpdatesOPTION="$skipUpdatesPROPERTY"
fi
if [[ -n $restartWithoutUpdatesMANAGED ]]; then
	restartWithoutUpdatesOPTION="$restartWithoutUpdatesMANAGED"
elif [[ -z $restartWithoutUpdatesOPTION ]] && [[ -n $restartWithoutUpdatesPROPERTY ]]; then
	restartWithoutUpdatesOPTION="$restartWithoutUpdatesPROPERTY"
fi
if [[ -n $freeSpaceUpdateMANAGED ]]; then
	freeSpaceUpdateOPTION="$freeSpaceUpdateMANAGED"
elif [[ -z $freeSpaceUpdateOPTION ]] && [[ -n $freeSpaceUpdatePROPERTY ]]; then
	freeSpaceUpdateOPTION="$freeSpaceUpdatePROPERTY"
fi
if [[ -n $freeSpaceUpgradeMANAGED ]]; then
	freeSpaceUpgradeOPTION="$freeSpaceUpgradeMANAGED"
elif [[ -z $freeSpaceUpgradeOPTION ]] && [[ -n $freeSpaceUpgradePROPERTY ]]; then
	freeSpaceUpgradeOPTION="$freeSpaceUpgradePROPERTY"
fi
if [[ -n $freeSpaceTimeoutMANAGED ]]; then
	freeSpaceTimeoutOPTION="$freeSpaceTimeoutMANAGED"
elif [[ -z $freeSpaceTimeoutOPTION ]] && [[ -n $freeSpaceTimeoutPROPERTY ]]; then
	freeSpaceTimeoutOPTION="$freeSpaceTimeoutPROPERTY"
fi
if [[ -n $batteryLevelMANAGED ]]; then
	batteryLevelOPTION="$batteryLevelMANAGED"
elif [[ -z $batteryLevelOPTION ]] && [[ -n $batteryLevelPROPERTY ]]; then
	batteryLevelOPTION="$batteryLevelPROPERTY"
fi
if [[ -n $batteryTimeoutMANAGED ]]; then
	batteryTimeoutOPTION="$batteryTimeoutMANAGED"
elif [[ -z $batteryTimeoutOPTION ]] && [[ -n $batteryTimeoutPROPERTY ]]; then
	batteryTimeoutOPTION="$batteryTimeoutPROPERTY"
fi
if [[ -n $testModeMANAGED ]]; then
	testModeOPTION="$testModeMANAGED"
elif [[ -z $testModeOPTION ]] && [[ -n $testModePROPERTY ]]; then
	testModeOPTION="$testModePROPERTY"
fi
if [[ -n $testModeTimeoutMANAGED ]]; then
	testModeTimeoutOPTION="$testModeTimeoutMANAGED"
elif [[ -z $testModeTimeoutOPTION ]] && [[ -n $testModeTimeoutPROPERTY ]]; then
	testModeTimeoutOPTION="$testModeTimeoutPROPERTY"
fi
if [[ -n $verboseModeMANAGED ]]; then
	verboseModeOPTION="$verboseModeMANAGED"
elif [[ -z $verboseModeOPTION ]] && [[ -n $verboseModePROPERTY ]]; then
	verboseModeOPTION="$verboseModePROPERTY"
fi
}

# Validate non-credential parameters and manage $superPLIST. Any errors set $parameterERROR.
manageParameters() {
parameterERROR="FALSE"

# Various regular expressions used for parameter validation.
regexNUMBER="^[0-9]+$"
regexMENU="^[0-9*,]+$"
regexDATE="^[0-9][0-9][0-9][0-9]-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$"
regexTIME="^(2[0-3]|[01][0-9]):[0-5][0-9]$"
regexDATETIME="^[0-9][0-9][0-9][0-9]-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]):(2[0-3]|[01][0-9]):[0-5][0-9]$"
regexMACOSMAJORVERSION="^([1][1-9])$"

# Validate $defaultDeferOPTION input and if valid override default $defaultDeferSECONDS parameter and save to $superPLIST.
if [[ "$defaultDeferOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for default deferral."
	defaults delete "$superPLIST" DefaultDefer 2> /dev/null
elif [[ -n $defaultDeferOPTION ]] && [[ $defaultDeferOPTION =~ $regexNUMBER ]]; then
	if [[ $defaultDeferOPTION -lt 120 ]]; then
		sendToLog "Warning: Specified default deferral time of $defaultDeferOPTION seconds is too low, rounding up to 120 seconds."
		defaultDeferSECONDS=120
	elif [[ $defaultDeferOPTION -gt 86400 ]]; then
		sendToLog "Warning: Specified default deferral time of $defaultDeferOPTION seconds is too high, rounding down to 86400 seconds (1 day)."
		defaultDeferSECONDS=86400
	else
		defaultDeferSECONDS=$defaultDeferOPTION
	fi
	defaults write "$superPLIST" DefaultDefer -string "$defaultDeferSECONDS"
elif [[ -n $defaultDeferOPTION ]] && ! [[ $defaultDeferOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The default deferral time must only be a number."; parameterERROR="TRUE"
fi

# Validate $focusDeferOPTION input and if valid set $focusDeferSECONDS and save to $superPLIST.
if [[ "$focusDeferOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for Focus deferral."
	defaults delete "$superPLIST" FocusDefer 2> /dev/null
elif [[ -n $focusDeferOPTION ]] && [[ $focusDeferOPTION =~ $regexNUMBER ]]; then
	if [[ $focusDeferOPTION -lt 120 ]]; then
		sendToLog "Warning: Specified focus deferral time of $focusDeferOPTION seconds is too low, rounding up to 120 seconds."
		focusDeferSECONDS=120
	elif [[ $focusDeferOPTION -gt 86400 ]]; then
		sendToLog "Warning: Specified focus deferral time of $focusDeferOPTION seconds is too high, rounding down to 86400 seconds (1 day)."
		focusDeferSECONDS=86400
	else
		focusDeferSECONDS=$focusDeferOPTION
	fi
	defaults write "$superPLIST" FocusDefer -string "$focusDeferSECONDS"
elif [[ -n $focusDeferOPTION ]] && ! [[ $focusDeferOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The focus deferral time must only be a number."; parameterERROR="TRUE"
fi

# Validate $menuDeferOPTION input and if valid set $menuDeferSECONDS and save to $superPLIST.
if [[ "$menuDeferOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for menu deferral."
	defaults delete "$superPLIST" MenuDefer 2> /dev/null
elif [[ -n $menuDeferOPTION ]] && [[ $menuDeferOPTION =~ $regexMENU ]]; then
	oldIFS="$IFS"; IFS=','
	read -r -a menuDeferARRAY <<< "$menuDeferOPTION"
	for i in "${!menuDeferARRAY[@]}"; do
		if [[ ${menuDeferARRAY[i]} -lt 120 ]]; then
			sendToLog "Warning: Specified menu deferral time of ${menuDeferARRAY[i]} seconds is too low, rounding up to 120 seconds."
			menuDeferARRAY[i]=120
		elif [[ ${menuDeferARRAY[i]} -gt 86400 ]]; then
			sendToLog "Warning: Specified menu deferral time of ${menuDeferARRAY[i]} seconds is too high, rounding down to 86400 seconds (1 day)."
			menuDeferARRAY[i]=86400
		fi
	done
	menuDeferSECONDS="${menuDeferARRAY[*]}"
	defaults write "$superPLIST" MenuDefer -string "$menuDeferSECONDS"
	IFS="$oldIFS"
elif [[ -n $menuDeferOPTION ]] && ! [[ $menuDeferOPTION =~ $regexMENU ]]; then
	sendToLog "Parameter Error: The defer pop-up menu time(s) must only contain numbers and commas (no spaces)."; parameterERROR="TRUE"
fi

# Validate $recheckDeferOPTION input and if valid set $recheckDeferSECONDS and save to $superPLIST.
if [[ "$recheckDeferOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for recheck deferral."
	defaults delete "$superPLIST" RecheckDefer 2> /dev/null
elif [[ -n $recheckDeferOPTION ]] && [[ $recheckDeferOPTION =~ $regexNUMBER ]]; then
	if [[ $recheckDeferOPTION -lt 120 ]]; then
		sendToLog "Warning: Specified recheck deferral time of $recheckDeferOPTION seconds is too low, rounding up to 120 seconds."
		recheckDeferSECONDS=120
	elif [[ $recheckDeferOPTION -gt 2628288 ]]; then
		sendToLog "Warning: Specified recheck deferral time of $recheckDeferOPTION seconds is too high, rounding down to 2628288 seconds (30 days)."
		recheckDeferSECONDS=2628288
	else
		recheckDeferSECONDS=$recheckDeferOPTION
	fi
	defaults write "$superPLIST" RecheckDefer -string "$recheckDeferSECONDS"
elif [[ -n $recheckDeferOPTION ]] && ! [[ $recheckDeferOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The recheck deferral time must only be a number."; parameterERROR="TRUE"
fi

# Validate $errorDeferOPTION input and if valid override default $errorDeferSECONDS parameter and save to $superPLIST.
if [[ "$errorDeferOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for error deferral."
	defaults delete "$superPLIST" ErrorDefer 2> /dev/null
elif [[ -n $errorDeferOPTION ]] && [[ $errorDeferOPTION =~ $regexNUMBER ]]; then
	if [[ $errorDeferOPTION -lt 120 ]]; then
		sendToLog "Warning: Specified error deferral time of $errorDeferOPTION seconds is too low, rounding up to 120 seconds."
		errorDeferSECONDS=120
	elif [[ $errorDeferOPTION -gt 86400 ]]; then
		sendToLog "Warning: Specified error deferral time of $errorDeferOPTION seconds is too high, rounding down to 86400 seconds (1 day)."
		errorDeferSECONDS=86400
	else
		errorDeferSECONDS=$errorDeferOPTION
	fi
	defaults write "$superPLIST" ErrorDefer -string "$errorDeferSECONDS"
elif [[ -n $errorDeferOPTION ]] && ! [[ $errorDeferOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The error deferral time must only be a number."; parameterERROR="TRUE"
fi

# Validated that $recheckDeferOPTION and $skipUpdatesOPTION are not both active.
if [[ -n $recheckDeferOPTION ]] && [[ "$skipUpdatesOPTION" == "TRUE" ]]; then
	sendToLog "Parameter Error: You can not specify both the --recheck-defer and --skip-updates options at the same time."; parameterERROR="TRUE"
fi

# Validate $focusCountOPTION input and if valid set $focusCountMAX and save to $superPLIST.
if [[ "$focusCountOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for focus count deadline."
	defaults delete "$superPLIST" FocusCount 2> /dev/null
elif [[ -n $focusCountOPTION ]] && [[ $focusCountOPTION =~ $regexNUMBER ]]; then
	focusCountMAX=$focusCountOPTION
	defaults write "$superPLIST" FocusCount -string "$focusCountMAX"
elif [[ -n $focusCountOPTION ]] && ! [[ $focusCountOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The focus count deadline must only be a number."; parameterERROR="TRUE"
fi

# Validate $softCountOPTION input and if valid set $softCountMAX.
if [[ "$softCountOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for soft count deadline."
	defaults delete "$superPLIST" SoftCount 2> /dev/null
elif [[ -n $softCountOPTION ]] && [[ $softCountOPTION =~ $regexNUMBER ]]; then
	softCountMAX=$softCountOPTION
elif [[ -n $softCountOPTION ]] && ! [[ $softCountOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The soft count deadline must only be a number."; parameterERROR="TRUE"
fi

# Validate $hardCountOPTION input and if valid set $hardCountMAX.
if [[ "$hardCountOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for hard count deadline."
	defaults delete "$superPLIST" HardCount 2> /dev/null
elif [[ -n $hardCountOPTION ]] && [[ $hardCountOPTION =~ $regexNUMBER ]]; then
	hardCountMAX=$hardCountOPTION
elif [[ -n $hardCountOPTION ]] && ! [[ $hardCountOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The hard count deadline must only be a number."; parameterERROR="TRUE"
fi

# Validated that $softCountMAX and $hardCountMAX are not both active, if not then save $softCountMAX or $hardCountMAX to $superPLIST.
if [[ -n $softCountMAX ]] && [[ -n $hardCountMAX ]]; then
	sendToLog "Parameter Error: There cannot be simultaneous deferral maximums for both soft count and hard count deadlines. You must pick one maximum deferral count behavior."; parameterERROR="TRUE"
else
	[[ -n $softCountMAX ]] && defaults write "$superPLIST" SoftCount -string "$softCountMAX"
	[[ -n $hardCountMAX ]] && defaults write "$superPLIST" HardCount -string "$hardCountMAX"
fi

# Validate $focusDaysOPTION input and if valid set $focusDaysMAX and $focusDaysSECONDS.
if [[ "$focusDaysOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for focus days deadline."
	defaults delete "$superPLIST" FocusDays 2> /dev/null
elif [[ -n $focusDaysOPTION ]] && [[ $focusDaysOPTION =~ $regexNUMBER ]]; then
	focusDaysMAX=$focusDaysOPTION
	focusDaysSECONDS=$((focusDaysMAX*86400))
elif [[ -n $focusDaysOPTION ]] && ! [[ $focusDaysOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The focus days deadline must only be a number."; parameterERROR="TRUE"
fi

# Validate $softDaysOPTION input and if valid set $softDaysMAX and $softDaysSECONDS.
if [[ "$softDaysOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for soft days deadline."
	defaults delete "$superPLIST" SoftDays 2> /dev/null
elif [[ -n $softDaysOPTION ]] && [[ $softDaysOPTION =~ $regexNUMBER ]]; then
	softDaysMAX=$softDaysOPTION
	softDaysSECONDS=$((softDaysMAX*86400))
elif [[ -n $softDaysOPTION ]] && ! [[ $softDaysOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The soft days deadline must only be a number."; parameterERROR="TRUE"
fi

# Validate $hardDaysOPTION input and if valid set $hardDaysMAX and $hardDaysSECONDS.
if [[ "$hardDaysOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for hard days deadline."
	defaults delete "$superPLIST" HardDays 2> /dev/null
elif [[ -n $hardDaysOPTION ]] && [[ $hardDaysOPTION =~ $regexNUMBER ]]; then
	hardDaysMAX=$hardDaysOPTION
	hardDaysSECONDS=$((hardDaysMAX*86400))
elif [[ -n $hardDaysOPTION ]] && ! [[ $hardDaysOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The hard days deadline must only be a number."; parameterERROR="TRUE"
fi

# Validate $focusDaysMAX, $softDaysMAX, and $hardDaysMAX in relation to each other. If valid then save maximum day deadlines to $superPLIST.
if [[ -n $hardDaysMAX ]] && [[ -n $softDaysMAX ]] && [[ $hardDaysMAX -le $softDaysMAX ]]; then
	sendToLog "Parameter Error: The maximum hard days deadline of $hardDaysMAX day(s) must be more than the maximum soft days deadline of $softDaysMAX day(s)."; parameterERROR="TRUE"
fi
if [[ -n $hardDaysMAX ]] && [[ -n $focusDaysMAX ]] && [[ $hardDaysMAX -le $focusDaysMAX ]]; then
	sendToLog "Parameter Error: The maximum hard days deadline of $hardDaysMAX day(s) must be more than the maximum focus days deadline of $focusDaysMAX day(s)."; parameterERROR="TRUE"
fi
if [[ -n $softDaysMAX ]] && [[ -n $focusDaysMAX ]] && [[ $softDaysMAX -le $focusDaysMAX ]]; then
	sendToLog "Parameter Error: The maximum soft days deadline of $softDaysMAX day(s) must be more than the maximum focus days deadline of $focusDaysMAX day(s)."; parameterERROR="TRUE"
fi
if [[ "$parameterERROR" != "TRUE" ]]; then
	[[ -n $focusDaysMAX ]] && defaults write "$superPLIST" FocusDays -string "$focusDaysMAX"
	[[ -n $softDaysMAX ]] && defaults write "$superPLIST" SoftDays -string "$softDaysMAX"
	[[ -n $hardDaysMAX ]] && defaults write "$superPLIST" HardDays -string "$hardDaysMAX"
fi

# Validate $zeroDayOPTION, and if valid set $zeroDayOVERRIDE.
if [[ "$zeroDayOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for manual zero day override date."
	defaults delete "$superPLIST" ZeroDay 2> /dev/null
elif [[ -n $zeroDayOPTION ]]; then
	extractDATE=$(echo "$zeroDayOPTION" | cut -c-10 )
	if [[ $extractDATE =~ $regexDATE ]]; then
		extractTIME=$(echo "$zeroDayOPTION" | cut -c11- )
		if [[ -n $extractTIME ]]; then
			extractHOURS=$(echo "$extractTIME" | cut -d: -f2)
			[[ -z $extractHOURS ]] && extractHOURS="00"
			extractMINUTES=$(echo "$extractTIME" | cut -d: -f3)
			[[ -z $extractMINUTES ]] && extractMINUTES="00"
			extractTIME="$extractHOURS:$extractMINUTES"
		else
			extractTIME="00:00"
		fi
		if [[ $extractTIME =~ $regexTIME ]]; then
			calculatedDEADLINE="$extractDATE:$extractTIME"
		else
			sendToLog "Parameter Error: The manual zero day override date time must be a valid 24-hour time formatted as hh:mm."; parameterERROR="TRUE"
		fi
	else
		sendToLog "Parameter Error: The manual zero day override date must be a valid date formatted as YYYY-MM-DD."; parameterERROR="TRUE"
	fi
	if [[ $calculatedDEADLINE =~ $regexDATETIME ]]; then
		zeroDayOVERRIDE="$calculatedDEADLINE"
	else
		sendToLog "Parameter Error: The manual zero day override date must be a valid and formatted as YYYY-MM-DD:hh:mm."; parameterERROR="TRUE"
	fi
fi

# Validate that any $zeroDayOVERRIDE also includes a day deadline, if valid save to $superPLIST.
if { [[ -z $focusDaysMAX ]] && [[ -z $softDaysMAX ]] && [[ -z $hardDaysMAX ]]; } && [[ -n $zeroDayOVERRIDE ]]; then
	sendToLog "Parameter Error: Specifying a manual zero day date also requires that you set a day deadline."; parameterERROR="TRUE"
fi
if [[ "$parameterERROR" != "TRUE" ]]; then
	[[ -n $zeroDayOVERRIDE ]] && defaults write "$superPLIST" ZeroDay -string "$zeroDayOVERRIDE"
fi

# Validate $focusDateOPTION, if valid set $focusDateMAX and $focusDateEPOCH.
if [[ "$focusDateOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for focus date deadline."
	defaults delete "$superPLIST" FocusDate 2> /dev/null
elif [[ -n $focusDateOPTION ]]; then
	extractDATE=$(echo "$focusDateOPTION" | cut -c-10 )
	if [[ $extractDATE =~ $regexDATE ]]; then
		extractTIME=$(echo "$focusDateOPTION" | cut -c11- )
		if [[ -n $extractTIME ]]; then
			extractHOURS=$(echo "$extractTIME" | cut -d: -f2)
			[[ -z $extractHOURS ]] && extractHOURS="00"
			extractMINUTES=$(echo "$extractTIME" | cut -d: -f3)
			[[ -z $extractMINUTES ]] && extractMINUTES="00"
			extractTIME="$extractHOURS:$extractMINUTES"
		else
			extractTIME="00:00"
		fi
		if [[ $extractTIME =~ $regexTIME ]]; then
			calculatedDEADLINE="$extractDATE:$extractTIME"
		else
			sendToLog "Parameter Error: The focus date deadline time must be a valid 24-hour time formatted as hh:mm."; parameterERROR="TRUE"
		fi
	else
		sendToLog "Parameter Error: The focus date deadline date must be a valid date formatted as YYYY-MM-DD."; parameterERROR="TRUE"
	fi
	if [[ $calculatedDEADLINE =~ $regexDATETIME ]]; then
		focusDateMAX="$calculatedDEADLINE"
		focusDateEPOCH=$(date -j -f "%Y-%m-%d:%H:%M" "$calculatedDEADLINE" +"%s")
	else
		sendToLog "Parameter Error: The focus date deadline must be a valid and formatted as YYYY-MM-DD:hh:mm."; parameterERROR="TRUE"
	fi
fi

# Validate $softDateOPTION, if valid set $softDateMAX and $softDateEPOCH.
if [[ "$softDateOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for soft date deadline."
	defaults delete "$superPLIST" SoftDate 2> /dev/null
elif [[ -n $softDateOPTION ]]; then
	extractDATE=$(echo "$softDateOPTION" | cut -c-10 )
	if [[ $extractDATE =~ $regexDATE ]]; then
		extractTIME=$(echo "$softDateOPTION" | cut -c11- )
		if [[ -n $extractTIME ]]; then
			extractHOURS=$(echo "$extractTIME" | cut -d: -f2)
			[[ -z $extractHOURS ]] && extractHOURS="00"
			extractMINUTES=$(echo "$extractTIME" | cut -d: -f3)
			[[ -z $extractMINUTES ]] && extractMINUTES="00"
			extractTIME="$extractHOURS:$extractMINUTES"
		else
			extractTIME="00:00"
		fi
		if [[ $extractTIME =~ $regexTIME ]]; then
			calculatedDEADLINE="$extractDATE:$extractTIME"
		else
			sendToLog "Parameter Error: The soft date deadline time must be a valid 24-hour time formatted as hh:mm."; parameterERROR="TRUE"
		fi
	else
		sendToLog "Parameter Error: The soft date deadline date must be a valid date formatted as YYYY-MM-DD."; parameterERROR="TRUE"
	fi
	if [[ $calculatedDEADLINE =~ $regexDATETIME ]]; then
		softDateMAX="$calculatedDEADLINE"
		softDateEPOCH=$(date -j -f "%Y-%m-%d:%H:%M" "$calculatedDEADLINE" +"%s")
	else
		sendToLog "Parameter Error: The soft date deadline must be a valid and formatted as YYYY-MM-DD:hh:mm."; parameterERROR="TRUE"
	fi
fi

# Validate $hardDateOPTION, if valid set $hardDateMAX and $hardDateEPOCH.
if [[ "$hardDateOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for hard date deadline."
	defaults delete "$superPLIST" HardDate 2> /dev/null
elif [[ -n $hardDateOPTION ]]; then
	extractDATE=$(echo "$hardDateOPTION" | cut -c-10 )
	if [[ $extractDATE =~ $regexDATE ]]; then
		extractTIME=$(echo "$hardDateOPTION" | cut -c11- )
		if [[ -n $extractTIME ]]; then
			extractHOURS=$(echo "$extractTIME" | cut -d: -f2)
			[[ -z $extractHOURS ]] && extractHOURS="00"
			extractMINUTES=$(echo "$extractTIME" | cut -d: -f3)
			[[ -z $extractMINUTES ]] && extractMINUTES="00"
			extractTIME="$extractHOURS:$extractMINUTES"
		else
			extractTIME="00:00"
		fi
		if [[ $extractTIME =~ $regexTIME ]]; then
			calculatedDEADLINE="$extractDATE:$extractTIME"
		else
			sendToLog "Parameter Error: The hard date deadline time must be a valid 24-hour time formatted as hh:mm."; parameterERROR="TRUE"
		fi
	else
		sendToLog "Parameter Error: The hard date deadline date must be a valid date formatted as YYYY-MM-DD."; parameterERROR="TRUE"
	fi
	if [[ $calculatedDEADLINE =~ $regexDATETIME ]]; then
		hardDateMAX="$calculatedDEADLINE"
		hardDateEPOCH=$(date -j -f "%Y-%m-%d:%H:%M" "$calculatedDEADLINE" +"%s")
	else
		sendToLog "Parameter Error: The hard date deadline must be a valid and formatted as YYYY-MM-DD:hh:mm."; parameterERROR="TRUE"
	fi
fi

# Validate $focusDateEPOCH, $softDateEPOCH, and $hardDateEPOCH in relation to each other. If valid then save date deadlines to $superPLIST.
if [[ -n $hardDateEPOCH ]] && [[ -n $softDateEPOCH ]] && [[ $hardDateEPOCH -le $softDateEPOCH ]]; then
	sendToLog "Parameter Error: The hard date deadline of $hardDateMAX must be later than the soft date deadline of $softDateMAX."; parameterERROR="TRUE"
fi
if [[ -n $hardDateEPOCH ]] && [[ -n $focusDateEPOCH ]] && [[ $hardDateEPOCH -le $focusDateEPOCH ]]; then
	sendToLog "Parameter Error: The hard date deadline of $hardDateMAX must be later than the focus date deadline of $focusDateMAX."; parameterERROR="TRUE"
fi
if [[ -n $softDateEPOCH ]] && [[ -n $focusDateEPOCH ]] && [[ $softDateEPOCH -le $focusDateEPOCH ]]; then
	sendToLog "Parameter Error: The soft date deadline of $softDateMAX must be later than the focus date deadline of $focusDateMAX."; parameterERROR="TRUE"
fi
if [[ "$parameterERROR" != "TRUE" ]]; then
	[[ -n $focusDateMAX ]] && defaults write "$superPLIST" FocusDate -string "$focusDateMAX"
	[[ -n $softDateMAX ]] && defaults write "$superPLIST" SoftDate -string "$softDateMAX"
	[[ -n $hardDateMAX ]] && defaults write "$superPLIST" HardDate -string "$hardDateMAX"
fi

# Validate that any focus deadlines also include a coordinating $focusDeferSECONDS, if not then set $focusDeferSECONDS to $defaultDeferSECONDS.
if { [[ -n $focusCountMAX ]] || [[ -n $focusDaysMAX ]] || [[ -n $focusDateMAX ]]; } && [[ -z $focusDeferSECONDS ]]; then
	sendToLog "Warning: No focus defer seconds specified, setting to default defer of $defaultDeferSECONDS seconds."
	focusDeferSECONDS="$defaultDeferSECONDS"
fi

# Validate $deferDialogTimeoutOPTION and if valid set $deferDialogTimeoutSECONDS.
if [[ "$deferDialogTimeoutOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for restart/defer dialog timeout."
	defaults delete "$superPLIST" DeferDialogTimeout 2> /dev/null
elif [[ -n $deferDialogTimeoutOPTION ]] && [[ $deferDialogTimeoutOPTION =~ $regexNUMBER ]]; then
	if [[ $deferDialogTimeoutOPTION -lt 60 ]]; then
		sendToLog "Warning: Specified restart/defer dialog timeout of $deferDialogTimeoutOPTION seconds is too low, rounding up to 60 seconds."
		deferDialogTimeoutSECONDS=60
	elif [[ $deferDialogTimeoutOPTION -gt 86400 ]]; then
		sendToLog "Warning: Specified restart/defer dialog timeout of $deferDialogTimeoutOPTION seconds is too high, rounding down to 86400 seconds (1 day)."
		deferDialogTimeoutSECONDS=86400
	else
		deferDialogTimeoutSECONDS=$deferDialogTimeoutOPTION
	fi
	defaults write "$superPLIST" DeferDialogTimeout -string "$deferDialogTimeoutSECONDS"
elif [[ -n $deferDialogTimeoutOPTION ]] && ! [[ $deferDialogTimeoutOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The restart/defer dialog timeout must only be a number."; parameterERROR="TRUE"
fi
if [[ "$parameterERROR" != "TRUE" ]] && [[ -n $deferDialogTimeoutSECONDS ]] && [[ -n $displayRedrawSECONDS ]]; then
	displayMinimumTIMEOUT=$((displayRedrawSECONDS * 3))
	if [[ $deferDialogTimeoutSECONDS -lt $displayMinimumTIMEOUT ]];then
		sendToLog "Warning: Specified restart/defer dialog timeout of $deferDialogTimeoutSECONDS seconds is too low given a display redraw of $displayRedrawSECONDS seconds, changing restart/defer dialog timeout to $displayMinimumTIMEOUT seconds."
		deferDialogTimeoutSECONDS=$displayMinimumTIMEOUT
		defaults write "$superPLIST" DeferDialogTimeout -string "$deferDialogTimeoutSECONDS"
	fi
fi

# Validate $softDialogTimeoutOPTION and if valid set $softDialogTimeoutSECONDS.
if [[ "$softDialogTimeoutOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for soft deadline dialog timeout."
	defaults delete "$superPLIST" SoftDialogTimeout 2> /dev/null
elif [[ -n $softDialogTimeoutOPTION ]] && [[ $softDialogTimeoutOPTION =~ $regexNUMBER ]]; then
	if [[ $softDialogTimeoutOPTION -lt 60 ]]; then
		sendToLog "Warning: Specified soft deadline dialog timeout of $softDialogTimeoutOPTION seconds is too low, rounding up to 60 seconds."
		softDialogTimeoutSECONDS=60
	elif [[ $softDialogTimeoutOPTION -gt 86400 ]]; then
		sendToLog "Warning: Specified soft deadline dialog timeout of $softDialogTimeoutOPTION seconds is too high, rounding down to 86400 seconds (1 day)."
		softDialogTimeoutSECONDS=86400
	else
		softDialogTimeoutSECONDS=$softDialogTimeoutOPTION
	fi
	defaults write "$superPLIST" SoftDialogTimeout -string "$softDialogTimeoutSECONDS"
elif [[ -n $softDialogTimeoutOPTION ]] && ! [[ $softDialogTimeoutOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The soft deadline dialog timeout must only be a number."; parameterERROR="TRUE"
fi
if [[ "$parameterERROR" != "TRUE" ]] && [[ -n $softDialogTimeoutSECONDS ]] && [[ -n $displayRedrawSECONDS ]]; then
	displayMinimumTIMEOUT=$((displayRedrawSECONDS * 3))
	if [[ $softDialogTimeoutSECONDS -lt $displayMinimumTIMEOUT ]];then
		sendToLog "Warning: Specified soft deadline dialog timeout of $softDialogTimeoutSECONDS seconds is too low given a display redraw of $displayRedrawSECONDS seconds, changing soft deadline dialog timeout to $displayMinimumTIMEOUT seconds."
		softDialogTimeoutSECONDS=$displayMinimumTIMEOUT
		defaults write "$superPLIST" SoftDialogTimeout -string "$softDialogTimeoutSECONDS"
	fi
fi

# Validate $displayRedrawOPTION input and if valid set $displayRedrawSECONDS.
if [[ "$displayRedrawOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for display redraw."
	defaults delete "$superPLIST" DisplayRedraw 2> /dev/null
elif [[ -n $displayRedrawOPTION ]] && [[ $displayRedrawOPTION =~ $regexNUMBER ]]; then
	if [[ $displayRedrawOPTION -lt 10 ]]; then
		sendToLog "Warning: Specified display redraw of $displayRedrawOPTION seconds is too low, rounding up to 10 seconds."
		displayRedrawSECONDS=10
	elif [[ $displayRedrawOPTION -gt 3600 ]]; then
		sendToLog "Warning: Specified display redraw of $displayRedrawOPTION seconds is too high, rounding down to 3600 seconds (1 hour)."
		displayRedrawSECONDS=3600
	else
		displayRedrawSECONDS=$displayRedrawOPTION
	fi
	defaults write "$superPLIST" DisplayRedraw -string "$displayRedrawSECONDS"
elif [[ -n $displayRedrawOPTION ]] && ! [[ $displayRedrawOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The display redraw time must only be a number."; parameterERROR="TRUE"
fi

# Verify the $displayIconOPTION to be used for the super service account and in notifications and dialogs, and if valid copy and set $cachedICON and save to $superPLIST.
if [[ "$displayIconOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting cached display icon."
	[[ -f "$cachedICON" ]] && rm -f "$cachedICON"
elif [[ -n "$displayIconOPTION" ]] && [[ "$displayIconOPTION" != "$(defaults read "$superPLIST" DisplayIconCache 2> /dev/null)" ]]; then
	if [[ $(echo "$displayIconOPTION" | grep -c '^http://\|^https://') -gt 0 ]]; then
		sendToLog "Startup: Attempting to download requested icon from: $displayIconOPTION"
		downloadRESULT=$(curl "$displayIconOPTION" -L -o "/tmp/cachedICON" 2>&1)
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: downloadRESULT is:\n$downloadRESULT"
		if [[ -f "/tmp/cachedICON" ]]; then
			sipsRESULT=$(sips -s format png "/tmp/cachedICON" --out "$cachedICON" 2>&1)
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: sipsRESULT is:\n$sipsRESULT"
			defaults write "$superPLIST" DisplayIconCache -string "$displayIconOPTION"
		else
			sendToLog "Warning: Unable to download specified icon from: $displayIconOPTION"
		fi
	elif [[ -e "$displayIconOPTION" ]]; then
		sendToLog "Startup: Copying requested icon from: $displayIconOPTION"
		sipsRESULT=$(sips -s format png "$displayIconOPTION" --out "$cachedICON" 2>&1)
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: sipsRESULT is:\n$sipsRESULT"
		defaults write "$superPLIST" DisplayIconCache -string "$displayIconOPTION"
	else
		sendToLog "Warning: Unable to locate specified icon from: $displayIconOPTION"
	fi
fi
if [[ ! -f "$cachedICON" ]]; then
	sendToLog "Startup: No custom display icon found, copying default icon from: $defaultICON"
	sipsRESULT=$(sips -s format png "$defaultICON" --out "$cachedICON" 2>&1)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: sipsRESULT is:\n$sipsRESULT"
	defaults write "$superPLIST" DisplayIconCache -string "$defaultICON"
fi

# Validate $iconSizeIbmOPTION input and if valid override default $ibmNotifierIconSIZE parameter and save to $superPLIST.
if [[ "$iconSizeIbmOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for IBM Notifier icon size."
	defaults delete "$superPLIST" IconSizeIbm 2> /dev/null
elif [[ -n $iconSizeIbmOPTION ]] && [[ $iconSizeIbmOPTION =~ $regexNUMBER ]]; then
	if [[ $iconSizeIbmOPTION -lt 32 ]]; then
		sendToLog "Warning: Specified IBM Notifier icon size of $iconSizeIbmOPTION pixels is too low, rounding up to 32 pixels."
		ibmNotifierIconSIZE=32
	elif [[ $iconSizeIbmOPTION -gt 150 ]]; then
		sendToLog "Warning: Specified IBM Notifier icon size of $iconSizeIbmOPTION pixels is too high, rounding down to 150 pixels."
		ibmNotifierIconSIZE=150
	else
		ibmNotifierIconSIZE=$iconSizeIbmOPTION
	fi
	defaults write "$superPLIST" IconSizeIbm -string "$ibmNotifierIconSIZE"
elif [[ -n $iconSizeIbmOPTION ]] && ! [[ $iconSizeIbmOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The IBM Notifier icon size must only be a number."; parameterERROR="TRUE"
fi

# Validate $iconSizeJamfOPTION input and if valid override default $jamfHelperIconSIZE parameter and save to $superPLIST.
if [[ "$iconSizeJamfOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for IBM Notifier icon size."
	defaults delete "$superPLIST" IconSizeJamf 2> /dev/null
elif [[ -n $iconSizeJamfOPTION ]] && [[ $iconSizeJamfOPTION =~ $regexNUMBER ]]; then
	if [[ $iconSizeJamfOPTION -lt 32 ]]; then
		sendToLog "Warning: Specified IBM Notifier icon size of $iconSizeJamfOPTION pixels is too low, rounding up to 32 pixels."
		jamfHelperIconSIZE=32
	elif [[ $iconSizeJamfOPTION -gt 150 ]]; then
		sendToLog "Warning: Specified IBM Notifier icon size of $iconSizeJamfOPTION pixels is too high, rounding down to 150 pixels."
		jamfHelperIconSIZE=150
	else
		jamfHelperIconSIZE=$iconSizeJamfOPTION
	fi
	defaults write "$superPLIST" IconSizeJamf -string "$jamfHelperIconSIZE"
elif [[ -n $iconSizeJamfOPTION ]] && ! [[ $iconSizeJamfOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The IBM Notifier icon size must only be a number."; parameterERROR="TRUE"
fi

# Validate $displayAccessoryTypeOPTION, $displayAccessoryDefaultOPTION, $displayAccessoryUpdateOPTION, and $displayAccessoryUpgradeOPTION.
if [[ "$displayAccessoryTypeOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for display accessory."
	defaults delete "$superPLIST" DisplayAccessoryType 2> /dev/null
	unset displayAccessoryTypeOPTION
fi
if [[ "$displayAccessoryDefaultOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for display accessory default content."
	defaults delete "$superPLIST" DisplayAccessoryDefault 2> /dev/null
	unset displayAccessoryDefaultOPTION
fi
if [[ "$displayAccessoryUpdateOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for display accessory update content."
	defaults delete "$superPLIST" DisplayAccessoryUpdate 2> /dev/null
	unset displayAccessoryUpdateOPTION
fi
if [[ "$displayAccessoryUpgradeOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for display accessory upgrade content."
	defaults delete "$superPLIST" DisplayAccessoryUpgrade 2> /dev/null
	unset displayAccessoryUpgradeOPTION
fi
if [[ "$displayAccessoryUserAuthOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for display accessory user authentication content."
	defaults delete "$superPLIST" DisplayAccessoryUserAuth 2> /dev/null
	unset displayAccessoryUserAuthOPTION
fi
if [[ -n $displayAccessoryTypeOPTION ]] && [[ -z $displayAccessoryDefaultOPTION ]] && [[ -z $displayAccessoryUpdateOPTION ]] && [[ -z $displayAccessoryUpgradeOPTION ]] && [[ -z $displayAccessoryUserAuthOPTION ]]; then
	sendToLog "Parameter Error: To use a display accessory type you must also specify one of the display accessory content options."; parameterERROR="TRUE"
fi
if [[ -z $displayAccessoryTypeOPTION ]] && { [[ -n $displayAccessoryDefaultOPTION ]] || [[ -n $displayAccessoryUpdateOPTION ]] || [[ -n $displayAccessoryUpgradeOPTION ]] || [[ -n $displayAccessoryUserAuthOPTION ]]; }; then
	sendToLog "Parameter Error: To use any of the display accessory content options you must also specify the display accessory type."; parameterERROR="TRUE"
fi
if [[ "$parameterERROR" != "TRUE" ]] && [[ -n $displayAccessoryTypeOPTION ]]; then
	if [[ $displayAccessoryTypeOPTION =~ ^TEXTBOX$|^HTMLBOX$|^HTML$|^IMAGE$|^VIDEO$|^VIDEOAUTO$ ]]; then
		displayAccessoryTYPE="$displayAccessoryTypeOPTION"
		defaults write "$superPLIST" DisplayAccessoryType -string "$displayAccessoryTypeOPTION"
	else
		sendToLog "Parameter Error: Unrecognized dialog display accessory type: $displayAccessoryTypeOPTION. You must specify one of the following; TEXTBOX, HTMLBOX, HTML, IMAGE, VIDEO, or VIDEOAUTO."; parameterERROR="TRUE"
	fi
fi
if [[ "$parameterERROR" != "TRUE" ]] && { [[ -n $displayAccessoryDefaultOPTION ]] || [[ -n $displayAccessoryUpdateOPTION ]] || [[ -n $displayAccessoryUpgradeOPTION ]] || [[ -n $displayAccessoryUserAuthOPTION ]]; }; then
	if [[ -n $displayAccessoryDefaultOPTION ]]; then
		displayAccessoryDefaultCONTENT="$displayAccessoryDefaultOPTION"
		defaults write "$superPLIST" DisplayAccessoryDefault -string "$displayAccessoryDefaultOPTION"
	fi
	if [[ -n $displayAccessoryUpdateOPTION ]]; then
		displayAccessoryUpdateCONTENT="$displayAccessoryUpdateOPTION"
		defaults write "$superPLIST" DisplayAccessoryUpdate -string "$displayAccessoryUpdateOPTION"
	fi
	if [[ -n $displayAccessoryUpgradeOPTION ]]; then
		displayAccessoryUpgradeCONTENT="$displayAccessoryUpgradeOPTION"
		defaults write "$superPLIST" DisplayAccessoryUpgrade -string "$displayAccessoryUpgradeOPTION"
	fi
	if [[ -n $displayAccessoryUserAuthOPTION ]]; then
		displayAccessoryUserAuthCONTENT="$displayAccessoryUserAuthOPTION"
		defaults write "$superPLIST" DisplayAccessoryUserAuth -string "$displayAccessoryUserAuthOPTION"
	fi
fi

# Validate $helpButtonOPTION and set $helpBUTTON and save to $superPLIST.
if [[ "$helpButtonOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for help button option."
	defaults delete "$superPLIST" HelpButton 2> /dev/null
elif [[ -n $helpButtonOPTION ]]; then
	helpBUTTON="$helpButtonOPTION"
	defaults write "$superPLIST" HelpButton -string "$helpButtonOPTION"	
fi

# Validate $warningButtonOPTION and set $warningBUTTON and save to $superPLIST.
if [[ "$warningButtonOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for help button option."
	defaults delete "$superPLIST" WarningButton 2> /dev/null
elif [[ -n $warningButtonOPTION ]]; then
	warningBUTTON="$warningButtonOPTION"
	defaults write "$superPLIST" WarningButton -string "$warningButtonOPTION"
fi

# Manage $displaySilentlyOPTION and save to $superPLIST.
if [[ $displaySilentlyOPTION -eq 1 ]] || [[ "$displaySilentlyOPTION" == "TRUE" ]]; then
	displaySilentlyOPTION="TRUE"
	defaults write "$superPLIST" DisplaySilently -bool true
else
	displaySilentlyOPTION="FALSE"
	defaults delete "$superPLIST" DisplaySilently 2> /dev/null
fi

# Validate $userAuthTimeoutOPTION input and if valid set $userAuthTimeoutSECONDS and save to $superPLIST.
if [[ "$userAuthTimeoutOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for user authentication dialog timeout seconds."
	defaults delete "$superPLIST" UserAuthTimeout 2> /dev/null
elif [[ -n $userAuthTimeoutOPTION ]] && [[ $userAuthTimeoutOPTION =~ $regexNUMBER ]]; then
	if [[ $userAuthTimeoutOPTION -lt 60 ]]; then
		sendToLog "Warning: Specified user authentication dialog timeout of $userAuthTimeoutOPTION seconds is too low, rounding up to 60 seconds."
		userAuthTimeoutSECONDS=60
	elif [[ $userAuthTimeoutOPTION -gt 86400 ]]; then
		sendToLog "Warning: Specified user authentication dialog timeout of $userAuthTimeoutOPTION seconds is too high, rounding down to 86400 seconds (1 day)."
		userAuthTimeoutSECONDS=86400
	else
		userAuthTimeoutSECONDS=$userAuthTimeoutOPTION
	fi
	defaults write "$superPLIST" UserAuthTimeout -string "$userAuthTimeoutSECONDS"
elif [[ -n $userAuthTimeoutOPTION ]] && ! [[ $userAuthTimeoutOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The user authentication dialog timeout seconds must only be a number."; parameterERROR="TRUE"
fi
if [[ "$parameterERROR" != "TRUE" ]] && [[ -n $displayRedrawSECONDS ]]; then
	displayMinimumTIMEOUT=$((displayRedrawSECONDS * 3))
	if [[ $userAuthTimeoutSECONDS -lt $displayMinimumTIMEOUT ]];then
		sendToLog "Warning: Specified user authentication dialog timeout of $userAuthTimeoutSECONDS seconds is too low given a display redraw of $displayRedrawSECONDS seconds, changing user authentication dialog timeout to $displayMinimumTIMEOUT seconds."
		userAuthTimeoutSECONDS=$displayMinimumTIMEOUT
		defaults write "$superPLIST" UserAuthTimeout -string "$userAuthTimeoutSECONDS"
	fi
fi

# Validate $userAuthMDMFailoverOPTION and $displayAccessoryContentOPTION.
userAuthMDMFAILOVER="FALSE"
if [[ "$userAuthMDMFailoverOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for user authentication MDM failover."
	defaults delete "$superPLIST" UserAuthMDMFailover 2> /dev/null
elif [[ -n $userAuthMDMFailoverOPTION ]]; then
	oldIFS="$IFS"; IFS=','
	read -r -a userAuthMDMFailoverARRAY <<< "$userAuthMDMFailoverOPTION"
	for option in "${userAuthMDMFailoverARRAY[@]}"; do
		if [[ $option =~ ^ALWAYS$ ]]; then
			userAuthMDMFAILOVER="TRUE"
		elif [[ $option =~ ^NOSERVICE$ ]]; then
			userAuthMDMFailoverNOSERVICE="TRUE"
		elif [[ $option =~ ^SOFT$ ]]; then
			userAuthMDMFailoverSOFT="TRUE"
		elif [[ $option =~ ^HARD$ ]]; then
			userAuthMDMFailoverHARD="TRUE"
		elif [[ $option =~ ^INSTALLNOW$ ]]; then
			userAuthMDMFailoverINSTALLNOW="TRUE"
		elif [[ $option =~ ^BOOTSTRAP$ ]]; then
			userAuthMDMFailoverBOOTSTRAP="TRUE"
		else
			sendToLog "Parameter Error: Unrecognized user authentication MDM failover type: $option. You can specify any of the following types separated by commas (no spaces); ALWAYS,SOFT,HARD,INSTALLNOW,BOOTSTRAP."; parameterERROR="TRUE"
		fi
	done
	IFS="$oldIFS"
	[[ "$parameterERROR" != "TRUE" ]] && defaults write "$superPLIST" UserAuthMDMFailover -string "$userAuthMDMFailoverOPTION"
fi

# Manage $allowUpgradeOPTION and save to $superPLIST.
if [[ $allowUpgradeOPTION -eq 1 ]] || [[ "$allowUpgradeOPTION" == "TRUE" ]]; then
	allowUpgradeOPTION="TRUE"
	defaults write "$superPLIST" AllowUpgrade -bool true
else
	allowUpgradeOPTION="FALSE"
	defaults delete "$superPLIST" AllowUpgrade 2> /dev/null
fi

# Manage $targetUpgradeOPTION and if a valid macOS version then save to $superPLIST.
if [[ "$targetUpgradeOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for macOS target upgrade version."
	defaults delete "$superPLIST" TargetUpgrade 2> /dev/null
	unset targetUpgradeOPTION
elif [[ -n $targetUpgradeOPTION ]] && ! [[ $targetUpgradeOPTION =~ $regexMACOSMAJORVERSION ]]; then
	sendToLog "Parameter Error: The upgrade target version must be a contemporary macOS version number (11,12,etc.)."; parameterERROR="TRUE"
elif [[ -n $targetUpgradeOPTION ]] && [[ $targetUpgradeOPTION =~ $regexMACOSMAJORVERSION ]]; then
	if [[ "$allowUpgradeOPTION" == "TRUE" ]]; then
		targetUpgradeVERSION="$targetUpgradeOPTION"
		defaults write "$superPLIST" TargetUpgrade -string "$targetUpgradeOPTION"
	else
		sendToLog "Parameter Error: To specify a target upgrade version you must also use --allow-upgrade."; parameterERROR="TRUE"
		defaults delete "$superPLIST" TargetUpgrade 2> /dev/null
	fi
fi
# Manage $onlyDownloadOPTION and save to $superPLIST.
if [[ $onlyDownloadOPTION -eq 1 ]] || [[ "$onlyDownloadOPTION" == "TRUE" ]]; then
	onlyDownloadOPTION="TRUE"
	defaults write "$superPLIST" OnlyDownload -bool true
else
	onlyDownloadOPTION="FALSE"
	defaults delete "$superPLIST" OnlyDownload 2> /dev/null
fi

# Manage $installNowOPTION and save to $superPLIST.
if [[ $installNowOPTION -eq 1 ]] || [[ "$installNowOPTION" == "TRUE" ]]; then
	if [[ "$currentUserNAME" != "FALSE" ]]; then
		installNowOPTION="TRUE"
		defaults write "$superPLIST" InstallNow -bool true
	else
		sendToLog "Parameter Error: The --install-now option can only be used when a user is actively logged in."; parameterERROR="TRUE"
		installNowOPTION="FALSE"
		defaults delete "$superPLIST" InstallNow 2> /dev/null
	fi
else
	installNowOPTION="FALSE"
	defaults delete "$superPLIST" InstallNow 2> /dev/null
fi
if [[ "$onlyDownloadOPTION" == "TRUE" ]] && [[ "$installNowOPTION" == "TRUE" ]]; then
	sendToLog "Warning: When both the --only-download and --install-now options are enabled the --install-now option takes priority."
	onlyDownloadOPTION="FALSE"
fi

# Manage $allowRSRUpdatesOPTION and save to $superPLIST.
if [[ $allowRSRUpdatesOPTION -eq 1 ]] || [[ "$allowRSRUpdatesOPTION" == "TRUE" ]]; then
	allowRSRUpdatesOPTION="TRUE"
	defaults write "$superPLIST" AllowRSRUpdates -bool true
else
	allowRSRUpdatesOPTION="FALSE"
	defaults delete "$superPLIST" AllowRSRUpdates 2> /dev/null
fi

# Manage $enforceNonSystemUpdatesOPTION and save to $superPLIST.
if [[ $enforceNonSystemUpdatesOPTION -eq 1 ]] || [[ "$enforceNonSystemUpdatesOPTION" == "TRUE" ]]; then
	enforceNonSystemUpdatesOPTION="TRUE"
	defaults write "$superPLIST" EnforceNonSystemUpdates -bool true
else
	enforceNonSystemUpdatesOPTION="FALSE"
	defaults delete "$superPLIST" EnforceNonSystemUpdates 2> /dev/null
fi

# Validate $policyTriggersOPTION input and if valid set $policyTRIGGERS and save to $superPLIST.
if [[ "$policyTriggersOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for Jamf Pro Policy triggers."
	defaults delete "$superPLIST" PolicyTriggers 2> /dev/null
elif [[ -n $policyTriggersOPTION ]]; then
	policyTRIGGERS="$policyTriggersOPTION"
	defaults write "$superPLIST" PolicyTriggers -string "$policyTRIGGERS"
fi
if [[ "$jamfVERSION" == "FALSE" ]] && [[ -n $policyTRIGGERS ]]; then
	sendToLog "Parameter Error: Unable to run Jamf Pro Policy Triggers due to missing Jamf binary."; parameterERROR="TRUE"
fi

# Manage $skipUpdatesOPTION and save to $superPLIST.
if [[ $skipUpdatesOPTION -eq 1 ]] || [[ "$skipUpdatesOPTION" == "TRUE" ]]; then
	skipUpdatesOPTION="TRUE"
	defaults write "$superPLIST" SkipUpdates -bool true
else
	skipUpdatesOPTION="FALSE"
	defaults delete "$superPLIST" SkipUpdates 2> /dev/null
fi
if [[ "$skipUpdatesOPTION" == "TRUE" ]] && [[ "$onlyDownloadOPTION" == "TRUE" ]]; then
	sendToLog "Parameter Error: The --restart-without-updates option can not be used with the --only-download option."; parameterERROR="TRUE"
fi

# Manage $restartWithoutUpdatesOPTION and save to $superPLIST.
if [[ $restartWithoutUpdatesOPTION -eq 1 ]] || [[ "$restartWithoutUpdatesOPTION" == "TRUE" ]]; then
	restartWithoutUpdatesOPTION="TRUE"
	defaults write "$superPLIST" RestartWithoutUpdates -bool true
else
	restartWithoutUpdatesOPTION="FALSE"
	defaults delete "$superPLIST" RestartWithoutUpdates 2> /dev/null
fi
if [[ "$restartWithoutUpdatesOPTION" == "TRUE" ]] && [[ "$onlyDownloadOPTION" == "TRUE" ]]; then
	sendToLog "Parameter Error: The --restart-without-updates option can not be used with the --only-download option."; parameterERROR="TRUE"
fi

# Manage $testModeOPTION and save to $superPLIST.
if [[ $testModeOPTION -eq 1 ]] || [[ "$testModeOPTION" == "TRUE" ]]; then
	testModeOPTION="TRUE"
	defaults write "$superPLIST" TestMode -bool true
else
	testModeOPTION="FALSE"
	defaults delete "$superPLIST" TestMode 2> /dev/null
fi
if [[ "$testModeOPTION" == "TRUE" ]] && [[ "$currentUserNAME" == "FALSE" ]]; then
	sendToLog "Parameter Error: Test mode requires that a valid user is logged in."; parameterERROR="TRUE"
fi
if [[ "$testModeOPTION" == "TRUE" ]] && [[ "$onlyDownloadOPTION" == "TRUE" ]]; then
	sendToLog "Parameter Error: The --test-mode option can not be used with the --only-download option."; parameterERROR="TRUE"
fi

# Validate $freeSpaceUpdateOPTION input and if valid set $freeSpaceUpdateGB and save to $superPLIST.
if [[ "$freeSpaceUpdateOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for free space update gigabytes."
	defaults delete "$superPLIST" FreeSpaceUpdate 2> /dev/null
elif [[ -n $freeSpaceUpdateOPTION ]] && [[ $freeSpaceUpdateOPTION =~ $regexNUMBER ]]; then
	[[ $freeSpaceUpdateOPTION -ne $freeSpaceUpdateGB ]] && sendToLog "Warning: Specifying a custom free space update gigabytes should only be used for testing purposes."
	freeSpaceUpdateGB=$freeSpaceUpdateOPTION
	defaults write "$superPLIST" FreeSpaceUpdate -string "$freeSpaceUpdateGB"
elif [[ -n $freeSpaceUpdateOPTION ]] && ! [[ $freeSpaceUpdateOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The free space update gigabytes must only be a number."; parameterERROR="TRUE"
fi

# Validate $freeSpaceUpgradeOPTION input and if valid set $freeSpaceUpgradeGB and save to $superPLIST.
if [[ "$freeSpaceUpgradeOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for free space upgrade gigabytes."
	defaults delete "$superPLIST" FreeSpaceUpgrade 2> /dev/null
elif [[ -n $freeSpaceUpgradeOPTION ]] && [[ $freeSpaceUpgradeOPTION =~ $regexNUMBER ]]; then
	[[ $freeSpaceUpgradeOPTION -ne $freeSpaceUpgradeGB ]] && sendToLog "Warning: Specifying a custom free space upgrade gigabytes should only be used for testing purposes."
	freeSpaceUpgradeGB=$freeSpaceUpgradeOPTION
	defaults write "$superPLIST" FreeSpaceUpgrade -string "$freeSpaceUpgradeGB"
elif [[ -n $freeSpaceUpgradeOPTION ]] && ! [[ $freeSpaceUpgradeOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The free space upgrade gigabytes must only be a number."; parameterERROR="TRUE"
fi

# Validate $freeSpaceTimeoutOPTION input and if valid set $freeSpaceTimeoutSECONDS and save to $superPLIST.
if [[ "$freeSpaceTimeoutOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for free space notification timeout seconds."
	defaults delete "$superPLIST" FreeSpaceTimeout 2> /dev/null
elif [[ -n $freeSpaceTimeoutOPTION ]] && [[ $freeSpaceTimeoutOPTION =~ $regexNUMBER ]]; then
	if [[ $freeSpaceTimeoutOPTION -lt 60 ]]; then
		sendToLog "Warning: Specified free space notification timeout of $freeSpaceTimeoutOPTION seconds is too low, rounding up to 60 seconds."
		freeSpaceTimeoutSECONDS=60
	elif [[ $freeSpaceTimeoutOPTION -gt 86400 ]]; then
		sendToLog "Warning: Specified free space notification timeout of $freeSpaceTimeoutOPTION seconds is too high, rounding down to 86400 seconds (1 day)."
		freeSpaceTimeoutSECONDS=86400
	else
		freeSpaceTimeoutSECONDS=$freeSpaceTimeoutOPTION
	fi
	defaults write "$superPLIST" FreeSpaceTimeout -string "$freeSpaceTimeoutSECONDS"
elif [[ -n $freeSpaceTimeoutOPTION ]] && ! [[ $freeSpaceTimeoutOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The free space notification timeout seconds must only be a number."; parameterERROR="TRUE"
fi
if [[ "$parameterERROR" != "TRUE" ]] && [[ -n $displayRedrawSECONDS ]]; then
	displayMinimumTIMEOUT=$((displayRedrawSECONDS * 3))
	if [[ $freeSpaceTimeoutSECONDS -lt $displayMinimumTIMEOUT ]];then
		sendToLog "Warning: Specified free space notification timeout of $freeSpaceTimeoutSECONDS seconds is too low given a display redraw of $displayRedrawSECONDS seconds, changing free space notification timeout to $displayMinimumTIMEOUT seconds."
		freeSpaceTimeoutSECONDS=$displayMinimumTIMEOUT
		defaults write "$superPLIST" FreeSpaceTimeout -string "$freeSpaceTimeoutSECONDS"
	fi
fi

# Validate $batteryLevelOPTION input and if valid set $batteryLevelPERCENT and save to $superPLIST.
if [[ "$batteryLevelOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for battery level percentage."
	defaults delete "$superPLIST" BatteryLevel 2> /dev/null
elif [[ -n $batteryLevelOPTION ]] && [[ $batteryLevelOPTION =~ $regexNUMBER ]]; then
	[[ $batteryLevelOPTION -ne $batteryLevelPERCENT ]] && sendToLog "Warning: Specifying a custom battery level percentage should only be used for testing purposes."
	batteryLevelPERCENT=$batteryLevelOPTION
	defaults write "$superPLIST" BatteryLevel -string "$batteryLevelPERCENT"
elif [[ -n $batteryLevelOPTION ]] && ! [[ $batteryLevelOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The battery level percentage must only be a number."; parameterERROR="TRUE"
fi

# Validate $batteryTimeoutOPTION input and if valid set $batteryTimeoutSECONDS and save to $superPLIST.
if [[ "$batteryTimeoutOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for battery level notification timeout seconds."
	defaults delete "$superPLIST" BatteryTimeout 2> /dev/null
elif [[ -n $batteryTimeoutOPTION ]] && [[ $batteryTimeoutOPTION =~ $regexNUMBER ]]; then
	if [[ $batteryTimeoutOPTION -lt 120 ]]; then
		sendToLog "Warning: Specified battery level notification timeout of $batteryTimeoutOPTION seconds is too low, rounding up to 60 seconds."
		batteryTimeoutSECONDS=60
	elif [[ $batteryTimeoutOPTION -gt 86400 ]]; then
		sendToLog "Warning: Specified battery level notification timeout of $batteryTimeoutOPTION seconds is too high, rounding down to 86400 seconds (1 day)."
		batteryTimeoutSECONDS=86400
	else
		batteryTimeoutSECONDS=$batteryTimeoutOPTION
	fi
	defaults write "$superPLIST" BatteryTimeout -string "$batteryTimeoutSECONDS"
elif [[ -n $batteryTimeoutOPTION ]] && ! [[ $batteryTimeoutOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The battery level notification timeout seconds must only be a number."; parameterERROR="TRUE"
fi
if [[ "$parameterERROR" != "TRUE" ]] && [[ -n $displayRedrawSECONDS ]]; then
	displayMinimumTIMEOUT=$((displayRedrawSECONDS * 3))
	if [[ $batteryTimeoutSECONDS -lt $displayMinimumTIMEOUT ]];then
		sendToLog "Warning: Specified battery level notification timeout of $batteryTimeoutSECONDS seconds is too low given a display redraw of $displayRedrawSECONDS seconds, changing battery level notification timeout to $displayMinimumTIMEOUT seconds."
		batteryTimeoutSECONDS=$displayMinimumTIMEOUT
		defaults write "$superPLIST" BatteryTimeout -string "$batteryTimeoutSECONDS"
	fi
fi

# Validate $testModeTimeoutOPTION input and if valid set $testModeTimeoutSECONDS and save to $superPLIST.
if [[ "$testModeTimeoutOPTION" == "X" ]]; then
	sendToLog "Startup: Deleting local preference for test mode timeout."
	defaults delete "$superPLIST" TestModeTimeout 2> /dev/null
elif [[ -n $testModeTimeoutOPTION ]] && [[ $testModeTimeoutOPTION =~ $regexNUMBER ]]; then
	if [[ -n $displayRedrawSECONDS ]]; then
		if [[ $testModeTimeoutOPTION -lt 30 ]]; then
			sendToLog "Warning: Specified test mode timeout of $testModeTimeoutOPTION seconds is too low given that display redraw is also enabled, rounding up to 30 seconds."
			testModeTimeoutSECONDS=30
		elif [[ $testModeTimeoutOPTION -gt 120 ]]; then
			sendToLog "Warning: Specified test mode timeout of $testModeTimeoutOPTION seconds is too high, rounding down to 120 seconds (2 minutes)."
			testModeTimeoutSECONDS=120
		else
			testModeTimeoutSECONDS=$testModeTimeoutOPTION
		fi
		redrawMaximumTIMEOUT=$((testModeTimeoutSECONDS / 3))
		if [[ "$testModeOPTION" == "TRUE" ]] && [[ $displayRedrawSECONDS -gt $redrawMaximumTIMEOUT ]]; then
			sendToLog "Warning: Test mode requires temporary adjustment of the display redraw option from $displayRedrawSECONDS seconds to $redrawMaximumTIMEOUT seconds. This adjustment is not saved."
			displayRedrawSECONDS=$redrawMaximumTIMEOUT
		fi
	else # No display redraw enabled.
		if [[ $testModeTimeoutOPTION -lt 10 ]]; then
			sendToLog "Warning: Specified test mode timeout of $testModeTimeoutOPTION seconds is too low, rounding up to 10 seconds."
			testModeTimeoutSECONDS=10
		elif [[ $testModeTimeoutOPTION -gt 120 ]]; then
			sendToLog "Warning: Specified test mode timeout of $testModeTimeoutOPTION seconds is too high, rounding down to 120 seconds (2 minutes)."
			testModeTimeoutSECONDS=120
		else
			testModeTimeoutSECONDS=$testModeTimeoutOPTION
		fi
	fi
	defaults write "$superPLIST" TestModeTimeout -string "$testModeTimeoutSECONDS"
	if [[ "$testModeOPTION" == "TRUE" ]]; then
		if [[ -n $deferDialogTimeoutSECONDS ]] && [[ $deferDialogTimeoutSECONDS -gt $testModeTimeoutSECONDS ]]; then
				sendToLog "Warning: Test mode requires temporary adjustment of the restart/defer dialog timeout from $deferDialogTimeoutSECONDS seconds to $testModeTimeoutSECONDS seconds. This adjustment is not saved."
				deferDialogTimeoutSECONDS=$testModeTimeoutSECONDS
		fi
		if [[ -n $softDialogTimeoutSECONDS ]] && [[ $softDialogTimeoutSECONDS -gt $testModeTimeoutSECONDS ]]; then
				sendToLog "Warning: Test mode requires temporary adjustment of the soft deadline dialog timeout from $softDialogTimeoutSECONDS seconds to $testModeTimeoutSECONDS seconds. This adjustment is not saved."
				softDialogTimeoutSECONDS=$testModeTimeoutSECONDS
		fi
		if [[ $userAuthTimeoutSECONDS -gt $testModeTimeoutSECONDS ]]; then
				sendToLog "Warning: Test mode requires temporary adjustment of the user authentication dialog timeout from $userAuthTimeoutSECONDS seconds to $testModeTimeoutSECONDS seconds. This adjustment is not saved."
				userAuthTimeoutSECONDS=$testModeTimeoutSECONDS
		fi
		if [[ $freeSpaceTimeoutSECONDS -gt $testModeTimeoutSECONDS ]]; then
				sendToLog "Warning: Test mode requires temporary adjustment of the free space notification timeout from $freeSpaceTimeoutSECONDS seconds to $testModeTimeoutSECONDS seconds. This adjustment is not saved."
				freeSpaceTimeoutSECONDS=$testModeTimeoutSECONDS
		fi
		if [[ $batteryTimeoutSECONDS -gt $testModeTimeoutSECONDS ]]; then
				sendToLog "Warning: Test mode requires temporary adjustment of the battery level notification timeout from $batteryTimeoutSECONDS seconds to $testModeTimeoutSECONDS seconds. This adjustment is not saved."
				batteryTimeoutSECONDS=$testModeTimeoutSECONDS
		fi
	fi
elif [[ -n $testModeTimeoutOPTION ]] && ! [[ $testModeTimeoutOPTION =~ $regexNUMBER ]]; then
	sendToLog "Parameter Error: The test mode timeout must only be a number."; parameterERROR="TRUE"
fi
}

# For Apple Silicon computers this function manages update/upgrade credentials given $deleteACCOUNTS, $localACCOUNT, $adminACCOUNT, $superACCOUNT, or $jamfACCOUNT. Any errors set $credentialERROR.
manageUpdateCredentials () {
credentialERROR="FALSE"

# Validate that $localOPTION and $localPASSWORD are simultaneously provided.
if [[ -n $localOPTION ]] && [[ -z $localPASSWORD ]]; then
	sendToLog "Credential Error: A local volume owner account name requires that you also set a local volume owner password."; credentialERROR="TRUE"
fi
if [[ -z $localOPTION ]] && [[ -n $localPASSWORD ]]; then
	sendToLog "Credential Error: A local volume owner password requires that you also set a local volume owner account name."; credentialERROR="TRUE"
fi

# Validate that $localOPTION exists, is a volume owner, and that $localPASSWORD is correct.
if [[ -n $localOPTION ]] && [[ "$credentialERROR" != "TRUE" ]]; then
	localGUID=$(dscl . read "/Users/$localOPTION" GeneratedUID 2> /dev/null | awk '{print $2;}')
	if [[ -n $localGUID ]]; then
		if ! [[ $(diskutil apfs listcryptousers / | grep -c "$localGUID") -gt 0 ]]; then
			sendToLog "Credential Error: Provided account \"$localOPTION\" is not a system volume owner."; credentialERROR="TRUE"
		fi
		localVALID=$(dscl /Local/Default -authonly "$localOPTION" "$localPASSWORD" 2>&1)
		if ! [[ "$localVALID" == "" ]];then
			sendToLog "Credential Error: The provided password for account \"$localOPTION\" is not valid."; credentialERROR="TRUE"
		fi
	else
		sendToLog "Credential Error: Could not retrieve GUID for account \"$localOPTION\". Verify that account exists locally."; credentialERROR="TRUE"
	fi
fi

# Validate that $adminACCOUNT and $adminPASSWORD are simultaneously provided.
if [[ -n $adminACCOUNT ]] && [[ -z $adminPASSWORD ]]; then
	sendToLog "Credential Error: A local admin account name requires that you also set a local admin password."; credentialERROR="TRUE"
fi
if [[ -z $adminACCOUNT ]] && [[ -n $adminPASSWORD ]]; then
	sendToLog "Credential Error: A local admin password requires that you also set a local admin account name."; credentialERROR="TRUE"
fi

# Validate that $adminACCOUNT is also specified with $superOPTION.
if [[ -n $superOPTION ]] && [[ -z $adminACCOUNT ]]; then
	sendToLog "Credential Error: Local admin credentials are required to set a custom super service account name."; credentialERROR="TRUE"
fi

# Validate that $adminACCOUNT exists, is a volume owner, a local admin, and that $adminPASSWORD is correct.
if [[ -n $adminACCOUNT ]] && [[ "$credentialERROR" != "TRUE" ]]; then
	adminGUID=$(dscl . read "/Users/$adminACCOUNT" GeneratedUID 2> /dev/null | awk '{print $2;}')
	if [[ -n $adminGUID ]]; then
		if [[ $(groups "$adminACCOUNT" | grep -c 'admin') -eq 0 ]]; then
			sendToLog "Credential Error: Provided account \"$adminACCOUNT\" is not a local administrator."; credentialERROR="TRUE"
		fi
		if ! [[ $(diskutil apfs listcryptousers / | grep -c "$adminGUID") -gt 0 ]]; then
			sendToLog "Credential Error: Provided account \"$adminACCOUNT\" is not a system volume owner."; credentialERROR="TRUE"
		fi
		adminVALID=$(dscl /Local/Default -authonly "$adminACCOUNT" "$adminPASSWORD" 2>&1)
		if ! [[ "$adminVALID" == "" ]];then
			sendToLog "Credential Error: The provided password for account \"$adminACCOUNT\" is not valid."; credentialERROR="TRUE"
		fi
	else
		sendToLog "Credential Error: Could not retrieve GUID for account \"$adminACCOUNT\". Verify that account exists locally."; credentialERROR="TRUE"
	fi
fi

# Validate that $jamfOPTION is only used on computers with the jamf binary installed.
if [[ -n $jamfOPTION ]] && [[ "$jamfVERSION" == "FALSE" ]]; then
	sendToLog "Credential Error: A Jamf Pro API account name requires that this computer is enrolled in Jamf Pro."; credentialERROR="TRUE"
fi

# Validate that $jamfOPTION and $jamfPASSWORD are simultaneously provided.
if [[ -n $jamfOPTION ]] && [[ -z $jamfPASSWORD ]]; then
	sendToLog "Credential Error: A Jamf Pro API account name requires that you also set a Jamf Pro API password."; credentialERROR="TRUE"
fi
if [[ -z $jamfOPTION ]] && [[ -n $jamfPASSWORD ]]; then
	sendToLog "Credential Error: A Jamf Pro API password requires that you also set a Jamf Pro API account name."; credentialERROR="TRUE"
fi

# Validate that the account $jamfOPTION and $jamfPASSWORD are valid.
if [[ -n $jamfOPTION ]] && [[ "$credentialERROR" != "TRUE" ]]; then
	jamfACCOUNT="$jamfOPTION"
	jamfKEYCHAIN="$jamfPASSWORD"
	if [[ "$jamfSERVER" != "FALSE" ]]; then
		getJamfProAccount
		[[ "$jamfERROR" == "TRUE" ]] && credentialERROR="TRUE"
	else
		sendToLog "Credential Error: Unable to connect to Jamf Pro to validate user account."; credentialERROR="TRUE"
	fi
	unset jamfACCOUNT
	unset jamfKEYCHAIN
fi

# Collect any previously saved account names from $superPLIST.
localPROPERTY=$(defaults read "$superPLIST" LocalAccount 2> /dev/null)
superPROPERTY=$(defaults read "$superPLIST" SuperAccount 2> /dev/null)
jamfPROPERTY=$(defaults read "$superPLIST" JamfAccount 2> /dev/null)

# Some messaging to indicate if there are no saved accounts when a delete is requested.
{ [[ -z $localPROPERTY ]] && [[ -z $superPROPERTY ]] && [[ -z $jamfPROPERTY ]] && [[ -n $deleteACCOUNTS ]]; } && sendToLog "Startup: No saved accounts to delete."

# If there was a previous $localPROPERTY account and the user specified $localOPTION or $deleteACCOUNTS then delete any previously saved local account credentials.
if [[ -n $localPROPERTY ]] && { [[ -n $localOPTION ]] || [[ "$deleteACCOUNTS" == "TRUE" ]]; }; then
	sendToLog "Startup: Deleting saved credentials for local account \"$localPROPERTY\"."
	defaults delete "$superPLIST" LocalAccount > /dev/null 2>&1
	security delete-generic-password -a "$localPROPERTY" -s "Super Local Account" /Library/Keychains/System.keychain > /dev/null 2>&1
	unset localPROPERTY
	localCREDENTIAL="FALSE"
fi

# If there was a previous $superPROPERTY account and the user specified $adminACCOUNT or $deleteACCOUNTS then delete any previously saved super service account and credentials.
if [[ -n $superPROPERTY ]] && { [[ -n $adminACCOUNT ]] || [[ "$deleteACCOUNTS" == "TRUE" ]]; } then
	sendToLog "Startup: Deleting local account and saved credentials for super service account \"$superPROPERTY\"."
	sysadminctl -deleteUser "$superPROPERTY" > /dev/null 2>&1
	defaults delete "$superPLIST" SuperAccount > /dev/null 2>&1
	security delete-generic-password -a "$superPROPERTY" -s "Super Service Account" /Library/Keychains/System.keychain > /dev/null 2>&1
	unset superPROPERTY
	superCREDENTIAL="FALSE"
fi

# If there was a previous $jamfPROPERTY account and the user specified $jamfOPTION or $deleteACCOUNTS then delete any previously saved Jamf Pro API credentials.
if [[ -n $jamfPROPERTY ]] && { [[ -n $jamfOPTION ]] || [[ "$deleteACCOUNTS" == "TRUE" ]]; } then
	sendToLog "Startup: Deleting saved credentials for Jamf Pro API account \"$jamfPROPERTY\"."
	defaults delete "$superPLIST" JamfAccount > /dev/null 2>&1
	security delete-generic-password -a "$jamfPROPERTY" -s "Super MDM Account" /Library/Keychains/System.keychain > /dev/null 2>&1
	unset jamfPROPERTY
	jamfCREDENTIAL="FALSE"
fi

# If any previous validation generated a $credentialERROR then it's not necessary to continue this function.
[[ $credentialERROR == "TRUE" ]] && return 0

# If a new local account was specified, save $localOPTION and $localPASSWORD credentials and then validate retrieval.
if [[ -n $localOPTION ]]; then
	sendToLog "Startup: Saving new credentials for local account \"$localOPTION\"..."
	defaults write "$superPLIST" LocalAccount -string "$localOPTION"
	localACCOUNT=$(defaults read "$superPLIST" LocalAccount 2> /dev/null)
	if [[ "$localOPTION" == "$localACCOUNT" ]]; then
		security add-generic-password -a "$localACCOUNT" -s "Super Local Account" -w "$localPASSWORD" -T /usr/bin/security /Library/Keychains/System.keychain
		localKEYCHAIN=$(security find-generic-password -w -a "$localACCOUNT" -s "Super Local Account" /Library/Keychains/System.keychain 2> /dev/null)
		if [[ "$localPASSWORD" == "$localKEYCHAIN" ]]; then
			sendToLog "Startup: Validated saved credentials for local account \"$localACCOUNT\"."
			localCREDENTIAL="TRUE"
		else
			sendToLog "Credential Error: Unable to validate saved password for local account \"$localACCOUNT\", deleting saved password."; credentialERROR="TRUE"
			security delete-generic-password -a "$localACCOUNT" -s "Super Local Account" /Library/Keychains/System.keychain > /dev/null 2>&1
		fi
	else
		sendToLog "Credential Error: Unable to validate saved name for local account \"$localOPTION\", deleting saved name."; credentialERROR="TRUE"
		defaults delete "$superPLIST" LocalAccount > /dev/null 2>&1
	fi
fi

# If an $adminACCOUNT was specified then a new super service account needs to be created and its credentials saved.
if [[ -n $adminACCOUNT ]]; then
	# If the a custom super service account name is requested via $superOPTION.
	if [[ -n $superOPTION ]]; then
		superNEWACCT="$superOPTION"
		superNEWFULL="$superOPTION"
	else # Use the default names for the super service account.
		superNEWACCT="super"
		superNEWFULL="Super Update Service"
	fi
	
	# If a custom super service account password is requested via $superPASSWORD.
	if [[ -n $superPASSWORD ]]; then
		superNEWPASS="$superPASSWORD"
	else # Use the default random password for the super service account.
		superNEWPASS=$(uuidgen)
	fi
	
	# Save and validate new super service account credentials, and validate retrieval.
	sendToLog "Startup: Saving new credentials for super service account \"$superNEWACCT\"..."
	defaults write "$superPLIST" SuperAccount -string "$superNEWACCT"
	superACCOUNT=$(defaults read "$superPLIST" SuperAccount 2> /dev/null)
	if [[ "$superNEWACCT" == "$superACCOUNT" ]]; then
		security add-generic-password -a "$superACCOUNT" -s "Super Service Account" -w "$superNEWPASS" -T /usr/bin/security /Library/Keychains/System.keychain
		superKEYCHAIN=$(security find-generic-password -w -a "$superACCOUNT" -s "Super Service Account" /Library/Keychains/System.keychain 2> /dev/null)
		if [[ "$superNEWPASS" == "$superKEYCHAIN" ]]; then # If saved credentials are valid then create the new super service account.
			sendToLog "Startup: Validated saved credentials for new super service account \"$superACCOUNT\"."
			if [[ $(id "$superACCOUNT" 2>&1 | grep -c 'no such user') -gt 0 ]]; then
				sendToLog "Startup: Deleting existing super service account \"$superACCOUNT\" in preparation for new account."
				sysadminctl -deleteUser "$superACCOUNT" > /dev/null 2>&1
			fi
			# Loop through local IDs to find the first vacant id after 500.
			newUID=501
			while [[ $(id $newUID 2>&1 | grep -c 'no such user') -eq 0 ]]; do
				newUID=$((newUID + 1))
			done
			sendToLog "Startup: Creating new super service account \"$superNEWACCT\" with full name \"$superNEWFULL\" and UID $newUID..."
			addRESULT=$(sysadminctl -addUser "$superNEWACCT" -fullName "$superNEWFULL" -password "$superNEWPASS" -UID $newUID -GID 20 -shell /dev/null -home /dev/null -picture "$cachedICON" -adminUser "$adminACCOUNT" -adminPassword "$adminPASSWORD" 2>&1)
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: addRESULT is:\n$addRESULT"
			dscl . create /Users/"$superNEWACCT" IsHidden 1
			updateACCOUNT="$superACCOUNT"
			updateKEYCHAIN="$superKEYCHAIN"
			checkLocalUpdateAccount
			if [[ "$accountERROR" != "TRUE" ]]; then
				sendToLog "Startup: Validated the creation of new super service account \"$superACCOUNT\"."
				superCREDENTIAL="TRUE"
			else
				sendToLog "Credential Error: Unable to validate newly created super service account \"$superACCOUNT\", deleting account"; credentialERROR="TRUE"
				sysadminctl -deleteUser "$superACCOUNT" > /dev/null 2>&1
				defaults delete "$superPLIST" SuperAccount > /dev/null 2>&1
				security delete-generic-password -a "$superACCOUNT" -s "Super Service Account" /Library/Keychains/System.keychain > /dev/null 2>&1
				unset superPROPERTY
			fi
		else
			sendToLog "Credential Error: Unable to validate saved password for new super service account \"$superNEWACCT\", deleting saved password."; credentialERROR="TRUE"
			security delete-generic-password -a "$superACCOUNT" -s "Super Service Account" /Library/Keychains/System.keychain > /dev/null 2>&1
		fi
	else
		sendToLog "Credential Error: Unable to validate saved name for new super service account \"$superNEWACCT\",deleting saved name."; credentialERROR="TRUE"
		defaults delete "$superPLIST" SuperAccount > /dev/null 2>&1
	fi
fi

# If a new Jamf Pro API account was specified, save $jamfOPTION and $jamfPASSWORD credentials and then validate retrieval.
if [[ -n $jamfOPTION ]]; then
	sendToLog "Startup: Saving new credentials for Jamf Pro API account \"$jamfOPTION\"..."
	defaults write "$superPLIST" JamfAccount -string "$jamfOPTION"
	jamfACCOUNT=$(defaults read "$superPLIST" JamfAccount 2> /dev/null)
	if [[ "$jamfOPTION" == "$jamfACCOUNT" ]]; then
		security add-generic-password -a "$jamfACCOUNT" -s "Super MDM Account" -w "$jamfPASSWORD" -T /usr/bin/security /Library/Keychains/System.keychain
		jamfKEYCHAIN=$(security find-generic-password -w -a "$jamfACCOUNT" -s "Super MDM Account" /Library/Keychains/System.keychain 2> /dev/null)
		if [[ "$jamfPASSWORD" == "$jamfKEYCHAIN" ]]; then
			sendToLog "Startup: Validated saved credentials for Jamf Pro API account \"$jamfACCOUNT\"."
			jamfCREDENTIAL="TRUE"
		else
			sendToLog "Credential Error: Unable to validate saved password for Jamf Pro API account \"$jamfACCOUNT\", deleting saved password."; credentialERROR="TRUE"
			security delete-generic-password -a "$jamfACCOUNT" -s "Super MDM Account" /Library/Keychains/System.keychain > /dev/null 2>&1
		fi
	else
		sendToLog "Credential Error: Unable to validate saved name for Jamf Pro API account \"$jamfOPTION\", deleting saved name."; credentialERROR="TRUE"
		defaults delete "$superPLIST" JamfAccount > /dev/null 2>&1
	fi
fi

# If there is a previously saved local account (that wasn't just deleted), validate the account and set $localACCOUNT and $localPASSWORD.
if [[ -n $localPROPERTY ]]; then
	localACCOUNT="$localPROPERTY"
	localKEYCHAIN=$(security find-generic-password -w -a "$localACCOUNT" -s "Super Local Account" /Library/Keychains/System.keychain 2> /dev/null)
	if [[ -n $localKEYCHAIN ]]; then
		sendToLog "Startup: Found saved credentials for local account \"$localACCOUNT\"."
		updateACCOUNT="$localACCOUNT"
		updateKEYCHAIN="$localKEYCHAIN"
		checkLocalUpdateAccount
		if [[ "$accountERROR" != "TRUE" ]]; then
			sendToLog "Startup: Validated saved credentials for local account \"$localACCOUNT\"."
			localCREDENTIAL="TRUE"
		else
			sendToLog "Credential Error: Unable to validate saved credentials for local account \"$localACCOUNT\"."; credentialERROR="TRUE"
		fi
	else
		sendToLog "Credential Error: Unable to retrieve password for saved local account \"$localACCOUNT\"."; credentialERROR="TRUE"
	fi
fi

# If there is a previously saved super service account (that wasn't just deleted), validate the account and set $superACCOUNT and $superPASSWORD.
if [[ -n $superPROPERTY ]]; then
	superACCOUNT="$superPROPERTY"
	superKEYCHAIN=$(security find-generic-password -w -a "$superACCOUNT" -s "Super Service Account" /Library/Keychains/System.keychain 2> /dev/null)
	if [[ -n $superKEYCHAIN ]]; then
		sendToLog "Startup: Found saved credentials for super service account \"$superACCOUNT\"."
		updateACCOUNT="$superACCOUNT"
		updateKEYCHAIN="$superKEYCHAIN"
		checkLocalUpdateAccount
		if [[ "$accountERROR" != "TRUE" ]]; then
			sendToLog "Startup: Validated saved credentials for super service account \"$superACCOUNT\"."
			superCREDENTIAL="TRUE"
		else
			sendToLog "Credential Error: Unable to validate saved credentials for super service account \"$superACCOUNT\"."; credentialERROR="TRUE"
		fi
	else
		sendToLog "Credential Error: Unable to retrieve password for saved super service account \"$superACCOUNT\"."; credentialERROR="TRUE"
	fi
fi

# If there is a previously saved Jamf PRO API account (that wasn't just deleted), validate the account and set $jamfACCOUNT and $jamfPASSWORD.
if [[ -n $jamfPROPERTY ]]; then
	jamfACCOUNT="$jamfPROPERTY"
	jamfKEYCHAIN=$(security find-generic-password -w -a "$jamfACCOUNT" -s "Super MDM Account" /Library/Keychains/System.keychain 2> /dev/null)
	if [[ -n $jamfKEYCHAIN ]]; then
		sendToLog "Startup: Found saved credentials for Jamf Pro API account \"$jamfACCOUNT\"."
		if [[ "$jamfSERVER" != "FALSE" ]]; then
			getJamfProAccount
			if [[ "$jamfERROR" != "TRUE" ]]; then
				sendToLog "Startup: Validated saved credentials for Jamf Pro API account \"$jamfACCOUNT\"."
				jamfCREDENTIAL="TRUE"
			else
				if [[ "$userAuthMDMFAILOVER" == "TRUE" ]] || [[ "$userAuthMDMFailoverNOSERVICE" == "TRUE" ]] || { [[ "$installNowOPTION" == "TRUE" ]] && [[ "$userAuthMDMFailoverINSTALLNOW" == "TRUE" ]]; }; then
					sendToLog "Warning: Unable to validate Jamf Pro user account, failing over to user authenticated workflow."
					upgradeWORKFLOW="MDMFAIL"
				elif [[ "$installNowOPTION" == "TRUE" ]]; then
					sendToLog "Error: Unable to validate Jamf Pro user account, install now workflow can not continue."
					sendToStatus "Inactive Error: Unable to validate Jamf Pro user account, install now workflow can not continue."
					notifyInstallNowFailure
					errorExit
				else
					deferSECONDS="$errorDeferSECONDS"
					sendToLog "Error: Unable to validate Jamf Pro user account, trying again in $deferSECONDS seconds."
					sendToStatus "Pending: Unable to validate Jamf Pro user account, trying again in $deferSECONDS seconds."
					makeLaunchDaemonCalendar
				fi
			fi
		else
			if [[ "$userAuthMDMFAILOVER" == "TRUE" ]] || [[ "$userAuthMDMFailoverNOSERVICE" == "TRUE" ]] || { [[ "$installNowOPTION" == "TRUE" ]] && [[ "$userAuthMDMFailoverINSTALLNOW" == "TRUE" ]]; }; then
				sendToLog "Warning: Unable to connect to Jamf Pro to validate user account, failing over to user authenticated workflow."
				upgradeWORKFLOW="MDMFAIL"
			elif [[ "$installNowOPTION" == "TRUE" ]]; then
				sendToLog "Error: Unable to connect to Jamf Pro to validate user account, install now workflow can not continue."
				sendToStatus "Inactive Error: Unable to connect to Jamf Pro to validate user account, install now workflow can not continue."
				notifyInstallNowFailure
				errorExit
			else
				deferSECONDS="$errorDeferSECONDS"
				sendToLog "Error: Unable to connect to Jamf Pro to validate user account, trying again in $deferSECONDS seconds."
				sendToStatus "Pending: Unable to connect to Jamf Pro to validate user account, trying again in $deferSECONDS seconds."
				makeLaunchDaemonCalendar
			fi
		fi
	else
		if [[ "$userAuthMDMFAILOVER" == "TRUE" ]] || [[ "$userAuthMDMFailoverNOSERVICE" == "TRUE" ]] || { [[ "$installNowOPTION" == "TRUE" ]] && [[ "$userAuthMDMFailoverINSTALLNOW" == "TRUE" ]]; }; then
			sendToLog "Warning: Unable to retrieve password for saved Jamf Pro API account \"$jamfACCOUNT\", failing over to user authenticated workflow."
			upgradeWORKFLOW="MDMFAIL"
		else
			sendToLog "Credential Error: Unable to retrieve password for saved Jamf Pro API account \"$jamfACCOUNT\"."; credentialERROR="TRUE"
		fi
	fi
fi
}

# This function determines what $updateWORKFLOW, $upgradeWORKFLOW, and betaWORKFLOW modes are possible given the architecture and authentication options.
manageWorkflowOptions() {
workflowERROR="FALSE"
# Update/upgrade workflow modes: FALSE, JAMF, LOCAL, or USER
updateWORKFLOW="FALSE"
upgradeWORKFLOW="FALSE"
betaWORKFLOW="FALSE"

# Logic to determin update/upgrade workflow.
if [[ "$macOSARCH" == "arm64" ]]; then  # Mac computers with Apple Silicon.
	sendToLog "Startup: Apple Silicon Mac computer running $(sw_vers -productName) $(sw_vers -productVersion)-$(sw_vers -buildVersion)."
	sendToLog "Startup: Last macOS startup was $lastREBOOT."
	if [[ "$localCREDENTIAL" == "TRUE" ]]; then
		sendToLog "Startup: macOS update/upgrade workflows authenticated via local account."
		installACCOUNT="$localACCOUNT"
		installPASSWORD="$localKEYCHAIN"
		updateWORKFLOW="LOCAL"
		[[ "$allowUpgradeOPTION" == "TRUE" ]] && upgradeWORKFLOW="LOCAL"
	elif [[ "$superCREDENTIAL" == "TRUE" ]]; then
		sendToLog "Startup: macOS update/upgrade workflows authenticated via super service account."
		installACCOUNT="$superACCOUNT"
		installPASSWORD="$superKEYCHAIN"
		updateWORKFLOW="LOCAL"
		[[ "$allowUpgradeOPTION" == "TRUE" ]] && upgradeWORKFLOW="LOCAL"
	elif [[ "$jamfCREDENTIAL" == "TRUE" ]]; then
		if [[ $macOSVERSION -ge 1103 ]]; then
			if [[ -n $userAuthMDMFailoverOPTION ]]; then
				sendToLog "Startup: macOS update/upgrade workflows authenticated via Jamf Pro API with user authentication failover types: $userAuthMDMFailoverOPTION."
			else
				sendToLog "Startup: macOS update/upgrade workflows authenticated via Jamf Pro API with no user authentication MDM failover."
			fi
			updateWORKFLOW="JAMF"
			[[ "$allowUpgradeOPTION" == "TRUE" ]] && upgradeWORKFLOW="JAMF"
		else
			sendToLog "Warning: Automatic macOS update/upgrade enforcement via MDM is only available on macOS 11.3 or newer."
			sendToLog "Startup: User authentication is required to perform a macOS update/upgrade."
			updateWORKFLOW="USER"
			[[ "$allowUpgradeOPTION" == "TRUE" ]] && upgradeWORKFLOW="USER"
		fi
	else
		sendToLog "Warning: Automatic macOS update/upgrade enforcement on Apple Silicon computers requires authentication credentials."
		sendToLog "Startup: User authentication is required to perform a macOS update/upgrade."
		updateWORKFLOW="USER"
		[[ "$allowUpgradeOPTION" == "TRUE" ]] && upgradeWORKFLOW="USER"
	fi
else # Mac computers with Intel.
	sendToLog "Startup: Intel Mac computer running macOS $(sw_vers -productVersion)-$(sw_vers -buildVersion)."
	sendToLog "Startup: Last macOS startup was $lastREBOOT."
	sendToLog "Startup: macOS update/upgrade workflows via system account (root)."
	updateWORKFLOW="LOCAL"
	[[ "$allowUpgradeOPTION" == "TRUE" ]] && upgradeWORKFLOW="LOCAL"
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: updateWORKFLOW is: $updateWORKFLOW"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: upgradeWORKFLOW is: $upgradeWORKFLOW"

# Check for beta program enrollment.
if [[ $macOSVERSION -ge 1304 ]]; then
	queryDeviceINFO=$(/usr/libexec/mdmclient QueryDeviceInformation 2> /dev/null | grep 'IsDefaultCatalog')
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: queryDeviceINFO is:\n$queryDeviceINFO"
	if [[ $(echo "$queryDeviceINFO" | grep -c '1') -eq 0 ]]; then
		sendToLog "Startup: This system is currently configured to receive macOS beta updates and upgrades."
		betaWORKFLOW="TRUE"
	fi
else # macOS versions prior to 13.4.
	seedutilSTATUS=$(/System/Library/PrivateFrameworks/Seeding.framework/Versions/A/Resources/seedutil current)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: seedutilSTATUS is:\n$seedutilSTATUS"
	if [[ $(echo "$seedutilSTATUS" | grep -c 'Is Enrolled: YES') -gt 0 ]]; then
		sendToLog "Startup: This system is currently configured to receive macOS beta updates and upgrades."
		betaWORKFLOW="TRUE"
	fi
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: betaWORKFLOW is: $betaWORKFLOW"
}

# MARK: *** Installation & Startup ***
################################################################################

# Download and install the IBM Notifier.app.
getIbmNotifier() {
sendToLog "Startup: Attempting to download and install IBM Notifier.app..."
downloadRESULT=$(curl "$ibmNotifierURL" -L -o "/tmp/IBM.Notifier.zip" 2>&1)
if [[ -f "/tmp/IBM.Notifier.zip" ]]; then
	unzipRESULT=$(unzip "/tmp/IBM.Notifier.zip" -d "$superFOLDER/" 2>&1)
	if [[ -d "$ibmNotifierAPP" ]]; then
		[[ -d "$superFOLDER/__MACOSX" ]] && rm -Rf "$superFOLDER/__MACOSX" > /dev/null 2>&1
		chmod -R a+rx "$ibmNotifierAPP"
		ibmNotifierVALID="TRUE"
		rm -Rf "/tmp/IBM.Notifier.zip"
	else
		sendToLog "Error: Unable to install IBM Notifier.app."
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: unzipRESULT is:\n$unzipRESULT"
	fi
else
	sendToLog "Error: Unable to download IBM Notifier.app from: $ibmNotifierURL"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: downloadRESULT is:\n$downloadRESULT"
fi
}

# Check the IBM Notifier.app for validity.
checkIbmNotifier() {
ibmNotifierVALID="FALSE"
ibmNotifierCODESIGN=$(codesign --verify --verbose "$ibmNotifierAPP" 2>&1)
if [[ $(echo "$ibmNotifierCODESIGN" | grep -c 'valid on disk') -gt 0 ]]; then
	ibmNotifierRESULT=$(defaults read "$ibmNotifierAPP/Contents/Info.plist" CFBundleShortVersionString)
	if [[ "$ibmNotifierVERSION" == "$ibmNotifierRESULT" ]]; then
		ibmNotifierVALID="TRUE"
	else
		sendToLog "Warning: IBM Notifier at path: $ibmNotifierAPP is version $ibmNotifierRESULT, this does not match target version $ibmNotifierVERSION"
	fi
else
	sendToLog "Warning: unable validate signature for IBM Notifier at path: $ibmNotifierAPP."
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: ibmNotifierCODESIGN is:\n$ibmNotifierCODESIGN"
fi
}

# Download and install the erase-install.pkg.
getEraseInstall() {
sendToLog "Startup: Attempting to download and install erase-install.pkg..."
downloadRESULT=$(curl "$eraseInstallURL" -L -o "/tmp/erase-install.pkg" 2>&1)
if [[ -f "/tmp/erase-install.pkg" ]]; then
	installRESULT=$(installer -verboseR -pkg "/tmp/erase-install.pkg" -target / 2>&1)
	if [[ $(echo "$installRESULT" | grep -c 'installer:PHASE:The software was successfully installed.') -gt 0 ]]; then
		eraseInstallVALID="TRUE"
		rm -Rf "/tmp/erase-install.pkg"
	else
		sendToLog "Error: Unable to install erase-install.pkg."
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: installRESULT is:\n$installRESULT"
	fi
else
	sendToLog "Error: Unable to download erase-install.pkg from: $eraseInstallURL."
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: downloadRESULT is:\n$downloadRESULT"
fi
}

# Check all erase-install items for validity.
checkEraseInstall() {
eraseInstallVALID="FALSE"
eraseInstallRESULT=$(grep -w "version=" "$eraseInstallSCRIPT" | awk -F '"' '{print $2}')
if [[ "$eraseInstallVERSION" == "$eraseInstallRESULT" ]]; then
	eraseInstallSHASUM=$(echo "$eraseInstallCHECKSUM  $eraseInstallSCRIPT" | shasum -c 2>&1)
	if [[ $(echo "$eraseInstallSHASUM" | grep -c 'OK') -gt 0 ]]; then
		eraseInstallVALID="TRUE"
	else
		sendToLog "Warning: Unable validate checksum for erase-install.sh at path: $eraseInstallSCRIPT."
		[[ "$eraseInstallSHASUM" == "TRUE" ]] && sendToLog "Verbose Mode: eraseInstallSHASUM is:\n$eraseInstallSHASUM"
	fi
else
	sendToLog "Warning: erase-install.sh at path: $eraseInstallSCRIPT is version $eraseInstallRESULT, this does not match target version $eraseInstallVERSION."
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: eraseInstallRESULT is:\n$eraseInstallRESULT"
fi
if [[ "$eraseInstallVALID" == "TRUE" ]] && [[ ! -e "$installInstallMacOS" ]]; then
	sendToLog "Warning: Unable to locate installinstallmacOS.py at path: $installInstallMacOS"
	eraseInstallVALID="FALSE"
fi
if [[ "$eraseInstallVALID" == "TRUE" ]] && [[ ! -d "$pythonFRAMEWORK" ]]; then
	sendToLog "Warning: Unable to locate Python.framework at path: $pythonFRAMEWORK"
	eraseInstallVALID="FALSE"
fi
}

# Install and validate helper items that may be used by super.
manageHelpers() {
helperERROR="FALSE"

# Validate $jamfBINARY if installed and set $jamfVERSION and $jamfSERVER accordingly.
jamfVERSION="FALSE"
if [[ -e "$jamfBINARY" ]]; then
	getJamfProServer
	jamfMAJOR=$("$jamfBINARY" -version | cut -c 9- | cut -d'.' -f1) # Expected output: 10
	jamfMINOR=$("$jamfBINARY" -version | cut -c 9- | cut -d'.' -f2) # Expected output: 30, 31, 32, etc.
	jamfVERSION=${jamfMAJOR}$(printf "%02d" "$jamfMINOR") # Expected output: 1030, 1031, 1032, etc.
	if [[ $macOSVERSION -ge 1103 ]] && [[ $jamfVERSION -lt 1038 ]]; then
		sendToLog "Helper Error: super requires Jamf Pro version 10.38 or later, the currently installed version of Jamf Pro $jamfVERSION is not supported."; helperERROR="TRUE"
	elif [[ "$jamfVERSION" -lt 1000 ]]; then
		sendToLog "Helper Error: super requires Jamf Pro version 10.00 or later, the currently installed version of Jamf Pro $jamfVERSION is not supported."; helperERROR="TRUE"
	else
		sendToLog "Startup: Computer is currently managed by Jamf Pro version $jamfMAJOR.$jamfMINOR."
	fi
else
	sendToLog "Startup: Unable to locate jamf binary at: $jamfBINARY"
fi

# Manage $preferJamfHelperOPTION and save to $superPLIST.
if [[ -n $preferJamfHelperOPTION ]]; then
	if [[ $preferJamfHelperOPTION -eq 1 ]] || [[ "$preferJamfHelperOPTION" == "TRUE" ]]; then
		if [[ "$jamfVERSION" != "FALSE" ]]; then
			preferJamfHelperOPTION="TRUE"
			defaults write "$superPLIST" PreferJamfHelper -bool true
		else
			sendToLog "Helper Error: No local Jamf binary found, thus can not prefer jamfHelper."; helperERROR="TRUE"
		fi
	else
		preferJamfHelperOPTION="FALSE"
		defaults delete "$superPLIST" PreferJamfHelper 2> /dev/null
	fi
fi

# If needed, validate the IBM Notifier.app, if missing or invalid then install and check again.
if [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	ibmNotifierVALID="FALSE"
	if [[ $macOSMAJOR -ge 11 ]] || [[ $macOSVERSION -ge 1015 ]]; then
		if [[ ! -d "$ibmNotifierAPP" ]]; then
			getIbmNotifier
			[[ -d "$ibmNotifierAPP" ]] && checkIbmNotifier
			[[ "$ibmNotifierVALID" == "FALSE" ]] && sendToLog "Error: Unable to validate IBM Notifier.app after installation, attempting fallback to jamfHelper."
		else
			checkIbmNotifier
			if [[ "$ibmNotifierVALID" == "FALSE" ]]; then
				sendToLog "Startup: Removing existing IBM Notifier.app."
				rm -Rf "$ibmNotifierAPP" > /dev/null 2>&1
				[[ -d "$superFOLDER/__MACOSX" ]] && rm -Rf "$superFOLDER/__MACOSX" > /dev/null 2>&1
				getIbmNotifier
				[[ -d "$ibmNotifierAPP" ]] && checkIbmNotifier
			fi
			[[ "$ibmNotifierVALID" == "FALSE" ]] && sendToLog "Error: Unable to validate IBM Notifier.app after re-installation, attempting fallback to jamfHelper."
		fi
	else
		sendToLog "Warning: IBM Notifier.app is not compatible with this version of macOS, attempting fallback to jamfHelper."
	fi
else
	[[ "$helperERROR" == "FALSE" ]] && sendToLog "Startup: Prefer jamfHelper mode enabled."
fi

# If jamfHelper is to be used, then validate $jamfHelper and show some logs.
if [[ "$preferJamfHelperOPTION" == "TRUE" ]] || [[ "$ibmNotifierVALID" == "FALSE" ]]; then
	if [[ ! -e "$jamfHELPER" ]]; then
		sendToLog "Helper Error: Cannot locate fallback jamfHelper at: $jamfHELPER"; helperERROR="TRUE"
	fi
	sendToLog "Warning: Showing the deferral time inside the Defer button is not available when using jamfHelper."
	{ [[ -n $displayAccessoryTypeOPTION ]] || [[ -n $displayAccessoryContentOPTION ]]; } && sendToLog "Warning: The the custom display accessory option is not available when using jamfHelper."
	[[ -n $helpBUTTON ]] && sendToLog "Warning: The help button option is not available when using jamfHelper."
	[[ -n $warningBUTTON ]] && sendToLog "Warning: The warning button option is not available when using jamfHelper."
	[[ "$displaySilentlyOPTION" == "TRUE" ]] && sendToLog "Warning: The display silently option is not available when using jamfHelper."
fi

# This workflow error needs to go here because it requires the helpers are validated.
if [[ "$macOSARCH" == "arm64" ]] && { [[ "$upgradeWORKFLOW" == "USER" ]] || [[ "$updateWORKFLOW" == "USER" ]] || [[ -n $userAuthMDMFailoverOPTION ]]; } && { [[ "$preferJamfHelperOPTION" == "TRUE" ]] || [[ "$ibmNotifierVALID" == "FALSE" ]]; }; then
	sendToLog "Workflow Error: User authenticated workflows requires use of IBM Notifier.app"; workflowERROR="TRUE"
fi

# If needed, validate erase-install items, if missing or invalid then install and check again.
if [[ "$upgradeWORKFLOW" != "FALSE" ]]; then
	eraseInstallVALID="FALSE"
	if [[ ! -d "$eraseInstallFOLDER" ]]; then
		getEraseInstall
		[[ -d "$eraseInstallFOLDER" ]] && checkEraseInstall
		[[ "$eraseInstallVALID" == "FALSE" ]] && sendToLog "Error: Unable to validate erase-install items after installation, can not upgrade macOS."
	else
		checkEraseInstall
		if [[ "$eraseInstallVALID" == "FALSE" ]]; then
			sendToLog "Startup: Removing existing erase-install items."
			rm -Rf "$eraseInstallFOLDER" > /dev/null 2>&1
			getEraseInstall
			[[ -d "$eraseInstallFOLDER" ]] && checkEraseInstall
		fi
		[[ "$eraseInstallVALID" == "FALSE" ]] && sendToLog "Error: Unable to validate erase-install items after re-installation, can not upgrade macOS."
	fi
	[[ "$eraseInstallVALID" == "FALSE" ]] && helperERROR="TRUE"
fi
}

# Install items required by super.
superInstallation() {
# Figure out where super is running from and start Installation log if anything needs to be installed.
superPATH="$(dirname "$0")"
[[ ! -d "$superFOLDER" ]] && mkdir -p "$superFOLDER"

# Install super if it's running from any location that is not in the $superFOLDER or from the $superLINK.
if ! { [[ "$superPATH" == "$superFOLDER" ]] || [[ "$superPATH" == "$(dirname "$superLINK")" ]]; }; then
	sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALLATION ****"
	sendToLog "Installation: Copying file: $superFOLDER/super"
	cp "$0" "$superFOLDER/super" > /dev/null 2>&1
	if [[ ! -d "/usr/local/bin" ]]; then
		sendToLog "Installation: Creating local search path: /usr/local/bin"
		mkdir -p "/usr/local/bin"
		chmod -R a+rx "/usr/local/bin"
	fi
	sendToLog "Installation: Creating search path link: $superLINK"
	ln -s "$superFOLDER/super" "$superLINK" > /dev/null 2>&1
	sendToLog "Installation: Creating LaunchDaemon helper: $superFOLDER/super-starter"
/bin/cat <<EOSS > "$superFOLDER/super-starter"
#!/bin/sh
echo "\$(date +"%a %b %d %T") \$(hostname -s) \$(basename "\$0")[\$\$]: **** S.U.P.E.R.M.A.N. $superVERSION LAUNCHDAEMON ****" | tee -a "$superLOG"
"$superFOLDER/super" "\$@" &
disown -a
exit 0
EOSS
	touch "$asuListLOG"
	touch "$installerListLOG"
	touch "$asuLOG"
	touch "$installerLOG"
	touch "$mdmCommandLOG"
	touch "$mdmWorkflowLOG"
	sendToLog "Installation: Setting permissions in: $superFOLDER"
	chown -R root:wheel "$superFOLDER"
	chmod -R a+r "$superFOLDER"
	chmod a+x "$superFOLDER/super"
	chmod a+x "$superFOLDER/super-starter"
	chown root:wheel "$superLINK"
	chmod a+rx "$superLINK"
fi
}

# Prepare super by cleaning after previous super runs, record various maintenance modes, validate parameters, and liberate super from Jamf Policy runs.
superStartup() {
sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION STARTUP ****"
sendToStatus "Running: Startup workflow."
sendToPending "Currently running."

# If super is running after an update/upgrade restart and set $restartVALIDATE appropriately.
if [[ -f "$restartValidateFilePATH" ]]; then
	rm -f "$restartValidateFilePATH" 2> /dev/null
	restartVALIDATE="TRUE"
	defaults delete "$superPLIST" RestartValidate 2> /dev/null # This line is only here to remove any legacy RestartValidate keys.
	defaults delete "$superPLIST" InstallNow 2> /dev/null
	defaults delete "$superPLIST" SoftwareUpdatesList 2> /dev/null
	defaults delete "$superPLIST" macOSSoftwareUpgradeLabel 2> /dev/null
	defaults delete "$superPLIST" macOSSoftwareUpgradeTitle 2> /dev/null
	defaults delete "$superPLIST" macOSUpgradeName 2> /dev/null
	defaults delete "$superPLIST" macOSUpgradeVersion 2> /dev/null
	defaults delete "$superPLIST" macOSSoftwareUpdateDownloadLabel 2> /dev/null
	defaults delete "$superPLIST" LastReboot 2> /dev/null
	defaults delete "$superPLIST" macOSInstallerDownloadVersion 2> /dev/null
	defaults delete "$superPLIST" macOSInstallerDownloadName 2> /dev/null
	restartZeroDay
	restartDeferralCounters
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: Local preference file after restart validation $superPLIST is:\n$(defaults read "$superPLIST" 2> /dev/null)"
fi

# Collect any locally cached or managed preferences.
getPreferences

# Check for any previous super process still running, if so kill it.
if [[ -f "$superPIDFILE" ]]; then
	previousPID=$(cat "$superPIDFILE")
	sendToLog "Startup: Found previous super instance running with PID $previousPID, killing..."
	kill -9 "$previousPID" > /dev/null 2>&1
fi

# Kill any already running helper processes.
killall -9 "softwareupdate" > /dev/null 2>&1
killall -9 "IBM Notifier" "IBM Notifier Popup" > /dev/null 2>&1
killall -9 "jamfHelper" > /dev/null 2>&1

# Create $superPIDFILE for this instance of super.
echo $$ > "$superPIDFILE"

# This unloads and deletes any previous LaunchDaemons.
if [[ -f "/Library/LaunchDaemons/$launchDaemonNAME.plist" ]]; then
	sendToLog "Startup: Removing previous LaunchDaemon $launchDaemonNAME.plist."
	launchctl bootout system "/Library/LaunchDaemons/$launchDaemonNAME.plist" 2> /dev/null
	rm -f "/Library/LaunchDaemons/$launchDaemonNAME.plist"
fi

# Manage the $verboseModeOPTION and if enabled start additional logging.
if [[ $verboseModeOPTION -eq 1 ]] || [[ "$verboseModeOPTION" == "TRUE" ]]; then
	verboseModeOPTION="TRUE"
	defaults write "$superPLIST" VerboseMode -bool true
else
	verboseModeOPTION="FALSE"
	defaults delete "$superPLIST" VerboseMode 2> /dev/null
fi
if [[ "$verboseModeOPTION" == "TRUE" ]]; then
	sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: Verbose mode enabled."
	sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: Uptime is: $(uptime)"
	sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: Managed preference file $superMANAGEDPLIST is:\n$(defaults read "$superMANAGEDPLIST" 2> /dev/null)"
	sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: Local preference file before validation $superPLIST is:\n$(defaults read "$superPLIST" 2> /dev/null)"
fi

# Main parameter validation and management.
checkCurrentUser
manageParameters

# Workflow for for $openLOGS.
if [[ "$openLOGS" == "TRUE" ]]; then
	if [[ "$currentUserNAME" != "FALSE" ]]; then
		sendToLog "Startup: Opening logs for user \"$currentUserNAME\"."
		if [[ "$macOSARCH" == "arm64" ]]; then
			sudo -u "$currentUserNAME" open "$mdmWorkflowLOG"
			sudo -u "$currentUserNAME" open "$mdmCommandLOG"
		fi
		sudo -u "$currentUserNAME" open "$installerLOG"
		sudo -u "$currentUserNAME" open "$asuLOG"
		sudo -u "$currentUserNAME" open "$installerListLOG"
		sudo -u "$currentUserNAME" open "$asuListLOG"
		sudo -u "$currentUserNAME" open "$superLOG"
	else
		sendToLog "Startup: Open logs request denied because there is currently no local user logged into the GUI."
	fi
fi

# Additional validation and management.
[[ "$macOSARCH" == "arm64" ]] && manageUpdateCredentials
manageWorkflowOptions
manageHelpers
[[ "$verboseModeOPTION" == "TRUE" ]] && logParameters
if [[ "$parameterERROR" == "TRUE" ]] || [[ "$credentialERROR" == "TRUE" ]] || [[ "$workflowERROR" == "TRUE" ]] || [[ "$helperERROR" == "TRUE" ]]; then
	sendToLog "Exit: Startup validation failed."
	sendToStatus "Inactive Error: Startup validation failed."
	errorExit
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: Local preference file after all validations $superPLIST is:\n$(defaults read "$superPLIST" 2> /dev/null)"

# If super is running via Jamf, then restart via LaunchDaemon to release the jamf process.
# This is late in the startup workflow so as to only create a valid LaunchDaemon after parameter validation and housekeeping.
if [[ $1 == "/" ]] || [[ $(ps -p "$PPID" | awk '{print $4;}' | grep -c -i 'jamf') -gt 0 ]] || [[ $(ps -p "$PPID" | awk '{print $6;}' | grep -c -i 'jamf') -gt 0 ]]; then
	sendToLog "Startup: Found that Jamf is installing or is the parent process, restarting with new LaunchDaemon..."
	sendToStatus "Pending: Found that Jamf is installing or is the parent process, restarting with new LaunchDaemon."
	makeLaunchDaemonRestartNow
fi

# If super is running from outside the $superFOLDER, then restart via LaunchDaemon to release any parent installer process.
if ! { [[ "$superPATH" == "$superFOLDER" ]] || [[ "$superPATH" == "$(dirname "$superLINK")" ]]; }; then
	sendToLog "Startup: Found that super is installing, restarting with new LaunchDaemon..."
	sendToStatus "Pending: Found that super is installing, restarting with new LaunchDaemon."
	makeLaunchDaemonRestartNow
fi

# Wait for a valid network connection. If there is still no network after two minutes, an automatic deferral is started.
networkTIMEOUT=0
while [[ $(ifconfig -a inet 2>/dev/null | sed -n -e '/127.0.0.1/d' -e '/0.0.0.0/d' -e '/inet/p' | wc -l) -le 0 ]] && [[ $networkTIMEOUT -lt 120 ]]; do
	sendToLog "Startup: Waiting for network..."
	sleep 5
	networkTIMEOUT=$((networkTIMEOUT + 5))
done
if [[ $(ifconfig -a inet 2>/dev/null | sed -n -e '/127.0.0.1/d' -e '/0.0.0.0/d' -e '/inet/p' | wc -l) -le 0 ]]; then
	if [[ "$installNowOPTION" == "TRUE" ]]; then
		sendToLog "Error: Network unavailable, install now workflow can not continue."
		sendToStatus "Inactive Error: Network unavailable, install now workflow can not continue."
		notifyInstallNowFailure
		errorExit
	else
		deferSECONDS="$errorDeferSECONDS"
		sendToLog "Error: Network unavailable, trying again in $deferSECONDS seconds."
		sendToStatus "Pending: Network unavailable, trying again in $deferSECONDS seconds."
		makeLaunchDaemonCalendar
	fi
fi

# With startup complete, create a fail-safe startup LaunchDaemon in case the system is restarted (via the user or something else) wile super is active.
sendToLog "Startup: Creating fail-safe startup LaunchDaemon."
makeLaunchDaemonOnStartup
defaults write "$superPLIST" FailSafeActive -bool true
}

# This function is used when the super workflow exits with no errors.
cleanExit() {
[[ -n "$jamfProTOKEN" ]] && deleteJamfProServerToken
defaults delete "$superPLIST" InstallNow 2> /dev/null
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: Local preference file $superPLIST is:\n$(defaults read "$superPLIST" 2> /dev/null)"
sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION EXIT ****"
rm -f "$superPIDFILE"
exit 0
}

# This function is used when the super workflow must exit due to an unrecoverable error.
errorExit() {
[[ -n "$jamfProTOKEN" ]] && deleteJamfProServerToken
defaults delete "$superPLIST" InstallNow 2> /dev/null
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: Local preference file $superPLIST is:\n$(defaults read "$superPLIST" 2> /dev/null)"
sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION ERROR EXIT ****"
sendToPending "Inactive."
rm -f "$superPIDFILE"
exit 1
}

# MARK: *** Logging ***
################################################################################

# Append input to the command line and log located at $superLOG.
sendToLog() {
echo -e "$(date +"%a %b %d %T") $(hostname -s) $(basename "$0")[$$]: $*" | tee -a "$superLOG"
}

# Send input to the command line only, so as not to save secrets to the $superLOG.
sendToEcho() {
echo -e "$(date +"%a %b %d %T") $(hostname -s) $(basename "$0")[$$]: Not Logged: $*"
}

# Send input to the command line only replacing the current line, so as not to save save interactive progress updates to the $superLOG.
sendToEchoReplaceLine() {
echo -ne "$(date +"%a %b %d %T") $(hostname -s) $(basename "$0")[$$]: Not Logged: $*\r"
}

# Append input to a log located at $asuLOG.
sendToASULog() {
echo -e "\n$(date +"%a %b %d %T") $(hostname -s) $(basename "$0")[$$]: $*" >> "$asuLOG"
}

# Append input to a log located at $installerLOG.
sendToInstallerLog() {
echo -e "$(date +"%a %b %d %T") $(hostname -s) $(basename "$0")[$$]: $*" >> "$installerLOG"
}

# Append input to a log located at $mdmCommandLOG.
sendToMDMCommandLog() {
echo -e "$(date +"%a %b %d %T") $(hostname -s) $(basename "$0")[$$]: $*" >> "$mdmCommandLOG"
}

# Append input to a log located at $mdmWorkflowLOG.
sendToMDMWorkflowLog() {
echo -e "$(date +"%a %b %d %T") $(hostname -s) $(basename "$0")[$$]: $*" >> "$mdmWorkflowLOG"
}

# Update the SuperStatus key in the $superPLIST.
sendToStatus() {
defaults write "$superPLIST" SuperStatus -string "$(date +"%a %b %d %T"): $*"
}

# Update the SuperPending key in the $superPLIST.
sendToPending() {
defaults write "$superPLIST" SuperPending -string "$*"
}

# Log any parameters that have values.
logParameters() {
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: superVERSION is: $superVERSION"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: superDATE is: $superDATE"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSMAJOR is: $macOSMAJOR"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSMINOR is: $macOSMINOR"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSVERSION is: $macOSVERSION"
[[ "$macOSMAJOR" -ge 13 ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSEXTRA is: $macOSEXTRA"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSARCH is: $macOSARCH"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macModelID is: $macModelID"
[[ -n $macBOOK ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macBOOK is: $macBOOK"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: lastREBOOT is: $lastREBOOT"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: parameterERROR is: $parameterERROR"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: credentialERROR is: $credentialERROR"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowERROR is: $workflowERROR"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: helperERROR is: $helperERROR"
[[ -n $jamfVERSION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfVERSION is: $jamfVERSION"
[[ -n $jamfSERVER ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfSERVER is: $jamfSERVER"
[[ -n $ibmNotifierVALID ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: ibmNotifierVALID is: $ibmNotifierVALID"
[[ -n $eraseInstallVALID ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: eraseInstallVALID is: $eraseInstallVALID"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: defaultDeferSECONDS is: $defaultDeferSECONDS"
[[ -n $focusDeferSECONDS ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: focusDeferSECONDS is: $focusDeferSECONDS"
[[ -n $menuDeferSECONDS ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: menuDeferSECONDS is: $menuDeferSECONDS"
[[ -n $recheckDeferSECONDS ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: recheckDeferSECONDS is: $recheckDeferSECONDS"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: errorDeferSECONDS is: $errorDeferSECONDS"
[[ -n $focusCountMAX ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: focusCountMAX is: $focusCountMAX"
[[ -n $softCountMAX ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softCountMAX is: $softCountMAX"
[[ -n $hardCountMAX ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: hardCountMAX is: $hardCountMAX"
[[ -n $focusDaysMAX ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: focusDaysMAX is: $focusDaysMAX"
[[ -n $softDaysMAX ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softDaysMAX is: $softDaysMAX"
[[ -n $hardDaysMAX ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: hardDaysMAX is: $hardDaysMAX"
[[ -n $zeroDayOVERRIDE ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: zeroDayOVERRIDE is: $zeroDayOVERRIDE"
[[ -n $focusDateMAX ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: focusDateMAX is: $focusDateMAX"
[[ -n $softDateMAX ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softDateMAX is: $softDateMAX"
[[ -n $hardDateMAX ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: hardDateMAX is: $hardDateMAX"
[[ -n $deferDialogTimeoutSECONDS ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deferDialogTimeoutSECONDS is: $deferDialogTimeoutSECONDS"
[[ -n $softDialogTimeoutSECONDS ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softDialogTimeoutSECONDS is: $softDialogTimeoutSECONDS"
[[ -n $displayRedrawSECONDS ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: displayRedrawSECONDS is: $displayRedrawSECONDS"
[[ -n $ibmNotifierIconSIZE ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: ibmNotifierIconSIZE is: $ibmNotifierIconSIZE"
[[ -n $jamfHelperIconSIZE ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfHelperIconSIZE is: $jamfHelperIconSIZE"
[[ -n $displayAccessoryTYPE ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: displayAccessoryTYPE is: $displayAccessoryTYPE"
[[ -n $displayAccessoryDefaultCONTENT ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: displayAccessoryDefaultCONTENT is: $displayAccessoryDefaultCONTENT"
[[ -n $displayAccessoryUpdateCONTENT ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: displayAccessoryUpdateCONTENT is: $displayAccessoryUpdateCONTENT"
[[ -n $displayAccessoryUpgradeCONTENT ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: displayAccessoryUpgradeCONTENT is: $displayAccessoryUpgradeCONTENT"
[[ -n $displayAccessoryUserAuthCONTENT ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: displayAccessoryUserAuthCONTENT is: $displayAccessoryUserAuthCONTENT"
[[ -n $helpBUTTON ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: helpBUTTON is: $helpBUTTON"
[[ -n $warningBUTTON ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: warningBUTTON is: $warningBUTTON"
[[ -n $displaySilentlyOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: displaySilentlyOPTION is: $displaySilentlyOPTION"
[[ -n $preferJamfHelperOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: preferJamfHelperOPTION is: $preferJamfHelperOPTION"
[[ -n $localOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: localOPTION is: $localOPTION"
[[ -n $localPASSWORD ]] && sendToEcho "Verbose Mode: Function ${FUNCNAME[0]}: localPASSWORD is: $localPASSWORD"
[[ -n $localACCOUNT ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: localACCOUNT is: $localACCOUNT"
[[ -n $localKEYCHAIN ]] && sendToEcho "Verbose Mode: Function ${FUNCNAME[0]}: localKEYCHAIN is: $localKEYCHAIN"
[[ -n $localCREDENTIAL ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: localCREDENTIAL is: $localCREDENTIAL"
[[ -n $adminACCOUNT ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: adminACCOUNT is: $adminACCOUNT"
[[ -n $adminPASSWORD ]] && sendToEcho "Verbose Mode: Function ${FUNCNAME[0]}: adminPASSWORD is: $adminPASSWORD"
[[ -n $superOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: superOPTION is: $superOPTION"
[[ -n $superPASSWORD ]] && sendToEcho "Verbose Mode: Function ${FUNCNAME[0]}: superPASSWORD is: $superPASSWORD"
[[ -n $superACCOUNT ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: superACCOUNT is: $superACCOUNT"
[[ -n $superKEYCHAIN ]] && sendToEcho "Verbose Mode: Function ${FUNCNAME[0]}: superKEYCHAIN is: $superKEYCHAIN"
[[ -n $superCREDENTIAL ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: superCREDENTIAL is: $superCREDENTIAL"
[[ -n $JamfProID ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: JamfProID is: $JamfProID"
[[ -n $jamfOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfOPTION is: $jamfOPTION"
[[ -n $jamfPASSWORD ]] && sendToEcho "Verbose Mode: Function ${FUNCNAME[0]}: jamfPASSWORD is: $jamfPASSWORD"
[[ -n $jamfACCOUNT ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfACCOUNT is: $jamfACCOUNT"
[[ -n $jamfKEYCHAIN ]] && sendToEcho "Verbose Mode: Function ${FUNCNAME[0]}: jamfKEYCHAIN is: $jamfKEYCHAIN"
[[ -n $jamfCREDENTIAL ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfCREDENTIAL is: $jamfCREDENTIAL"
[[ -n $deleteACCOUNTS ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deleteACCOUNTS is: $deleteACCOUNTS"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: userAuthTimeoutSECONDS is: $userAuthTimeoutSECONDS"
[[ -n $userAuthMDMFailoverOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: userAuthMDMFailoverOPTION is: $userAuthMDMFailoverOPTION"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: userAuthMDMFAILOVER is: $userAuthMDMFAILOVER"
[[ -n $userAuthMDMFailoverSOFT ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: userAuthMDMFailoverSOFT is: $userAuthMDMFailoverSOFT"
[[ -n $userAuthMDMFailoverHARD ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: userAuthMDMFailoverHARD is: $userAuthMDMFailoverHARD"
[[ -n $userAuthMDMFailoverINSTALLNOW ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: userAuthMDMFailoverINSTALLNOW is: $userAuthMDMFailoverINSTALLNOW"
[[ -n $userAuthMDMFailoverBOOTSTRAP ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: userAuthMDMFailoverBOOTSTRAP is: $userAuthMDMFailoverBOOTSTRAP"
[[ -n $allowUpgradeOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: allowUpgradeOPTION is: $allowUpgradeOPTION"
[[ -n $targetUpgradeVERSION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: targetUpgradeVERSION is: $targetUpgradeVERSION"
[[ -n $allowRSRUpdatesOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: allowRSRUpdatesOPTION is: $allowRSRUpdatesOPTION"
[[ -n $enforceNonSystemUpdatesOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: enforceNonSystemUpdatesOPTION is: $enforceNonSystemUpdatesOPTION"
[[ -n $onlyDownloadOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: onlyDownloadOPTION is: $onlyDownloadOPTION"
[[ -n $installNowOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: installNowOPTION is: $installNowOPTION"
[[ -n $policyTRIGGERS ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: policyTRIGGERS is: $policyTRIGGERS"
[[ -n $skipUpdatesOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: skipUpdatesOPTION is: $skipUpdatesOPTION"
[[ -n $restartWithoutUpdatesOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: restartWithoutUpdatesOPTION is: $restartWithoutUpdatesOPTION"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: freeSpaceUpdateGB is: $freeSpaceUpdateGB"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: freeSpaceUpgradeGB is: $freeSpaceUpgradeGB"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: freeSpaceTimeoutSECONDS is: $freeSpaceTimeoutSECONDS"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: batteryLevelPERCENT is: $batteryLevelPERCENT"
sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: batteryTimeoutSECONDS is: $batteryTimeoutSECONDS"
[[ -n $testModeOPTION ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: testModeOPTION is: $testModeOPTION"
[[ -n $testModeTimeoutSECONDS ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: testModeTimeoutSECONDS is: $testModeTimeoutSECONDS"
}

# MARK: *** Jamf Pro API ***
################################################################################

# Validate the connection to a managed computer's Jamf Pro service and set $jamfSERVER accordingly.
getJamfProServer() {
jamfSTATUS=$("$jamfBINARY" checkJSSConnection -retry 1 2>/dev/null)
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfSTATUS is: $jamfSTATUS"
if [[ $(echo "$jamfSTATUS" | grep -c 'available') -gt 0 ]]; then
	jamfSERVER=$(defaults read /Library/Preferences/com.jamfsoftware.jamf.plist jss_url)
else
	sendToLog "Warning: Jamf Pro service unavailable."; jamfSERVER="FALSE"; jamfERROR="TRUE"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfSTATUS is: $jamfSTATUS"
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfSERVER is: $jamfSERVER"
}

# Attempt to acquire a Jamf Pro $jamfProTOKEN via $jamfACCOUNT and $jamfKEYCHAIN credentials.
getJamfProToken() {
getJamfProServer
if [[ "$jamfSERVER" != "FALSE" ]]; then
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfACCOUNT is: $jamfACCOUNT"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToEcho "Verbose Mode: Function ${FUNCNAME[0]}: jamfKEYCHAIN is: $jamfKEYCHAIN"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfSERVER is: $jamfSERVER"
	commandRESULT=$(curl -X POST -u "$jamfACCOUNT:$jamfKEYCHAIN" -s "${jamfSERVER}api/v1/auth/token")
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: commandRESULT is:\n$commandRESULT"
	if [[ $(echo "$commandRESULT" | grep -c 'token') -gt 0 ]]; then
		if [[ $macOSMAJOR -ge 12 ]]; then
			jamfProTOKEN=$(echo "$commandRESULT" | plutil -extract token raw -)
		else
			jamfProTOKEN=$(echo "$commandRESULT" | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
		fi
	else
		sendToLog "Error: Response from Jamf Pro API token request did not contain a token."; jamfERROR="TRUE"
	fi
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfProTOKEN is:\n$jamfProTOKEN"
fi
}

# Validate that the account $jamfACCOUNT and $jamfKEYCHAIN are valid credentials and has appropriate permissions to send MDM push commands. If not set $jamfERROR.
getJamfProAccount() {
getJamfProToken
if [[ -n $jamfProTOKEN ]]; then
	getJamfProComputerID
	if [[ -n $jamfProID ]]; then
		sendBlankPush
			if [[ $commandRESULT != 201 ]]; then
				sendToLog "Error: Unable to request Blank Push via Jamf Pro API user account \"$jamfACCOUNT\". Verify this account has has the privileges \"Jamf Pro Server Objects > Computers > Create & Read\"."; jamfERROR="TRUE"
			fi
	else
		sendToLog "Error: Unable to acquire Jamf Pro ID for computer with UDID \"$computerUDID\". Verify that this computer is enrolled in Jamf Pro."
		sendToLog "Error: Also verify that the Jamf Pro API account \"$jamfACCOUNT\" has the privileges \"Jamf Pro Server Objects > Computers > Create & Read\"."; jamfERROR="TRUE"
	fi
else
	sendToLog "Error: Unable to acquire authentication token via Jamf Pro API user account \"$jamfACCOUNT\". Verify account name and password."; jamfERROR="TRUE"
fi
}

# Use $jamfProIdMANAGED or $jamfProTOKEN to find the computer's Jamf Pro ID and set $jamfProID.
getJamfProComputerID() {
computerUDID=$(system_profiler SPHardwareDataType | awk '/UUID/ { print $3; }')
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: computerUDID is: $computerUDID"
if [[ -n $jamfProIdMANAGED ]]; then
	jamfProID="$jamfProIdMANAGED"
else
	sendToLog "Warning: Using a Jamf Pro API account with \"Computers > Read\" privileges to collect the computer ID is a security risk. Instead use a custom Configuration Profile with the following; Preference Domain \"com.macjutsu.super\", Key \"JamfProID\", String \"\$JSSID\"."
	jamfProID=$(curl --header "Authorization: Bearer ${jamfProTOKEN}" --header "Accept: application/xml" --request GET --url "${jamfSERVER}JSSResource/computers/udid/${computerUDID}/subset/General" 2> /dev/null | xpath -e /computer/general/id 2>&1 | awk -F '<id>|</id>' '{print $2}' | xargs)
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfProID is: $jamfProID"
}

# Attempt to send a Blank Push to Jamf Pro.
sendBlankPush() {
commandRESULT=$(curl --header "Authorization: Bearer ${jamfProTOKEN}" --write-out "%{http_code}" --silent --output /dev/null --request POST --url "${jamfSERVER}JSSResource/computercommands/command/BlankPush/id/${jamfProID}")
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: commandRESULT is:\n$commandRESULT"
}

# Validate existing $jamfProTOKEN and if found invalid, a new token is requested and again validated.
checkJamfProServerToken() {
tokenCHECK=$(curl --header "Authorization: Bearer ${jamfProTOKEN}" --write-out "%{http_code}" --silent --output /dev/null --request GET --url "${jamfSERVER}api/v1/auth")
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: tokenCHECK is: $tokenCHECK"
if [[ $tokenCHECK -ne 200 ]]; then
	getJamfProToken
	tokenCHECK=$(curl --header "Authorization: Bearer ${jamfProTOKEN}" --write-out "%{http_code}" --silent --output /dev/null --request GET --url "${jamfSERVER}api/v1/auth")
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: tokenCHECK is: $tokenCHECK"
	if [[ $tokenCHECK -ne 200 ]]; then
		if [[ "$installNowOPTION" == "TRUE" ]]; then
			sendToLog "Error: Could not request Jamf Pro API token for account \"$jamfACCOUNT\", install now workflow can not continue."
			sendToStatus "Inactive Error: Could not request Jamf Pro API token for account \"$jamfACCOUNT\", install now workflow can not continue."
			notifyInstallNowFailure
			errorExit
		else
			deferSECONDS="$errorDeferSECONDS"
			sendToLog "Error: Could not request Jamf Pro API token for account \"$jamfACCOUNT\", trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Could not request Jamf Pro API token for account \"$jamfACCOUNT\", trying again in $deferSECONDS seconds."
			makeLaunchDaemonCalendar
		fi
	fi
fi
}

# Invalidate and remove from local memory the $jamfProTOKEN.
deleteJamfProServerToken() {
invalidateTOKEN=$(curl --header "Authorization: Bearer ${jamfProTOKEN}" --write-out "%{http_code}" --silent --output /dev/null --request POST --url "${jamfSERVER}api/v1/auth/invalidate-token")
if [[ $invalidateTOKEN -eq 204 ]]; then
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: Jamf Pro API token successfully invalidated."
	unset jamfProTOKEN
elif [[ $invalidateTOKEN -eq 401 ]]; then
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: Jamf Pro API token already invalid."
	unset jamfProTOKEN
else
	sendToLog "Error: Invalidating Jamf Pro API token."
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: invalidateTOKEN is: $invalidateTOKEN"
fi
}

# MARK: *** Local System Validation ***
################################################################################

# Verify that super is running with root privileges.
checkRoot() {
if [[ "$(id -u)" -ne 0 ]]; then
	sendToEcho "Exit: $(basename "$0") must run with root privileges."
	errorExit
fi
}

# Set $currentUserNAME to the currently logged in GUI user or "FALSE" if there is none or a system account.
# If the current user is a normal account then this also sets $currentUserUID, $currentUserGUID, $currentUserRealNAME, $currentUserADMIN, $currentUserSecureTOKEN, and $currentUserVolumeOWNER
checkCurrentUser() {
currentUserNAME=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ { print $3 }')
if [[ -z $currentUserNAME ]]; then
	sendToLog "Status: No GUI user currently logged in."
	currentUserNAME="FALSE"
	currentUserUID="FALSE"
elif [[ "$currentUserNAME" = "root" ]] || [[ "$currentUserNAME" = "_mbsetupuser" ]] || [[ "$currentUserNAME" = "loginwindow" ]]; then
	sendToLog "Status: Current GUI user is system account \"$currentUserNAME\"."
	currentUserNAME="FALSE"
	currentUserUID="0"
else
	sendToLog "Status: Current GUI user name is \"$currentUserNAME\"."
fi
if [[ "$currentUserNAME" != "FALSE" ]]; then
	currentUserUID=$(id -u "$currentUserNAME" 2> /dev/null)
	currentUserGUID=$(dscl . read "/Users/$currentUserNAME" GeneratedUID 2> /dev/null | awk '{print $2;}')
	currentUserRealNAME=$(dscl . read "/Users/$currentUserNAME" RealName 2> /dev/null | tail -1 | sed -e 's/RealName: //g' | xargs)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: currentUserUID is: $currentUserUID"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: currentUserGUID is: $currentUserGUID"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: currentUserRealNAME is: $currentUserRealNAME"
	if [[ -n $currentUserUID ]] && [[ -n $currentUserGUID ]] && [[ -n $currentUserRealNAME ]]; then
		if [[ $(groups "$currentUserNAME" 2> /dev/null | grep -c 'admin') -gt 0 ]]; then
			currentUserADMIN="TRUE"
		else
			currentUserADMIN="FALSE"
		fi
		if [[ $(dscl . read "/Users/$currentUserNAME" AuthenticationAuthority 2> /dev/null | grep -c 'SecureToken') -gt 0 ]]; then
			currentUserSecureTOKEN="TRUE"
		else
			currentUserSecureTOKEN="FALSE"
		fi
		if [[ $(diskutil apfs listcryptousers / 2> /dev/null | grep -c "$currentUserGUID") -gt 0 ]]; then
			currentUserVolumeOWNER="TRUE"
		else
			currentUserVolumeOWNER="FALSE"
		fi
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: currentUserADMIN is: $currentUserADMIN"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: currentUserSecureTOKEN is: $currentUserSecureTOKEN"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: currentUserVolumeOWNER is: $currentUserVolumeOWNER"
	else
		sendToLog "Parameter Error: Unable to determine account details for user \"$currentUserNAME\"."; parameterERROR="TRUE"
	fi
fi
}

# Validate that the account $updateACCOUNT and $updateKEYCHAIN are valid credentials is a volume owner. If not set $accountERROR.
checkLocalUpdateAccount() {
accountGUID=$(dscl . read "/Users/$updateACCOUNT" GeneratedUID 2> /dev/null | awk '{print $2;}')
if [[ -n $accountGUID ]]; then
	if ! [[ $(diskutil apfs listcryptousers / | grep -c "$accountGUID") -gt 0 ]]; then
		sendToLog "Error: Provided account \"$updateACCOUNT\" is not a system volume owner."; accountERROR="TRUE"
	fi
	accountVALID=$(dscl /Local/Default -authonly "$updateACCOUNT" "$updateKEYCHAIN" 2>&1)
	if ! [[ "$accountVALID" == "" ]];then
		sendToLog "Error: The provided password for account \"$updateACCOUNT\" is not valid."; accountERROR="TRUE"
	fi
else
	sendToLog "Error: Could not retrieve GUID for account \"$updateACCOUNT\". Verify that account exists locally."; accountERROR="TRUE"
fi
}

# Collect the available free storage and set $storageREADY accordingly. This also sets $availableStorageGB and $requiredStorageGB.
checkAvailableStorage() {
storageREADY="FALSE"
[[ -z $currentUserNAME ]] && checkCurrentUser
[[ "$currentUserNAME" != "FALSE" ]] && availableStorageGB=$(osascript -l 'JavaScript' -e "ObjC.import('Foundation'); var freeSpaceBytesRef=Ref(); $.NSURL.fileURLWithPath('/').getResourceValueForKeyError(freeSpaceBytesRef, 'NSURLVolumeAvailableCapacityForImportantUsageKey', null); Math.round(ObjC.unwrap(freeSpaceBytesRef[0]) / 1000000000)")
[[ "$currentUserNAME" == "FALSE" ]] && availableStorageGB=$(/usr/libexec/mdmclient QueryDeviceInformation 2> /dev/null | grep AvailableDeviceCapacity | head -n 1 | awk '{print $3}' | sed -e 's/;//g' -e 's/"//g' -e 's/\.[0-9]*//g')
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: availableStorageGB: $availableStorageGB"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeVersionTARGET: $macOSUpgradeVersionTARGET"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateMACOS: $softwareUpdateMACOS"
if [[ -z $availableStorageGB ]] || [[ ! $availableStorageGB =~ $regexNUMBER ]]; then
	if [[ "$installNowOPTION" == "TRUE" ]]; then
		sendToLog "Error: Unable to determine available free storage, install now workflow can not continue."
		sendToStatus "Inactive Error: Unable to determine available free storage, install now workflow can not continue."
		notifyInstallNowFailure
		errorExit
	else
		deferSECONDS="$errorDeferSECONDS"
		sendToLog "Error: Unable to determine available free storage, trying again in $deferSECONDS seconds."
		sendToStatus "Pending: Unable to determine available free storage, trying again in $deferSECONDS seconds."
		makeLaunchDaemonCalendar
	fi
elif [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]] || [[ "$softwareUpdateMACOS" == "TRUE" ]]; then
	{ [[ -z $freeSpaceUpdateOPTION ]] && [[ $macOSSoftwareUpdateGB -gt 5 ]]; } && freeSpaceUpdateGB=$((macOSSoftwareUpdateGB*2))
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerDownloadREQUIRED: $macOSInstallerDownloadREQUIRED"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateDownloadREQUIRED: $macOSSoftwareUpdateDownloadREQUIRED"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: freeSpaceUpgradeGB: $freeSpaceUpgradeGB"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpgradeGB: $macOSSoftwareUpgradeGB"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerGB: $macOSInstallerGB"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: freeSpaceUpdateGB: $freeSpaceUpdateGB"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateGB: $macOSSoftwareUpdateGB"
	if [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; then # A macOS upgrade is available and option to allow upgrade is enabled.
		if [[ "$upgradeWORKFLOW" == "LOCAL" ]] || [[ "$upgradeWORKFLOW" == "USER" ]]; then
			if [[ $macOSVERSION -ge 1203 ]]; then # macOS 12.3 or newer upgrade via softwareupdate.
				if [[ "$macOSSoftwareUpdateDownloadREQUIRED" == "TRUE" ]]; then
					requiredStorageGB=$((freeSpaceUpgradeGB+macOSSoftwareUpgradeGB))
				else # Download calculation is not required.
					requiredStorageGB=$freeSpaceUpgradeGB
				fi
			else # Systems older than macOS 12.3 upgrade via installer.
				if [[ "$macOSInstallerDownloadREQUIRED" == "TRUE" ]]; then
					requiredStorageGB=$((freeSpaceUpgradeGB+macOSInstallerGB))
				else # Download calculation is not required.
					requiredStorageGB=$freeSpaceUpgradeGB
				fi
			fi
		elif [[ "$upgradeWORKFLOW" == "JAMF" ]]; then # MDM upgrade workflow via installer.
			if [[ "$macOSInstallerDownloadREQUIRED" == "TRUE" ]]; then
				requiredStorageGB=$((freeSpaceUpgradeGB+macOSInstallerGB))
			else # Download calculation is not required.
				requiredStorageGB=$freeSpaceUpgradeGB
			fi
		fi
	else # macOS updates are available.
		if [[ "$macOSSoftwareUpdateDownloadREQUIRED" == "TRUE" ]]; then
			requiredStorageGB=$((freeSpaceUpdateGB+macOSSoftwareUpdateGB))
		else # Download calculation is not required.
			requiredStorageGB=$freeSpaceUpdateGB
		fi
	fi
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: requiredStorageGB: $requiredStorageGB"
	[[ $availableStorageGB -ge $requiredStorageGB ]] && storageREADY="TRUE"
else # No macOS update/upgrade is available.
	storageREADY="TRUE"
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: storageREADY: $storageREADY"
}

# Validate if current system power is adequate for performing a macOS update/upgrade and set $powerREADY accordingly. Desktops, obviously, always return that they are ready.
checkAvailablePower() {
powerREADY="FALSE"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macBOOK: $macBOOK"
if [[ "$macBOOK" == "TRUE" ]]; then
	[[ $(pmset -g ps | grep -ic 'AC Power') -ne 0 ]] && acPOWER="TRUE"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: acPOWER: $acPOWER"
	if [[ "$acPOWER" == "TRUE" ]]; then
		powerREADY="TRUE"
	else # Not plugged into AC power.
		currentBatteryLEVEL=$(pmset -g ps | grep '%' | awk '{print $3}' | sed -e 's/%;//g')
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: currentBatteryLEVEL: $currentBatteryLEVEL"
		if [[ -z $currentBatteryLEVEL ]] || [[ ! $currentBatteryLEVEL =~ $regexNUMBER ]]; then
			if [[ "$installNowOPTION" == "TRUE" ]]; then
				sendToLog "Error: Unable to determine battery power level, install now workflow can not continue."
				sendToStatus "Inactive Error: Unable to determine battery power level, install now workflow can not continue."
				notifyInstallNowFailure
				errorExit
			else
				deferSECONDS="$errorDeferSECONDS"
				sendToLog "Error: Unable to determine battery power level, trying again in $deferSECONDS seconds."
				sendToStatus "Pending: Unable to determine available free storage, trying again in $deferSECONDS seconds."
				makeLaunchDaemonCalendar
			fi
		else # Battery level is a real number.
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: batteryLevelPERCENT: $batteryLevelPERCENT"
			[[ $currentBatteryLEVEL -gt $batteryLevelPERCENT ]] && powerREADY="TRUE"
		fi
	fi
else # Mac desktop.
	powerREADY="TRUE"
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: powerREADY: $powerREADY"
}

# Validate the computer's MDM service status and set $mdmENROLLED, $mdmDEP, and $mdmSERVICE
checkMDMService() {
mdmENROLLED="FALSE"
mdmDEP="FALSE"
mdmSERVICE="FALSE"
profilesRESULT=$(profiles status -type enrollment 2>&1)
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: profilesRESULT:\n$profilesRESULT"
if [[ $(echo "$profilesRESULT" | grep -c 'MDM server') -gt 0 ]]; then
	mdmENROLLED="TRUE"
	[[ $(echo "$profilesRESULT" | grep 'Enrolled via DEP:' | grep -c 'Yes') -gt 0 ]] && mdmDEP="TRUE"
	mdmSERVICE="https://$(echo "$profilesRESULT" | grep 'MDM server' | awk -F '/' '{print $3}')"
	curlRESULT=$(curl -Is "$mdmSERVICE" | head -n 1)
	if [[ $(echo "$curlRESULT" | grep -c 'HTTP') -gt 0 ]] && [[ $(echo "$curlRESULT" | grep -c -e '400' -e '40[4-9]' -e '4[1-9][0-9]' -e '5[0-9][0-9]') -eq 0 ]]; then
		sendToLog "Status: MDM service is currently available at: $mdmSERVICE"
	else
		sendToLog "Warning: MDM service at $mdmSERVICE is currently unavailable with stauts: $curlRESULT"
		mdmSERVICE="FALSE"
	fi
else
	sendToLog "Warning: System is not enrolled with a MDM service."
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: mdmENROLLED: $mdmENROLLED"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: mdmDEP: $mdmDEP"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: mdmSERVICE: $mdmSERVICE"
}

# Validate that the computer's bootstrap token is properly escrowed and set $bootstrapTOKEN.
checkBootstrapToken() {
bootstrapTOKEN="FALSE"
profilesRESULT=$(profiles status -type bootstraptoken 2>&1)
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: profilesRESULT:\n$profilesRESULT"
if [[ $(echo "$profilesRESULT" | grep -c 'YES') -eq 2 ]]; then
	if [[ "$macOSVERSION" -ge 1303 ]]; then
		if [[ "$mdmSERVICE" != "FALSE" ]]; then
			queryDeviceINFO=$(/usr/libexec/mdmclient QueryDeviceInformation 2> /dev/null | grep 'EACSPreflight' | sed -e 's/        EACSPreflight = //g' -e 's/"//g' -e 's/;//g')
			if [[ $(echo "$queryDeviceINFO" | grep -c 'success') -gt 0 ]] || [[ $(echo "$queryDeviceINFO" | grep -c 'EFI password exists') -gt 0 ]]; then
				sendToLog "Status: Bootstrap token escrowed and validated with MDM service."
				bootstrapTOKEN="TRUE"
			else
				sendToLog "Warning: Bootstrap token escrow validation failed with status: $queryDeviceINFO"
			fi
		else
			sendToLog "Warning: Bootstrap token was previously escrowed with MDM service but the service is currently unavailable so it can not be validated."
		fi
	else
		sendToLog "Status: Bootstrap token escrowed with MDM service."
		bootstrapTOKEN="TRUE"
	fi
else
	sendToLog "Warning: Bootstrap token is not escrowed with MDM service."
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: bootstrapTOKEN: $bootstrapTOKEN"
}

# MARK: *** Deferrals & Deadlines Prep ***
################################################################################

# Delete the maximum deferral counters in $superPLIST to restart the counters.
restartZeroDay() {
sendToLog "Status: Restarting automatically set zero day date."
defaults delete "$superPLIST" ZeroDayAuto 2> /dev/null
}

# Delete the maximum deferral counters in $superPLIST to restart the counters.
restartDeferralCounters() {
sendToLog "Status: Restarting maximum deferral counters."
defaults delete "$superPLIST" FocusCounter 2> /dev/null
defaults delete "$superPLIST" SoftCounter 2> /dev/null
defaults delete "$superPLIST" HardCounter 2> /dev/null
}

# Evaluate $zeroDayOVERRIDE and $zeroDayPREVIOUS, then set $zeroDaySTART, $zeroDayEPOCH, and $zeroDayDISPLAY accordingly.
checkZeroDay() {
if [[ -n $zeroDayOVERRIDE ]]; then # If there is a $zeroDayOVERRIDE then use that first.
	zeroDaySTART="$zeroDayOVERRIDE"
	sendToLog "Status: Using manually set zero day date of $zeroDaySTART."
else
	zeroDayPREVIOUS=$(defaults read "$superPLIST" ZeroDayAuto 2> /dev/null)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: zeroDayPREVIOUS: $zeroDayPREVIOUS"
	if [[ -n $zeroDayPREVIOUS ]]; then # If there was a previously saved zero day date then use that.
		zeroDaySTART="$zeroDayPREVIOUS"
		sendToLog "Status: Using previously set automatic zero day date of $zeroDaySTART."
	else # Otherwise this is a new zero day date, so save to $superPLIST.
		zeroDaySTART=$(date +"%Y-%m-%d:%H:%M")
		sendToLog "Status: Setting new automatic day zero date to $zeroDaySTART."
		defaults write "$superPLIST" ZeroDayAuto -string "$zeroDaySTART"
	fi
fi
zeroDayEPOCH=$(date -j -f "%Y-%m-%d:%H:%M" "$zeroDaySTART" +"%s")
zeroDayDATE=$(date -r "$zeroDayEPOCH" "$dateFORMAT")
zeroDayTIME=$(date -r "$zeroDayEPOCH" "$timeFORMAT" | sed 's/^ *//g')
if [[ $(date -r "$zeroDayEPOCH" "+%H:%M") == "00:00" ]]; then
	zeroDayDISPLAY="$zeroDayDATE"
else
	zeroDayDISPLAY="$zeroDayDATE - $zeroDayTIME"
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: zeroDayEPOCH: $zeroDayEPOCH"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: zeroDayDATE: $zeroDayDATE"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: zeroDayTIME: $zeroDayTIME"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: zeroDayDISPLAY: $zeroDayDISPLAY"
}

# Evaluate if a process has told the display to not sleep or the user has enabled Focus or Do Not Disturb, and set $focusDEFER accordingly.
checkUserFocus() {
focusDEFER="FALSE"
if [[ -n $focusDeferSECONDS ]]; then
	if [[ $macOSMAJOR -eq 10 ]]; then
		focusSTATUS=$(sudo -u "$currentUserNAME" defaults -currentHost read "/Users/$currentUserNAME/Library/Preferences/ByHost/com.apple.notificationcenterui" doNotDisturb 2>/dev/null)
	elif [[ $macOSMAJOR -eq 11 ]]; then
		focusSTATUS=$(plutil -extract dnd_prefs xml1 -o - "/Users/$currentUserNAME/Library/Preferences/com.apple.ncprefs.plist" | xmllint --xpath "string(//data)" - | base64 --decode | plutil -convert xml1 - -o - | grep -ic userPref)
	else
		focusSTATUS=$(plutil -extract data.0.storeAssertionRecords.0.assertionDetails.assertionDetailsModeIdentifier raw -o - "/Users/$currentUserNAME/Library/DoNotDisturb/DB/Assertions.json" | grep -ic com.apple.)
	fi
	if [[ $focusSTATUS -gt 0 ]]; then
		sendToLog "Status: Focus or Do Not Disturb enabled for user \"$currentUserNAME\"."
		focusDEFER="TRUE"
	fi
	oldIFS="$IFS"; IFS=$'\n'
	displayASSERTIONS=($(pmset -g assertions | awk '/NoDisplaySleepAssertion | PreventUserIdleDisplaySleep/ && match($0,/\(.+\)/) && ! /coreaudiod/ {gsub(/^\ +/,"",$0); print};'))
	if [[ -n ${displayASSERTIONS[*]} ]]; then
		for assertionITEM in "${displayASSERTIONS[@]}"; do
			sendToLog "Status: The following Display Sleep Assertions found: $(echo "${assertionITEM}" | awk -F ':' '{print $1}')"
		done
		focusDEFER="TRUE"
	fi
	IFS="$oldIFS"
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: focusDEFER is: $focusDEFER"
}

# Evaluate $focusDateMAX, $softDateMAX, and $hardDateMAX, then set $deadlineDateSTATUS, $deadlineDateEPOCH, and $deadlineDateDISPLAY accordingly.
checkDateDeadlines() {
deadlineDateSTATUS="FALSE"
if [[ -n $focusDateMAX ]]; then
	if [[ $focusDateEPOCH -lt $(date +%s) ]]; then
		sendToLog "Status: Focus date deadline of $focusDateMAX HAS passed."
		deadlineDateSTATUS="FOCUS"
	else
		sendToLog "Status: Focus date deadline of $focusDateMAX NOT passed."
	fi
fi
if [[ -n $softDateMAX ]]; then
	if [[ $softDateEPOCH -lt $(date +%s) ]]; then
		sendToLog "Status: Soft date deadline of $softDateMAX HAS passed."
		deadlineDateSTATUS="SOFT"
	else
		sendToLog "Status: Soft date deadline of $softDateMAX NOT passed."
	fi
fi
if [[ -n $hardDateMAX ]]; then
	if [[ $hardDateEPOCH -lt $(date +%s) ]]; then
		sendToLog "Status: Date deadline of $hardDateMAX HAS passed."
		deadlineDateSTATUS="HARD"
	else
		sendToLog "Status: Date deadline of $hardDateMAX NOT passed."
	fi
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deadlineDateSTATUS is: $deadlineDateSTATUS"

# For display the $softDateMAX always results in a sooner date than the $hardDateMAX.
[[ -n $hardDateMAX ]] && deadlineDateEPOCH="$hardDateEPOCH"
[[ -n $softDateMAX ]] && deadlineDateEPOCH="$softDateEPOCH"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deadlineDateEPOCH is: $deadlineDateEPOCH"
if [[ -n $deadlineDateEPOCH ]]; then
	deadlineDateDATE=$(date -r "$deadlineDateEPOCH" "$dateFORMAT")
	deadlineDateTIME=$(date -r "$deadlineDateEPOCH" "$timeFORMAT" | sed 's/^ *//g')
	if [[ $(date -r "$deadlineDateEPOCH" "+%H:%M") == "00:00" ]]; then
		deadlineDateDISPLAY="$deadlineDateDATE"
	else
		deadlineDateDISPLAY="$deadlineDateDATE - $deadlineDateTIME"
	fi
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deadlineDateDATE is: $deadlineDateDATE"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deadlineDateTIME is: $deadlineDateTIME"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deadlineDateDISPLAY is: $deadlineDateDISPLAY"
fi
}

# Evaluate $focusDaysMAX, $softDaysMAX, and $hardDaysMAX, then set $deadlineDaysSTATUS, $deadlineDaysEPOCH, and $deadlineDaysDISPLAY accordingly.
checkDaysDeadlines() {
deadlineDaysSTATUS="FALSE"
if [[ -n $focusDaysMAX ]]; then
	focusDaysEPOCH=$((zeroDayEPOCH + focusDaysSECONDS))
	focusDaysDATE=$(date -r "$focusDaysEPOCH" +%Y-%m-%d:%H:%M)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: focusDaysEPOCH: $focusDaysEPOCH"
	if [[ $focusDaysEPOCH -lt $(date +%s) ]]; then
		sendToLog "Status: Focus days deadline of $focusDaysDATE ($focusDaysMAX day(s) after $zeroDaySTART) HAS passed."
		deadlineDaysSTATUS="FOCUS"
	else
		sendToLog "Status: Focus days deadline of $focusDaysDATE ($focusDaysMAX day(s) after $zeroDaySTART) NOT passed."
	fi
fi
if [[ -n $softDaysMAX ]]; then
	softDaysEPOCH=$((zeroDayEPOCH + softDaysSECONDS))
	softDaysDATE=$(date -r "$softDaysEPOCH" +%Y-%m-%d:%H:%M)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softDaysEPOCH: $softDaysEPOCH"
	if [[ $softDaysEPOCH -lt $(date +%s) ]]; then
		sendToLog "Status: Soft days deadline of $softDaysDATE ($softDaysMAX day(s) after $zeroDaySTART) HAS passed."
		deadlineDaysSTATUS="SOFT"
	else
		sendToLog "Status: Soft days deadline of $softDaysDATE ($softDaysMAX day(s) after $zeroDaySTART) NOT passed."
	fi
fi
if [[ -n $hardDaysMAX ]]; then
	hardDaysEPOCH=$((zeroDayEPOCH + hardDaysSECONDS))
	hardDaysDATE=$(date -r "$hardDaysEPOCH" +%Y-%m-%d:%H:%M)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: hardDaysEPOCH: $hardDaysEPOCH"
	if [[ $hardDaysEPOCH -lt $(date +%s) ]]; then
		sendToLog "Status: Days deadline of $hardDaysDATE ($hardDaysMAX day(s) after $zeroDaySTART) HAS passed."
		deadlineDaysSTATUS="HARD"
	else
		sendToLog "Status: Days deadline of $hardDaysDATE ($hardDaysMAX day(s) after $zeroDaySTART) NOT passed."
	fi
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deadlineDaysSTATUS is: $deadlineDaysSTATUS"

# For display the $softDaysMAX always results in a sooner date than the $hardDaysMAX.
[[ -n $hardDaysMAX ]] && deadlineDaysEPOCH="$hardDaysEPOCH"
[[ -n $softDaysMAX ]] && deadlineDaysEPOCH="$softDaysEPOCH"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deadlineDaysEPOCH is: $deadlineDaysEPOCH"
if [[ -n $deadlineDaysEPOCH ]]; then
	deadlineDaysDATE=$(date -r "$deadlineDaysEPOCH" "$dateFORMAT")
	deadlineDaysTIME=$(date -r "$deadlineDaysEPOCH" "$timeFORMAT" | sed 's/^ *//g')
	if [[ $(date -r "$deadlineDaysEPOCH" "+%H:%M") == "00:00" ]]; then
		deadlineDaysDISPLAY="$deadlineDaysDATE"
	else
		deadlineDaysDISPLAY="$deadlineDaysDATE - $deadlineDaysTIME"
	fi
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deadlineDaysDATE is: $deadlineDaysDATE"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deadlineDaysTIME is: $deadlineDaysTIME"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deadlineDaysDISPLAY is: $deadlineDaysDISPLAY"
fi

# For display this sets $deadlineDISPLAY based on the soonest available date or days deadline.
if [[ -n $deadlineDateDISPLAY ]] && [[ -n $deadlineDaysDISPLAY ]]; then
	if [[ $deadlineDateEPOCH -le $deadlineDaysEPOCH ]]; then
		deadlineDISPLAY="$deadlineDateDISPLAY"
	else
		deadlineDISPLAY="$deadlineDaysDISPLAY"
	fi
elif [[ -n $deadlineDateDISPLAY ]]; then
	deadlineDISPLAY="$deadlineDateDISPLAY"
elif [[ -n $deadlineDaysDISPLAY ]]; then
	deadlineDISPLAY="$deadlineDaysDISPLAY"
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deadlineDISPLAY is: $deadlineDISPLAY"
}

# Evaluate $focusCountMAX, $softCountMAX, and $hardCountMAX, then set $focusDEFER, $deadlineCountSTATUS, $countDISPLAY, and $countMaxDISPLAY accordingly.
checkCountDeadlines() {
deadlineCountSTATUS="FALSE"
if [[ "$focusDEFER" == "TRUE" ]]; then
	if [[ -n $focusCountMAX ]]; then
		focusCounterPREVIOUS=$(defaults read "$superPLIST" FocusCounter 2> /dev/null)
		if [[ -z $focusCounterPREVIOUS ]]; then
			sendToLog "Status: Creating new focus deferral counter in $superPLIST."
			focusCounterCURRENT=0
			defaults write "$superPLIST" FocusCounter -int $focusCounterCURRENT
		else
			focusCounterCURRENT=$((focusCounterPREVIOUS + 1))
			defaults write "$superPLIST" FocusCounter -int $focusCounterCURRENT
		fi
		if [[ $focusCounterCURRENT -ge $focusCountMAX ]]; then
			sendToLog "Status: Focus maximum deferral count of $focusCountMAX HAS passed."
			deadlineCountSTATUS="FOCUS"
			focusDEFER="FALSE"
		else
			focusCountDISPLAY=$((focusCountMAX - focusCounterCURRENT))
			sendToLog "Status: Focus maximum deferral count of $focusCountMAX NOT passed with $focusCountDISPLAY remaining."
		fi
	else
		sendToLog "Status: Focus or Do Not Disturb active, and no maximum focus deferral, so not incrementing deferral counters."
	fi
fi
if [[ "$focusDEFER" == "FALSE" ]]; then
	if [[ -n $softCountMAX ]]; then
		softCounterPREVIOUS=$(defaults read "$superPLIST" SoftCounter 2> /dev/null)
		if [[ -z $softCounterPREVIOUS ]]; then
			sendToLog "Status: Creating new soft deferral counter in $superPLIST."
			softCounterCURRENT=0
			defaults write "$superPLIST" SoftCounter -int $softCounterCURRENT
		else
			softCounterCURRENT=$((softCounterPREVIOUS + 1))
			defaults write "$superPLIST" SoftCounter -int $softCounterCURRENT
		fi
		if [[ $softCounterCURRENT -ge $softCountMAX ]]; then
			sendToLog "Status: Soft maximum deferral count of $softCountMAX HAS passed."
			deadlineCountSTATUS="SOFT"
		else
			softCountDISPLAY=$((softCountMAX - softCounterCURRENT))
			sendToLog "Status: Soft maximum deferral count of $softCountMAX NOT passed with $softCountDISPLAY remaining."
		fi
		countDISPLAY="$softCountDISPLAY"
		countMaxDISPLAY="$softCountMAX"
	fi
	if [[ -n $hardCountMAX ]]; then
		hardCounterPREVIOUS=$(defaults read "$superPLIST" HardCounter 2> /dev/null)
		if [[ -z $hardCounterPREVIOUS ]]; then
			sendToLog "Status: Creating new hard deferral counter in $superPLIST."
			hardCounterCURRENT=0
			defaults write "$superPLIST" HardCounter -int $hardCounterCURRENT
		else
			hardCounterCURRENT=$((hardCounterPREVIOUS + 1))
			defaults write "$superPLIST" HardCounter -int $hardCounterCURRENT
		fi
		if [[ $hardCounterCURRENT -ge $hardCountMAX ]]; then
			sendToLog "Status: Hard maximum deferral count of $hardCountMAX HAS passed."
			deadlineCountSTATUS="HARD"
		else
			hardCountDISPLAY=$((hardCountMAX - hardCounterCURRENT))
			sendToLog "Status: Hard maximum deferral count of $hardCountMAX NOT passed with $hardCountDISPLAY remaining."
		fi
		countDISPLAY="$hardCountDISPLAY"
		countMaxDISPLAY="$hardCountMAX"
	fi
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deadlineCountSTATUS is: $deadlineCountSTATUS"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: focusDEFER is: $focusDEFER"
}

# MARK: *** Update/Upgrade Prep ***
################################################################################

# This function checks the validity of recently run software updates/upgrade caches and sets $fullCheckREQUIRED, $softwareUpdatesAVAILABLE, and $macOSUpgradeAVAILABLE accordingly.
checkSoftwareListCache()
{
fullCheckREQUIRED="FALSE"
softwareUpdatesAVAILABLE="FALSE"
macOSUpgradeAVAILABLE="FALSE"

# Check to see if there was any previously available software updates information cached.
asuCheckDATE=$(defaults read "$asuPLIST" LastSuccessfulDate 2> /dev/null)
[[ -n $asuCheckDATE ]] && asuCheckEPOCH=$(date -j -u -f "%Y-%m-%d %H:%M:%S %z" "$asuCheckDATE" "+%s")
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: asuCheckDATE is: $asuCheckDATE"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: asuCheckEPOCH is: $asuCheckEPOCH"
if [[ $asuCheckEPOCH -gt $(($(date "+%s")-21600)) ]]; then
	sendToLog "Status: Last automatic software update check was less than 6 hours ago."
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: $asuPLIST is:\n$(defaults read "$asuPLIST"  2> /dev/null)"
	cacheSoftwareUpdatesAVAILABLE=$(defaults read "$asuPLIST" LastUpdatesAvailable 2> /dev/null)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: cacheSoftwareUpdatesAVAILABLE is: $cacheSoftwareUpdatesAVAILABLE"
	if [[ $cacheSoftwareUpdatesAVAILABLE -gt 0 ]]; then # Software updates available. Evaluate previous update list and compare them to currently available updates, setting $fullCheckREQUIRED, $softwareUpdateLIST, and $softwareUpdatesAVAILABLE accordingly.
		previousSoftwareUpdatesPROPERTY=$(defaults read "$superPLIST" SoftwareUpdatesList 2> /dev/null)
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: previousSoftwareUpdatesPROPERTY is:\n$previousSoftwareUpdatesPROPERTY"
		if [[ -n $previousSoftwareUpdatesPROPERTY ]] && [[ "$previousSoftwareUpdatesPROPERTY" != "0" ]]; then
			previousSoftwareUpdatesLIST=$(echo "$previousSoftwareUpdatesPROPERTY" | tail -n +2 | sed -e 's/    //g' -e 's/"//g' -e 's/",//g' -e 's/,//g' -e '$d' | sort)
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: previousSoftwareUpdatesLIST is:\n$previousSoftwareUpdatesLIST"
			cacheSoftwareUpdatesLIST=$(defaults read "$asuPLIST" RecommendedUpdates | grep 'Identifier' | sed -e 's/        Identifier = //g' -e 's/"//g' -e 's/;//g' | sort)
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: cacheSoftwareUpdatesLIST is:\n$cacheSoftwareUpdatesLIST"
			if [[ "$previousSoftwareUpdatesLIST" == "$cacheSoftwareUpdatesLIST" ]]; then # Previous update list matches current update list.
				softwareUpdateLIST=$(<"$asuListLOG") 2> /dev/null
				[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateLIST is:\n$softwareUpdateLIST"
				if [[ $(echo "$softwareUpdateLIST" | grep -c 'Software Update found') -eq 0 ]] || [[ $(echo "$softwareUpdateLIST" | grep -c 'No new software available.') -gt 1 ]]; then
					sendToLog "Status: $asuListLOG does not contain any updates but it should, full update/upgrade check required."
					fullCheckREQUIRED="TRUE"
				else
					sendToLog "Status: Cached software update list appears to be accurate."
					softwareUpdatesAVAILABLE="TRUE"
				fi
			else
				sendToLog "Status: Cached software update list does not match the current list, full update/upgrade check required."
				fullCheckREQUIRED="TRUE"
			fi
		else # No previously saved $cacheSoftwareUpdatesLIST to compare.
			sendToLog "Status: No software update list cache, full update/upgrade check required."
			fullCheckREQUIRED="TRUE"
		fi
	fi
else
	sendToLog "Status: Last automatic software update check is older than 6 hours, full update/upgrade check required."
	fullCheckREQUIRED="TRUE"
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdatesAVAILABLE is: $softwareUpdatesAVAILABLE"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: fullCheckREQUIRED is: $fullCheckREQUIRED"

# Check to see if there was any previously available macOS upgrade information cached.
if [[ "$fullCheckREQUIRED" == "FALSE" ]]; then
	previousMacOSSoftwareUpgradeLABEL=$(defaults read "$superPLIST" macOSSoftwareUpgradeLabel 2> /dev/null)
	previousMacOSSoftwareUpgradeTITLE=$(defaults read "$superPLIST" macOSSoftwareUpgradeTitle 2> /dev/null)
	previousMacOSInstallerUpgradeNAME=$(defaults read "$superPLIST" macOSUpgradeName 2> /dev/null)
	previousMacOSInstallerUpgradeVERSION=$(defaults read "$superPLIST" macOSUpgradeVersion 2> /dev/null)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: previousMacOSSoftwareUpgradeLABEL is: $previousMacOSSoftwareUpgradeLABEL"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: previousMacOSSoftwareUpgradeTITLE is: $previousMacOSSoftwareUpgradeTITLE"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: previousMacOSInstallerUpgradeNAME is: $previousMacOSInstallerUpgradeNAME"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: previousMacOSInstallerUpgradeVERSION is: $previousMacOSInstallerUpgradeVERSION"
	if [[ $macOSVERSION -ge 1203 ]] && [[ -n $previousMacOSSoftwareUpgradeLABEL ]] && [[ -n $previousMacOSSoftwareUpgradeTITLE ]]; then
		if [[ "$previousMacOSSoftwareUpgradeLABEL" != "0" ]] && [[ "$previousMacOSSoftwareUpgradeTITLE" != "0" ]]; then # macOS upgrade available per cache.
			macOSUpgradeAVAILABLE="TRUE"
			macOSSoftwareUpgradeLABEL="$previousMacOSSoftwareUpgradeLABEL"
			macOSSoftwareUpgradeTITLE="$previousMacOSSoftwareUpgradeTITLE"
			if [[ "$upgradeWORKFLOW" != "FALSE" ]]; then # macOS upgrade option is enabled.
				if [[ -n $softwareUpdateLIST ]];then # Cached macOS installer list exists.
					if [[ $(echo "$softwareUpdateLIST" | grep -c 'Software Update found') -gt 0 ]] && [[ $(echo "$softwareUpdateLIST" | grep -c 'macOS') -gt 0 ]];then # Cached macOS softwareupdate list was completed.
						sendToLog "Status: Cached macOS upgrade list appears to be valid."
					else
						sendToLog "Status: macOS upgrade list cache invalid, full update/upgrade check required."
						fullCheckREQUIRED="TRUE"
					fi
				else
					sendToLog "Status: No macOS upgrade list cache, full update/upgrade check required."
					fullCheckREQUIRED="TRUE"
				fi
			fi
		fi
	fi
	if { [[ $macOSVERSION -ge 1015 ]] && [[ -n $previousMacOSInstallerUpgradeNAME ]] && [[ -n $previousMacOSInstallerUpgradeVERSION ]]; } || { [[ $macOSVERSION -lt 1015 ]] && [[ -n $previousMacOSInstallerUpgradeNAME ]]; }; then # Cached macOS upgrade name available.
		if [[ "$previousMacOSInstallerUpgradeNAME" != "0" ]]; then # macOS upgrade available per cache.
			macOSUpgradeAVAILABLE="TRUE"
			macOSUpgradeNAME="$previousMacOSInstallerUpgradeNAME"
			macOSUpgradeVERSION="$previousMacOSInstallerUpgradeVERSION"
			macOSInstallerLIST=$(<"$installerListLOG") 2> /dev/null
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerLIST is:\n$macOSInstallerLIST"
			if [[ "$upgradeWORKFLOW" != "FALSE" ]]; then # macOS upgrade option is enabled.
				if [[ -n $macOSInstallerLIST ]];then # Cached macOS installer list exists.
					if [[ $(echo "$macOSInstallerLIST" | grep -c 'finish') -gt 0 ]] && [[ $(echo "$macOSInstallerLIST" | grep -c 'exit code: 1') -eq 0 ]];then # Cached macOS installer list was completed.
						sendToLog "Status: Cached macOS upgrade list appears to be valid."
					else
						sendToLog "Status: macOS upgrade list cache invalid, full update/upgrade check required."
						fullCheckREQUIRED="TRUE"
					fi
				else
					sendToLog "Status: No macOS upgrade list cache, full update/upgrade check required."
					fullCheckREQUIRED="TRUE"
				fi
			fi
		fi
	else # No cached macOS upgrade name.
		sendToLog "Status: No software upgrade status cache, full update/upgrade check required."
		fullCheckREQUIRED="TRUE"
	fi
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeAVAILABLE is: $macOSUpgradeAVAILABLE"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: fullCheckREQUIRED is: $fullCheckREQUIRED"
fi
}

# This restarts various softwareupdate daemon processes.
kickSoftwareUpdateD() {
sendToLog "Status: Restarting various softwareupdate daemon processes..."
defaults delete /Library/Preferences/com.apple.Softwareupdate.plist > /dev/null 2>&1

if ! launchctl kickstart -k "system/com.apple.mobile.softwareupdated"; then
	sendToLog "Warning: Restarting mobile softwareupdate daemon didn't respond, trying again in 10 seconds..."
	sleep 10
	launchctl kickstart -k "system/com.apple.mobile.softwareupdated"
fi

if ! launchctl kickstart -k "system/com.apple.softwareupdated"; then
	sendToLog "Warning: Restarting system softwareupdate daemon didn't respond, trying again in 10 seconds..."
	sleep 10
	launchctl kickstart -k "system/com.apple.softwareupdated"
fi

# If a user is logged in then also restart the Software Update Notification Manager daemon.
if [[ "$currentUserNAME" != "FALSE" ]]; then
	if ! launchctl kickstart -k "gui/$currentUserUID/com.apple.SoftwareUpdateNotificationManager"; then
		sendToLog "Warning: Restarting Software Update Notification Manager didn't respond, trying again in 10 seconds..."
		sleep 10
		launchctl kickstart -k "gui/$currentUserUID/com.apple.SoftwareUpdateNotificationManager"
	fi
fi
}

# This function checks for updates via softwareupdate and sets $softwareUpdatesAVAILABLE, $macOSSoftwareUpdatesAVAILABLE, and $softwareUpdateLIST accordingly. This is in a separate function to facilitate list caching and multiple run workflows.
listSoftwareUpdates() {
softwareUpdatesAVAILABLE="FALSE"
macOSSoftwareUpdatesAVAILABLE="FALSE"

# Background the softwareupdate checking process and send to $asuListLOG.
sudo -u root softwareupdate --list > "$asuListLOG" 2>&1 &
checkPID=$!

# Watch $asuListLOG while waiting for the softwareupdate list process to complete. Note this while read loop has a timeout based on $initialStartTimeoutSECONDS.
workflowStartTIMEOUT="TRUE"
workflowStartFAIL="TRUE"
workflowTimeoutSECONDS=$initialStartTimeoutSECONDS
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowStartTIMEOUT is: $workflowStartTIMEOUT"
while read -t $workflowTimeoutSECONDS -r logLINE ; do
	# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
	if [[ $(echo "$logLINE" | grep -c "Can’t connect" ) -gt 0 ]] || [[ $(echo "$logLINE" | grep -c "Couldn't communicate" ) -gt 0 ]]; then
		workflowStartTIMEOUT="FALSE"
		break
	elif [[ $(echo "$logLINE" | grep -c 'Finding available software') -gt 0 ]]; then
		sendToLog "softwareupdate: Waiting for update list..."
	elif [[ $(echo "$logLINE" | grep -c 'Software Update found') -gt 0 ]]; then
		softwareUpdatesAVAILABLE="TRUE"
		workflowStartFAIL="FALSE"
		workflowStartTIMEOUT="FALSE"
		wait $checkPID
		break
	elif [[ $(echo "$logLINE" | grep -c 'No new software available.') -gt 0 ]]; then
		workflowStartFAIL="FALSE"
		workflowStartTIMEOUT="FALSE"
		break
	fi
done < <(tail -n1 -F "$asuListLOG")

# If the softwareupdate list completed, then collect information.
if [[ "$workflowStartTIMEOUT" == "FALSE" ]] && [[ "$workflowStartFAIL" == "FALSE" ]]; then
	softwareUpdateLIST=$(<"$asuListLOG")
	[[ $(echo "$softwareUpdateLIST" | grep -c 'macOS') -gt 0 ]] && macOSSoftwareUpdatesAVAILABLE="TRUE"
elif [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
	sendToLog "Error: softwareupdate check timed out after $workflowTimeoutSECONDS seconds."
	kill -9 "$checkPID" > /dev/null 2>&1
	kickSoftwareUpdateD
	sleep 10
elif [[ "$workflowStartFAIL" == "TRUE" ]]; then
	sendToLog "Error: softwareupdate check failed, check $asuListLOG for more detail."
	kill -9 "$checkPID" > /dev/null 2>&1
	sleep 10
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdatesAVAILABLE is: $softwareUpdatesAVAILABLE"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdatesAVAILABLE is: $macOSSoftwareUpdatesAVAILABLE"
}

# This function evaluates software updates collected from the listSoftwareUpdates() function and sets super software update caches, $softwareUpdateMACOS, $softwareUpdateRSR, and $softwareUpdateRECOMMENDED accordingly.
# This also sets $allSoftwareUpdateLABELS[], $allSoftwareUpdateTITLES[], $macOSSoftwareUpdateLABELS[], $macOSSoftwareUpdateTITLES[], $macOSSoftwareUpdateVERSIONS[], $macOSSoftwareUpdateLABEL, $macOSSoftwareUpdateTITLE, $macOSSoftwareUpdateVERSION, $recommendedSoftwareUpdateLABELS[], and $recommendedSoftwareUpdateTITLES[].
checkSoftwareUpdates() {
softwareUpdateMACOS="FALSE"
softwareUpdateRSR="FALSE"
softwareUpdateRECOMMENDED="FALSE"
unset allSoftwareUpdateLABELS
unset allSoftwareUpdateTITLES
unset macOSSoftwareUpdateLABELS
unset macOSSoftwareUpdateTITLES
unset macOSSoftwareUpdateVERSIONS
unset macOSSoftwareUpdateGBS
unset macOSSoftwareUpdateLABEL
unset macOSSoftwareUpdateTITLE
unset macOSSoftwareUpdateVERSION
unset macOSSoftwareUpdateGB
unset recommendedSoftwareUpdateLABELS
unset recommendedSoftwareUpdateTITLES

# Only need to check if a full check is required.
if [[ "$fullCheckREQUIRED" == "TRUE" ]]; then
	sendToLog "Status: Starting full check for software updates..."
	listSoftwareUpdates
	
	# Double-checking in case software update is misbehaving.
	if [[ "$workflowStartFAIL" == "TRUE" ]] || [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
		sendToLog "Status: Re-checking for software updates..."
		listSoftwareUpdates
	elif [[ $macOSMAJOR -ge 11 ]] && [[ $macOSVERSION -lt 1303 ]] && { [[ "$softwareUpdatesAVAILABLE" == "FALSE" ]] || [[ "$macOSSoftwareUpdatesAVAILABLE" == "FALSE" ]]; }; then
		sendToLog "Status: macOS 11.x - macOS 13.2, double-checking for software updates..."
		kickSoftwareUpdateD
		sleep 10
		listSoftwareUpdates
	fi
	
	# Software update check failed, try again later.
	if [[ "$workflowStartFAIL" == "TRUE" ]] || [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
		if [[ "$installNowOPTION" == "TRUE" ]]; then
			sendToLog "Error: Checking for updates via softwareupdate did not complete after multiple attempts, install now workflow can not continue."
			sendToStatus "Inactive Error: Checking for updates via softwareupdate did not complete after multiple attempts, install now workflow can not continue."
			notifyInstallNowFailure
			errorExit
		else
			deferSECONDS="$errorDeferSECONDS"
			sendToLog "Error: Checking for updates via softwareupdate did not complete after multiple attempts, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Checking for updates via softwareupdate did not complete after multiple attempts, trying again in $deferSECONDS seconds."
			makeLaunchDaemonCalendar
		fi
	fi
fi

# Extract software update information from from $asuPLIST and $asuListLOG.
if [[ "$softwareUpdatesAVAILABLE" == "TRUE" ]]; then
	# Extract softare update list cache from $asuPLIST and save to $superPLIST. This is to be used in future runs of the checkSoftwareListCache() function.
	cacheSoftwareUpdatesAVAILABLE=$(defaults read "$asuPLIST" LastUpdatesAvailable 2> /dev/null)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: cacheSoftwareUpdatesAVAILABLE is: $cacheSoftwareUpdatesAVAILABLE"
	oldIFS="$IFS"; IFS=$'\n'
	propertyUpdatesARRAY=($(defaults read "$asuPLIST" RecommendedUpdates | grep 'Identifier' | sed -e 's/        Identifier = //g' -e 's/"//g' -e 's/;//g'))
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: propertyUpdatesARRAY[] is:\n${propertyUpdatesARRAY[*]}"
	defaults delete "$superPLIST" SoftwareUpdatesList 2> /dev/null
	for i in "${!propertyUpdatesARRAY[@]}"; do
		defaults write "$superPLIST" SoftwareUpdatesList -array-add "${propertyUpdatesARRAY[i]}"
	done
	
	# Parse $softwareUpdateLIST for software update labels, titles, and macOS updates.
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateLIST is:\n$softwareUpdateLIST"
	if [[ $macOSMAJOR -ge 12 ]]; then # For macOS 12 softwareupdate can list multiple macOS updates/upgrades.
		allSoftwareUpdateLABELS=($(echo "$softwareUpdateLIST" | awk -F ': ' '/Label:/{print $2}'))
		allSoftwareUpdateTITLES=($(echo "$softwareUpdateLIST" | awk -F ',' '/Title:/ {print $1}' | cut -d ' ' -f 2-))
		macOSSoftwareUpdateLABELS=($(echo "$softwareUpdateLIST" | grep 'Label: macOS' | sed -e 's/* Label: //' | sort -k3 -r -V))
		macOSSoftwareUpdateTITLES=($(echo "$softwareUpdateLIST" | grep 'Title: macOS' | sed -e 's/,/:/g' | awk -F ': ' '{print $2}' | sort -k3 -r -V))
		macOSSoftwareUpdateVERSIONS=($(echo "$softwareUpdateLIST" | grep 'Title: macOS' | sed -e 's/,/:/g' | awk -F ': ' '{print $4}' | sort -r -V))
		macOSSoftwareUpdateGBS=($(echo "$softwareUpdateLIST" | grep 'Title: macOS' | awk -F ': ' '{print $4}' | grep -o -E '[0-9]+' | awk '{print $1"/1000000 +1"}' | bc))
		macOSSoftwareUpdateLABEL=$(echo "${macOSSoftwareUpdateLABELS[*]}" | grep "$macOSMAJOR.\d")
		macOSSoftwareUpdateTITLE=$(echo "${macOSSoftwareUpdateTITLES[*]}" | grep "$macOSMAJOR.\d")
		macOSSoftwareUpdateVERSION=$(echo "${macOSSoftwareUpdateVERSIONS[*]}" | grep "$macOSMAJOR.\d")
		macOSSoftwareUpdateGB=$(echo "$softwareUpdateLIST" | grep 'Title: macOS' | grep " $macOSMAJOR.\d" | awk -F ': ' '{print $4}' | grep -o -E '[0-9]+' | awk '{print $1"/1000000 +1"}' | bc)
	elif [[ $macOSMAJOR -ge 11 ]] || [[ $macOSVERSION -ge 1015 ]]; then
		allSoftwareUpdateLABELS=($(echo "$softwareUpdateLIST" | awk -F ': ' '/Label:/{print $2}'))
		allSoftwareUpdateTITLES=($(echo "$softwareUpdateLIST" | awk -F ',' '/Title:/ {print $1}' | cut -d ' ' -f 2-))
		macOSSoftwareUpdateLABEL=$(echo "$softwareUpdateLIST" | grep 'Label: macOS' | sed -e 's/* Label: //')
		macOSSoftwareUpdateTITLE=$(echo "$softwareUpdateLIST" | grep 'Title: macOS' | sed -e 's/,/:/g' | awk -F ': ' '{print $2}')
		macOSSoftwareUpdateGB=$(echo "$softwareUpdateLIST" | grep 'Title: macOS' | awk -F ': ' '{print $4}' | grep -o -E '[0-9]+' | awk '{print $1"/1000000 +1"}' | bc)
		if [[ $macOSMAJOR -eq 11 ]]; then
			macOSSoftwareUpdateVERSION=$(echo "$macOSSoftwareUpdateLABEL" | grep -o '11.[0-9].[0-9]')
		else
			macOSSoftwareUpdateVERSION=$(echo "$macOSSoftwareUpdateLABEL" | grep -o '10.[0-9][0-9].[0-9]')
		fi
	else # macOS 10.14 or older
		allSoftwareUpdateLABELS=($(echo "$softwareUpdateLIST" | awk -F '*' '/\*/{print $2}' | sed 's/^ //'))
		allSoftwareUpdateTITLES=($(echo "$softwareUpdateLIST" | awk -F '(' '/\t/ {print $1}' | cut -d $'\t' -f 2 | sed 's/.$//'))
		macOSSoftwareUpdateLABEL=$(echo "$softwareUpdateLIST" | grep 'macOS' | awk -F '*' '/\*/{print $2}' | sed 's/^ //')
		macOSSoftwareUpdateTITLE=$(echo "$softwareUpdateLIST" | grep 'macOS' | awk -F '(' '/\t/ {print $1}' | cut -d $'\t' -f 2 | sed 's/.$//')
		macOSSoftwareUpdateGB=$(echo "$softwareUpdateLIST" | grep 'macOS' | awk -F ',' '{print $2}' | grep -o -E '[0-9]+' | awk '{print $1"/1000000 +1"}' | bc)
		macOSSoftwareUpdateVERSION=$(echo "$macOSSoftwareUpdateLABEL" | grep -o '10.[0-9][0-9].[0-9]')
	fi
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: allSoftwareUpdateLABELS[] is:\n${allSoftwareUpdateLABELS[*]}"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: allSoftwareUpdateTITLES[] is:\n${allSoftwareUpdateTITLES[*]}"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateLABELS[] is:\n${macOSSoftwareUpdateLABELS[*]}"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateTITLES[] is:\n${macOSSoftwareUpdateTITLES[*]}"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateVERSIONS[] is:\n${macOSSoftwareUpdateVERSIONS[*]}"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateGBS[] is:\n${macOSSoftwareUpdateGBS[*]}"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateLABEL is: $macOSSoftwareUpdateLABEL"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateTITLE is: $macOSSoftwareUpdateTITLE"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateVERSION is: $macOSSoftwareUpdateVERSION"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateGB is: $macOSSoftwareUpdateGB"
	[[ "${allSoftwareUpdateLABELS[*]}" != "$macOSSoftwareUpdateLABEL" ]] && recommendedSoftwareUpdateLABELS=($(echo "${allSoftwareUpdateLABELS[*]}" | grep -v 'macOS'))
	[[ "${allSoftwareUpdateTITLES[*]}" != "$macOSSoftwareUpdateTITLE" ]] && recommendedSoftwareUpdateTITLES=($(echo "${allSoftwareUpdateTITLES[*]}" | grep -v 'macOS'))
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: recommendedSoftwareUpdateLABELS[] is:\n${recommendedSoftwareUpdateLABELS[*]}"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: recommendedSoftwareUpdateTITLES[] is:\n${recommendedSoftwareUpdateTITLES[*]}"
	
	# If software updates were found then output to log and set $softwareUpdateMACOS and $softwareUpdateRECOMMENDED accordingly.
	if [[ -n ${allSoftwareUpdateLABELS[*]} ]]; then
		if [[ -n $macOSSoftwareUpdateLABEL ]]; then
			if [[ $macOSMAJOR -ge 12 ]] && [[ ${#macOSSoftwareUpdateLABELS[@]} -gt 1 ]]; then
				sendToLog "Status: ${#macOSSoftwareUpdateLABELS[@]} macOS versions available via softwareupdate."
				for i in "${!macOSSoftwareUpdateLABELS[@]}"; do
					sendToLog "Status: macOS update $((i + 1)): ${macOSSoftwareUpdateLABELS[i]}"
				done
			fi
			if [[ $macOSMAJOR -ge 13 ]]; then
				[[ $(echo "$macOSSoftwareUpdateVERSION" | grep -c '[a-z]') -gt 0 ]] && softwareUpdateRSR="TRUE"
				if [[ "$softwareUpdateRSR" == "TRUE" ]]; then
					if [[ "$allowRSRUpdatesOPTION" == "TRUE" ]]; then
						sendToLog "Status: macOS Rapid Security Response update available: $macOSSoftwareUpdateLABEL."
						softwareUpdateMACOS="TRUE"
					else # RSR updates should are not allowed.
						sendToLog "Status: macOS Rapid Security Response update available but not allowed: $macOSSoftwareUpdateLABEL."
					fi
				else
					sendToLog "Status: macOS update available: $macOSSoftwareUpdateLABEL"
					softwareUpdateMACOS="TRUE"
				fi
			else
				sendToLog "Status: macOS update available: $macOSSoftwareUpdateLABEL"
				softwareUpdateMACOS="TRUE"
			fi
		else
			sendToLog "Status: No available macOS update(s) or they may be deferred via configuration profile."
		fi
		if [[ -n ${recommendedSoftwareUpdateLABELS[*]} ]]; then
			sendToLog "Status: ${#recommendedSoftwareUpdateLABELS[@]} available recommended (non-system) update(s)."
			for i in "${!recommendedSoftwareUpdateLABELS[@]}"; do
				sendToLog "Status: Recommended (non-system) update $((i + 1)): ${recommendedSoftwareUpdateLABELS[i]}"
			done
			softwareUpdateRECOMMENDED="TRUE"
		else
			sendToLog "Status: No available recommended (non-system) update(s) or they may be deferred via configuration profile."
		fi
		
	else
		if [[ "$installNowOPTION" == "TRUE" ]]; then
			sendToLog "Error: Unable to parse softwareupdate results, install now workflow can not continue."
			sendToStatus "Inactive Error: Unable to parse softwareupdate results, install now workflow can not continue."
			notifyInstallNowFailure
			errorExit
		else
			deferSECONDS="$errorDeferSECONDS"
			sendToLog "Error: Unable to parse softwareupdate results, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Unable to parse softwareupdate results, trying again in $deferSECONDS seconds."
			makeLaunchDaemonCalendar
		fi
	fi
	IFS="$oldIFS"
else # No available software updates.
	sendToLog "Status: No available software update(s) or they may be deferred via configuration profile."
	defaults delete "$superPLIST" SoftwareUpdatesList 2> /dev/null
	defaults write "$superPLIST" SoftwareUpdatesList -bool false
	defaults delete "$superPLIST" macOSSoftwareUpgradeLabel 2> /dev/null
	defaults delete "$superPLIST" macOSSoftwareUpgradeTitle 2> /dev/null
	defaults delete "$superPLIST" macOSUpgradeName 2> /dev/null
	defaults delete "$superPLIST" macOSUpgradeVersion 2> /dev/null
	defaults delete "$superPLIST" macOSSoftwareUpdateDownloadLabel 2> /dev/null
	defaults delete "$superPLIST" LastReboot 2> /dev/null
	defaults delete "$superPLIST" macOSInstallerDownloadVersion 2> /dev/null
	defaults delete "$superPLIST" macOSInstallerDownloadName 2> /dev/null
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateMACOS is: $softwareUpdateMACOS"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateRSR is: $softwareUpdateRSR"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateRECOMMENDED is: $softwareUpdateRECOMMENDED"
}

# This function checks for available macOS upgrades for systems older than macOS 12.3 and sets $macOSUpgradeAVAILABLE accordingly. This is in a separate function to facilitate list caching and multiple run workflows.
# Also sets $macOSUpgradeNAME, $macOSUpgradeVERSION, $macOSUpgradeMajorVERSION, and $macOSInstallerLIST.
listMacOSUpgrades() {
macOSUpgradeAVAILABLE="FALSE"

# Use built-in commands to determine if a macOS upgrade is available.
if [[ $macOSVERSION -ge 1015 ]]; then # For macOS 10.15 or newer parse results from the mdmclient commmand.
	sendToLog "mdmclient: Waiting for macOS upgrade list..."
	availableOSUPDATES=$(/usr/libexec/mdmclient AvailableOSUpdates 2> /dev/null)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: availableOSUPDATES is:\n$availableOSUPDATES"
	macOSUPGRADE=$(echo "$availableOSUPDATES" | grep -e 'HumanReadableName =' -e 'Version =' | tr '\n' '-' | sed -e 's/        HumanReadableName = //g' -e 's/;-        Version = //g' | tr ';-' '\n' | grep -e 'macOS' | sed -e 's/""/:/g' -e 's/"//g' | sort -t: -k3 -r -V | head -1)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUPGRADE is: $macOSUPGRADE"
	macOSUpgradeNAME=$(echo "$macOSUPGRADE"| awk -F ':' '{print $1}' | sed -e 's/[0-9]*//g' -e 's/ \.//')
	macOSUpgradeVERSION=$(echo "$macOSUPGRADE"| awk -F ':' '{print $2}')
	macOSUpgradeMajorVERSION=$(echo "$macOSUpgradeVERSION" | cut -d '.' -f1)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeNAME is: $macOSUpgradeNAME"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeVERSION is: $macOSUpgradeVERSION"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeMajorVERSION is: $macOSUpgradeMajorVERSION"
	{ [[ -n $macOSUpgradeNAME ]] && [[ -n $macOSUpgradeVERSION ]] && [[ $macOSUpgradeMajorVERSION -gt $macOSMAJOR ]]; } && macOSUpgradeAVAILABLE="TRUE"
else # Older versions of macOS collect this from $asuPLIST.
	propertyUpgradeAVAILABLE=$(defaults read "$asuPLIST" LastRecommendedMajorOSBundleIdentifier 2> /dev/null)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: propertyUpgradeAVAILABLE is: $propertyUpgradeAVAILABLE"
	macOSUpgradeNAME=$(echo "$propertyUpgradeAVAILABLE" | sed -e 's/com.apple.InstallAssistant.//' -e 's/macOS/macOS /')
	macOSUpgradeVERSION="" # Not necessary (or easy) to collect for systems this old.
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeNAME is: $macOSUpgradeNAME"
	[[ -n $macOSUpgradeNAME ]] && macOSUpgradeAVAILABLE="TRUE"
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeAVAILABLE is: $macOSUpgradeAVAILABLE"

# Only collect available macOS installer names if a $upgradeWORKFLOW is requested.
if [[ "$macOSUpgradeAVAILABLE" == "TRUE" ]] && [[ "$upgradeWORKFLOW" != "FALSE" ]]; then
	# Background the erase-install list process and send to $installerListLOG.
	if [[ "$betaWORKFLOW" != "FALSE" ]]; then
		"$eraseInstallSCRIPT" --list --seed "$betaWORKFLOW" > "$installerListLOG" 2>&1 &
		eraseInstallPID=$!
	else # Standard non-beta workflow.
		"$eraseInstallSCRIPT" --list > "$installerListLOG" 2>&1 &
		eraseInstallPID=$!
	fi
	
	# Watch $installerListLOG while waiting for the erase-install.sh list process to complete. Note this while read loop has a timeout based on $initialStartTimeoutSECONDS.
	workflowStartTIMEOUT="TRUE"
	workflowStartFAIL="TRUE"
	workflowTimeoutSECONDS=$initialStartTimeoutSECONDS
	while read -t $workflowTimeoutSECONDS -r logLINE ; do
		# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
		if [[ $(echo "$logLINE" | grep -c 'Cannot continue.' ) -gt 0 ]] || [[ $(echo "$macOSInstallerLIST" | grep -c 'exit code: 1') -gt 0 ]]; then
			workflowStartTIMEOUT="FALSE"
			break
		elif [[ $(echo "$logLINE" | grep -c 'script execution started') -gt 0 ]]; then
			if [[ "$betaWORKFLOW" != "FALSE" ]]; then
				sendToLog "erase-install.sh: Waiting for macOS installer beta $betaWORKFLOW list..."
			else # Standard non-beta workflow.
				sendToLog "erase-install.sh: Waiting for macOS installer list..."
			fi
		elif [[ $(echo "$logLINE" | grep -c 'finish') -gt 0 ]]; then
			workflowStartTIMEOUT="FALSE"
			workflowStartFAIL="FALSE"
			break
		fi
	done < <(tail -n1 -F "$installerListLOG")
	
	# If the erase-install.sh list completed, then collect information.
	if [[ "$workflowStartTIMEOUT" == "FALSE" ]] && [[ "$workflowStartFAIL" == "FALSE" ]]; then
		macOSInstallerLIST=$(<"$installerListLOG")
	elif [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
		sendToLog "Error: erase-install.sh list timed out after $workflowTimeoutSECONDS seconds."
		kill -9 "$eraseInstallPID" > /dev/null 2>&1
	elif [[ "$workflowStartFAIL" == "TRUE" ]]; then
		sendToLog "Error: erase-install.sh list failed, check $installerListLOG for more detail."
		kill -9 "$eraseInstallPID" > /dev/null 2>&1
	fi
fi
}

# This function evaluates macOS upgrade information collected from the checkMacOSUpgrades() or listMacOSUpgrades() functions and sets super macOS upgrade caches and $macOSUpgradeVersionTARGET accordingly.
# For systems with macOS 12.3 or newer this also sets $macOSSoftwareUpgradeLabelTARGET, $macOSSoftwareUpgradeTitleTARGET, and $macOSSoftwareUpgradeVersionTARGET.
# For systems older than macOS 12.3 this also sets $macOSInstallerNameTARGET, $macOSInstallerVersionTARGET, and $macOSInstallerBuildTARGET.
checkMacOSUpgrades() {
macOSUpgradeVersionTARGET="FALSE"
unset macOSSoftwareUpgradeLABEL
unset macOSSoftwareUpgradeTITLE
unset macOSSoftwareUpgradeVERSION
unset macOSSoftwareUpgradeGB
unset macOSInstallerNAMES
unset macOSInstallerVERSIONS
unset macOSInstallerBUILDS
unset macOSSoftwareUpgradeLabelTARGET
unset macOSSoftwareUpgradeTitleTARGET
unset macOSSoftwareUpgradeVersionTARGET
unset macOSInstallerNameTARGET
unset macOSInstallerVersionTARGET
unset macOSInstallerBuildTARGET

# Only need to list macOS upgrades if a full check is required.
if [[ "$fullCheckREQUIRED" == "TRUE" ]]; then
	sendToLog "Status: Starting full check for macOS upgrades..."
	listMacOSUpgrades
	
	# Double-checking in case macOS installer list workflows are misbehaving.
	if [[ "$workflowStartFAIL" == "TRUE" ]] && [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
		sendToLog "Status: Re-checking for macOS upgrades..."
		listMacOSUpgrades
	fi
	
	# macOS installer list check failed, try again later.
	if [[ "$workflowStartFAIL" == "TRUE" ]] && [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
		if [[ "$installNowOPTION" == "TRUE" ]]; then
			sendToLog "Error: Checking for macOS installers did not complete after multiple attempts, install now workflow can not continue."
			sendToStatus "Inactive Error: Checking for macOS installers did not complete after multiple attempts, install now workflow can not continue."
			notifyInstallNowFailure
			errorExit
		else
			deferSECONDS="$errorDeferSECONDS"
			sendToLog "Error: Checking for macOS installers did not complete after multiple attempts, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Checking for macOS installers did not complete after multiple attempts, trying again in $deferSECONDS seconds."
			makeLaunchDaemonCalendar
		fi
	fi
fi
oldIFS="$IFS"; IFS=$'\n'

# For macOS 12.3 or newer parse the results from $macOSSoftwareUpdateVERSIONS[].
if [[ $macOSVERSION -ge 1203 ]] && [[ "$softwareUpdatesAVAILABLE" == "TRUE" ]]; then
	macOSUpgradeAVAILABLE="FALSE"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateVERSIONS[] is:\n${macOSSoftwareUpdateVERSIONS[*]}"
	if [[ $(echo "${macOSSoftwareUpdateVERSIONS[0]}" | cut -d '.' -f1) -gt $macOSMAJOR ]]; then
		macOSSoftwareUpgradeLABEL="${macOSSoftwareUpdateLABELS[0]}"
		macOSSoftwareUpgradeTITLE="${macOSSoftwareUpdateTITLES[0]}"
		macOSSoftwareUpgradeVERSION="${macOSSoftwareUpdateVERSIONS[0]}"
		macOSSoftwareUpgradeGB="${macOSSoftwareUpdateGBS[0]}"
		macOSUpgradeAVAILABLE="TRUE"
	fi
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpgradeLABEL is: $macOSSoftwareUpgradeLABEL"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpgradeTITLE is: $macOSSoftwareUpgradeTITLE"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpgradeVERSION is: $macOSSoftwareUpgradeVERSION"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpgradeGB is: $macOSSoftwareUpgradeGB"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeAVAILABLE is: $macOSUpgradeAVAILABLE"
fi

# If macOS upgrades are available then validate and save the appropriate information.
if [[ "$macOSUpgradeAVAILABLE" == "TRUE" ]]; then
	# Save macOS upgrade information for cache.
	if [[ $macOSVERSION -ge 1203 ]]; then  # Newer systems upgrade via softwareupdate.
		defaults write "$superPLIST" macOSSoftwareUpgradeLabel -string "$macOSSoftwareUpgradeLABEL"
		defaults write "$superPLIST" macOSSoftwareUpgradeTitle -string "$macOSSoftwareUpgradeTITLE"
	fi
	defaults write "$superPLIST" macOSUpgradeName -string "$macOSUpgradeNAME"
	[[ $macOSVERSION -ge 1015 ]] && defaults write "$superPLIST" macOSUpgradeVersion -string "$macOSUpgradeVERSION"
	
	# If macOS upgrades are allowed then set various macOS upgrade targets.
	if [[ "$upgradeWORKFLOW" != "FALSE" ]]; then
		# Parse results from $macOSInstallerLIST.
		if [[ "$macOSUpgradeAVAILABLE" == "TRUE" ]]; then
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerLIST is:\n$macOSInstallerLIST"
			macOSInstallerCompatibleLIST=($(echo "$macOSInstallerLIST" | grep 'macOS' | grep -v -e 'Unsupported' -e 'macOS installers' -e 'check_installer_is_valid' | sed -E -e 's/  +/:/g' -e 's/ 20/:20/g'))
			macOSInstallersARRAY=($(sort -t: -k4 -r <<<"${macOSInstallerCompatibleLIST[*]}"))
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallersARRAY[] is:\n${macOSInstallersARRAY[*]}"
			if [[ -n ${macOSInstallersARRAY[*]} ]]; then
				for macOSInstallerLINE in "${macOSInstallersARRAY[@]}"; do
					macOSInstallerNAMES+=($(echo "$macOSInstallerLINE" | awk -F ':' '{print $6;}'))
					macOSInstallerVERSIONS+=($(echo "$macOSInstallerLINE" | awk -F ':' '{print $3;}'))
					macOSInstallerBUILDS+=($(echo "$macOSInstallerLINE" | awk -F ':' '{print $4;}'))
				done
				[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerNAMES[] is:\n${macOSInstallerNAMES[*]}"
				[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerVERSIONS[] is:\n${macOSInstallerVERSIONS[*]}"
				[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerBUILDS[] is:\n${macOSInstallerBUILDS[*]}"
			else
				if [[ "$installNowOPTION" == "TRUE" ]]; then
					sendToLog "Error: Unable to find compatible macOS installers, install now workflow can not continue."
					sendToStatus "Inactive Error: Unable to find compatible macOS installers, install now workflow can not continue."
					notifyInstallNowFailure
					errorExit
				else
					deferSECONDS="$errorDeferSECONDS"
					sendToLog "Error: Unable to find compatible macOS installers, trying again in $deferSECONDS seconds."
					sendToStatus "Pending: Unable to find compatible macOS installers, trying again in $deferSECONDS seconds."
					makeLaunchDaemonCalendar
				fi
			fi
		fi
		
		# Evaluate conditions necessary to set $macOSUpgradeVersionTARGET.
		if [[ -n $targetUpgradeOPTION ]]; then # A specific macOS upgrade version has been specified.
			if [[ $targetUpgradeOPTION -lt $macOSMAJOR ]] || [[ $targetUpgradeOPTION -eq $macOSMAJOR ]]; then
				[[ $targetUpgradeOPTION -lt $macOSMAJOR ]] && sendToLog "Warning: Target upgrade version of macOS $targetUpgradeOPTION is less than currently installed macOS $macOSMAJOR."
				[[ $targetUpgradeOPTION -eq $macOSMAJOR ]] && sendToLog "Status: Target upgrade version of macOS $targetUpgradeOPTION is the same as currently installed macOS $macOSMAJOR."
				macOSUpgradeVersionTARGET="FALSE"
				if [[ $macOSVERSION -ge 1203 ]] && [[ "$upgradeWORKFLOW" != "JAMF" ]]; then
					sendToLog "Status: macOS upgrade available via softwareupdate but not allowed: $macOSSoftwareUpgradeTITLE"
				else
					sendToLog "Status: macOS upgrade available via installer but not allowed: $macOSUpgradeNAME $macOSUpgradeVERSION"
				fi
			else # macOS upgrade target is greater than current macOS version, so this is the only time it would matter.
				if [[ $macOSVERSION -ge 1203 ]] && [[ "$upgradeWORKFLOW" != "JAMF" ]]; then # Newer systems upgrade via softwareupdate unless via MDM workflow.
					[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpgradeVERSION is: $macOSSoftwareUpgradeVERSION"
					if [[ $targetUpgradeOPTION -gt $(echo "$macOSSoftwareUpgradeVERSION" | cut -d '.' -f1) ]]; then  # macOS upgrade target is greater than the newest available macOS software upgrade.
						macOSSoftwareUpgradeLabelTARGET="$macOSSoftwareUpgradeLABEL"
						macOSSoftwareUpgradeTitleTARGET="$macOSSoftwareUpgradeTITLE"
						macOSSoftwareUpgradeVersionTARGET="$macOSSoftwareUpgradeVERSION"
						sendToLog "Warning: Requested target macOS upgrade version of $targetUpgradeOPTION is greater than the currently available macOS upgrade version of $macOSSoftwareUpgradeVersionTARGET."
						sendToLog "Status: macOS upgrade available via softwareupdate: $macOSSoftwareUpgradeLabelTARGET"
					else # macOS upgrade target is lower than the newest available macOS software upgrade.
						for i in "${!macOSSoftwareUpdateVERSIONS[@]}"; do
							[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateVERSIONS[i] is: ${macOSSoftwareUpdateVERSIONS[i]}"
							if [[ "$(echo "${macOSSoftwareUpdateVERSIONS[i]}" | cut -d '.' -f1)" == "$targetUpgradeOPTION" ]]; then
								macOSSoftwareUpgradeLabelTARGET="${macOSSoftwareUpdateLABELS[i]}"
								macOSSoftwareUpgradeTitleTARGET="${macOSSoftwareUpdateTITLES[i]}"
								macOSSoftwareUpgradeVersionTARGET="${macOSSoftwareUpdateVERSIONS[i]}"
								break
							fi
						done
						sendToLog "Status: Targeting specific macOS upgrade available via softwareupdate: macOSSoftwareUpgradeLabelTARGET"
					fi
					macOSUpgradeVersionTARGET="$macOSSoftwareUpgradeVersionTARGET"
				else # Systems older than macOS 12.3 or using MDM workflow upgrade via installer.
					[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerVERSIONS[0] is: ${macOSInstallerVERSIONS[0]}"
					if [[ $targetUpgradeOPTION -gt $(echo "${macOSInstallerVERSIONS[0]}" | cut -d '.' -f1) ]]; then # macOS upgrade target is greater than the newest available macOS installer.
						macOSInstallerNameTARGET="${macOSInstallerNAMES[0]}"
						macOSInstallerVersionTARGET="${macOSInstallerVERSIONS[0]}"
						macOSInstallerBuildTARGET="${macOSInstallerBUILDS[0]}"
						sendToLog "Warning: Requested target macOS upgrade version of $targetUpgradeOPTION is greater than the currently available macOS upgrade version of $macOSInstallerVersionTARGET."
						sendToLog "Status: macOS upgrade available via installer: $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET"
					else # macOS upgrade target is lower than the newest available macOS installer.
						for macOSInstallerLINE in "${macOSInstallersARRAY[@]}"; do
							[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerLINE is: $macOSInstallerLINE"
							if [[ "$(echo "$macOSInstallerLINE" | awk -F ':' '{print $3;}' | cut -d '.' -f1)" == "$targetUpgradeOPTION" ]]; then
								macOSInstallerNameTARGET="$(echo "$macOSInstallerLINE" | awk -F ':' '{print $6;}')"
								macOSInstallerVersionTARGET="$(echo "$macOSInstallerLINE" | awk -F ':' '{print $3;}')"
								macOSInstallerBuildTARGET="$(echo "$macOSInstallerLINE" | awk -F ':' '{print $4;}')"
								break
							fi
						done
						sendToLog "Status: Targeting specific macOS upgrade available via installer: $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET"
					fi
					macOSUpgradeVersionTARGET="$macOSInstallerVersionTARGET"
				fi
			fi
		else # There is no specified target version, so assume available upgrade is the target.
			if [[ $macOSVERSION -ge 1203 ]] && [[ "$upgradeWORKFLOW" != "JAMF" ]]; then # Newer systems upgrade via softwareupdate unless via MDM workflow.
				macOSSoftwareUpgradeLabelTARGET="$macOSSoftwareUpgradeLABEL"
				macOSSoftwareUpgradeTitleTARGET="$macOSSoftwareUpgradeTITLE"
				sendToLog "Status: macOS upgrade available via softwareupdate: $macOSSoftwareUpgradeLabelTARGET"
				macOSSoftwareUpgradeVersionTARGET=$(echo "$macOSSoftwareUpgradeLabelTARGET" | awk -F '-' '{print $1}' | sed -e 's/[a-zA-Z ]*//g')
				macOSUpgradeVersionTARGET="$macOSSoftwareUpgradeVersionTARGET"
			else # Systems older than macOS 12.3 or using MDM workflow upgrade via installer.
				macOSInstallerNameTARGET="${macOSInstallerNAMES[0]}"
				macOSInstallerVersionTARGET="${macOSInstallerVERSIONS[0]}"
				macOSInstallerBuildTARGET="${macOSInstallerBUILDS[0]}"
				sendToLog "Status: macOS upgrade available via installer: $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET"
				macOSUpgradeVersionTARGET="$macOSInstallerVersionTARGET"
			fi
		fi
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpgradeLabelTARGET is: $macOSSoftwareUpgradeLabelTARGET"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpgradeTitleTARGET is: $macOSSoftwareUpgradeTitleTARGET"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpgradeVersionTARGET is: $macOSSoftwareUpgradeVersionTARGET"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerNameTARGET is: $macOSInstallerNameTARGET"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerVersionTARGET is: $macOSInstallerVersionTARGET"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerBuildTARGET is: $macOSInstallerBuildTARGET"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeVersionTARGET is: $macOSUpgradeVersionTARGET"
	else # macOS upgrade is not allowed.
		if [[ $macOSVERSION -ge 1203 ]] && [[ "$upgradeWORKFLOW" != "JAMF" ]]; then
			sendToLog "Status: macOS upgrade available via softwareupdate but not allowed: $macOSSoftwareUpgradeTITLE"
		else
			sendToLog "Status: macOS upgrade available via installer but not allowed: $macOSUpgradeNAME $macOSUpgradeVERSION"
		fi
	fi
else # No available macOS upgrade.
	sendToLog "Status: No available macOS upgrade or it may be deferred via configuration profile."
	[[ $macOSVERSION -ge 1203 ]] && defaults write "$superPLIST" macOSSoftwareUpgradeLabel -bool false
	[[ $macOSVERSION -ge 1203 ]] && defaults write "$superPLIST" macOSSoftwareUpgradeTitle -bool false
	defaults write "$superPLIST" macOSUpgradeName -bool false
	[[ $macOSVERSION -ge 1015 ]] && defaults write "$superPLIST" macOSUpgradeVersion -bool false
fi
IFS="$oldIFS"
}

# Delete any unneeded macOS installers based on the value of $macOSUpgradeVersionTARGET in order to save space.
deleteUnneededMacOSInstallers() {
oldIFS="$IFS"; IFS=$'\n'
foundMacOSInstallersARRAY=($(mdfind kind:app -name "Install macOS" 2> /dev/null))
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: foundMacOSInstallersARRAY[] is:\n${foundMacOSInstallersARRAY[*]}"
if [[ -n ${foundMacOSInstallersARRAY[*]} ]]; then
	for installerPATH in "${foundMacOSInstallersARRAY[@]}"; do
		if [[ $(echo "$installerPATH" | grep -c '/Users/') -gt 0 ]] && [[ $(echo "$installerPATH" | grep -c '/Users/.*/Applications/') -eq 0 ]] && [[ $(echo "$installerPATH" | grep -c '/Users/.*/Desktop/') -eq 0 ]] && [[ $(echo "$installerPATH" | grep -c '/Users/.*/Downloads/') -eq 0 ]]; then
			sendToLog "Status: Skipping deletion of assumed archived macOS installer at: $installerPATH"
		else
			if [[ "$macOSUpgradeVersionTARGET" == "FALSE" ]]; then
				if [[ "$testModeOPTION" != "TRUE" ]]; then
					sendToLog "Warning: macOS upgrades are not allowed, removing unnecessary macOS installer at: $installerPATH"
					rm -Rf "$installerPATH" > /dev/null 2>&1
				else # Test mode.
					sendToLog "Test Mode: macOS upgrades are not allowed, found unnecessary macOS installer at: $installerPATH"
				fi
			elif [[ "$installerPATH" != "/Applications/Install $macOSInstallerNameTARGET.app" ]]; then
				if [[ "$testModeOPTION" != "TRUE" ]]; then
					sendToLog "Warning: Removing unnecessary macOS installer at: $installerPATH"
					rm -Rf "$installerPATH" > /dev/null 2>&1
				else # Test mode.
					sendToLog "Test Mode: Found unnecessary macOS installer at: $installerPATH"
				fi
			fi
		fi
	done
fi
IFS="$oldIFS"
}

# This function determines which macOS updates, upgrades, or installers should be downloaded and validates any previously downloaded macOS updates, upgrades, or installers and sets $macOSInstallerDownloadREQUIRED, $macOSSoftwareUpdateDownloadREQUIRED, $softwareUpdateLabelTARGET, and $softwareUpdateTitleTARGET accordingly.
checkMacOSDownloads() {
macOSInstallerDownloadREQUIRED="FALSE"
macOSSoftwareUpdateDownloadREQUIRED="FALSE"
softwareUpdateLabelTARGET=""
softwareUpdateTitleTARGET=""

# If needed, evaluate previously downloaded macOS installer and set $macOSInstallerDownloadREQUIRED accordingly.
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSVERSION is: $macOSVERSION"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeVersionTARGET is: $macOSUpgradeVersionTARGET"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: upgradeWORKFLOW is: $upgradeWORKFLOW"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateMACOS is: $softwareUpdateMACOS"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeAVAILABLE is: $macOSUpgradeAVAILABLE"
if { [[ $macOSVERSION -lt 1203 ]] && [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; } || { [[ $macOSVERSION -ge 1203 ]] && [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]] && [[ "$upgradeWORKFLOW" == "JAMF" ]]; }; then
	macOSInstallerDownloadVERSION=$(defaults read "$superPLIST" macOSInstallerDownloadVersion 2> /dev/null)
	macOSInstallerDownloadNAME=$(defaults read "$superPLIST" macOSInstallerDownloadName 2> /dev/null)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerDownloadVERSION is: $macOSInstallerDownloadVERSION"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerDownloadNAME is: $macOSInstallerDownloadNAME"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerVersionTARGET is: $macOSInstallerVersionTARGET"
	if [[ -n $macOSInstallerDownloadVERSION ]] && [[ -n $macOSInstallerDownloadNAME ]] && [[ "$fullCheckREQUIRED" == "FALSE" ]]; then
		if [[ "$macOSInstallerDownloadVERSION" == "$macOSInstallerVersionTARGET" ]]; then
			if [[ ! -d "/Applications/Install $macOSInstallerNameTARGET.app" ]]; then
				sendToLog "Status: Previously downloaded macOS installer could not be found."
				macOSInstallerDownloadREQUIRED="TRUE"
				defaults delete "$superPLIST" macOSInstallerDownloadVersion 2> /dev/null
				defaults delete "$superPLIST" macOSInstallerDownloadName 2> /dev/null
				restartZeroDay
			fi
		else
			sendToLog "Status: Previously downloaded installer for macOS $macOSInstallerDownloadVERSION does not match current target upgrade of macOS macOSInstallerVersionTARGET."
			macOSInstallerDownloadREQUIRED="TRUE"
			defaults delete "$superPLIST" macOSInstallerDownloadVersion 2> /dev/null
			defaults delete "$superPLIST" macOSInstallerDownloadName 2> /dev/null
			restartZeroDay
		fi
	else # If there is no cached $macOSInstallerDownloadVERSION, $macOSInstallerDownloadNAME, or a full check is required.
		macOSInstallerDownloadREQUIRED="TRUE"
	fi
elif [[ "$softwareUpdateMACOS" == "TRUE" ]] || [[ "$macOSUpgradeAVAILABLE" == "TRUE" ]]; then # Evaluate previously downloaded macOS updates or upgrades and compare them to currently available, setting $macOSSoftwareUpdateDownloadREQUIRED accordingly.
	if [[ $macOSVERSION -ge 1203 ]] && [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; then # macOS 12.3 or newer can upgrade via softwareupdate.
		softwareUpdateLabelTARGET="$macOSSoftwareUpgradeLabelTARGET"
		softwareUpdateTitleTARGET="$macOSSoftwareUpgradeTitleTARGET"
	else # Standard macOS update.
		softwareUpdateLabelTARGET="$macOSSoftwareUpdateLABEL"
		softwareUpdateTitleTARGET="$macOSSoftwareUpdateTITLE"
	fi
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateLabelTARGET is: $softwareUpdateLabelTARGET"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateTitleTARGET is: $softwareUpdateTitleTARGET"
	macOSSoftwareUpdateDownloadLABEL=$(defaults read "$superPLIST" macOSSoftwareUpdateDownloadLabel 2> /dev/null)
	previousLastREBOOT="$(defaults read "$superPLIST" LastReboot 2> /dev/null)"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateDownloadLABEL is: $macOSSoftwareUpdateDownloadLABEL"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: previousLastREBOOT is: $previousLastREBOOT"
	# Only validate if we know the list of previous downloads and last reboot time.
	if [[ -n $macOSSoftwareUpdateDownloadLABEL ]] && [[ -n $previousLastREBOOT ]]; then
		previousDownloadFAILURE="FALSE"
		if [[ "$macOSSoftwareUpdateDownloadLABEL" != "$softwareUpdateLabelTARGET" ]]; then
			sendToLog "Warning: Previously downloaded update/upgrade \"$macOSSoftwareUpdateDownloadLABEL\" does not match the expected update/upgrade \"$softwareUpdateLabelTARGET\", download workflow needs to run again."
			previousDownloadFAILURE="TRUE"
			restartZeroDay
		fi
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: lastREBOOT is: $lastREBOOT"
		if [[ "$lastREBOOT" != "$previousLastREBOOT" ]]; then
			sendToLog "Warning: The system has been restarted without applying the previously downloaded macOS update, download workflow needs to run again."
			previousDownloadFAILURE="TRUE"
		fi
		# Only validate prepared macOS update/upgrade if needed.
		if { [[ $macOSVERSION -ge 1203 ]] && [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; } || { [[ $macOSMAJOR -ge 11 ]] && [[ "$softwareUpdateMACOS" == "TRUE" ]]; }; then
			preparedMacOSATTRIBUTES=$(defaults read /System/Volumes/Update/Update update-asset-attributes 2> /dev/null)
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: preparedMacOSATTRIBUTES is:\n$preparedMacOSATTRIBUTES"
			preparedMacOSVERSION=$(echo "$preparedMacOSATTRIBUTES" | grep -w 'OSVersion' | awk -F '"' '{print $2}')
			if [[ $macOSMAJOR -ge 13 ]]; then
				preparedMacOSExtraVERSION=$(echo "$preparedMacOSATTRIBUTES" | grep -w 'ProductVersionExtra' | awk -F '"' '{print $2}')
				[[ -n $preparedMacOSExtraVERSION ]] && preparedMacOSVERSION="$preparedMacOSVERSION $preparedMacOSExtraVERSION"
				[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: preparedMacOSExtraVERSION is: $preparedMacOSExtraVERSION"
			fi
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: preparedMacOSVERSION is: $preparedMacOSVERSION"
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeVersionTARGET is: $macOSUpgradeVersionTARGET"
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateVERSION is: $macOSSoftwareUpdateVERSION"
			if [[ -z $preparedMacOSVERSION ]]; then
				sendToLog "Warning: Previously downloaded macOS update/upgrade is no longer valid, download workflow needs to run again."
				previousDownloadFAILURE="TRUE"
			else
				if { [[ $macOSVERSION -ge 1203 ]] && [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; } && [[ "$preparedMacOSVERSION" != "$macOSUpgradeVersionTARGET" ]]; then
					sendToLog "Warning: Previously downloaded macOS upgrade version $preparedMacOSVERSION doesn't match expected version $macOSUpgradeVersionTARGET, download workflow needs to run again."
					previousDownloadFAILURE="TRUE"
				fi
				if { [[ $macOSMAJOR -ge 11 ]] && [[ "$macOSUpgradeVersionTARGET" == "FALSE" ]]; } && [[ "$preparedMacOSVERSION" != "$macOSSoftwareUpdateVERSION" ]]; then
					sendToLog "Warning: Previously downloaded macOS update version $preparedMacOSVERSION doesn't match expected version $macOSSoftwareUpdateVERSION, download workflow needs to run again."
					previousDownloadFAILURE="TRUE"
				fi
			fi
			if [[ "$previousDownloadFAILURE" == "TRUE" ]]; then
				macOSSoftwareUpdateDownloadREQUIRED="TRUE"
				defaults delete "$superPLIST" macOSSoftwareUpdateDownloadLabel 2> /dev/null
				defaults delete "$superPLIST" LastReboot 2> /dev/null
			fi
		fi
	else
		macOSSoftwareUpdateDownloadREQUIRED="TRUE"
	fi
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSInstallerDownloadREQUIRED is: $macOSInstallerDownloadREQUIRED"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateDownloadREQUIRED is: $macOSSoftwareUpdateDownloadREQUIRED"
}

# This function checks the macOS upgrade/update status after a previous super macOS upgrade/update restart.
checkAfterRestart() {
unset restartVALIDATE
fullCheckREQUIRED="TRUE"
checkSoftwareUpdates
checkMacOSUpgrades
checkMacOSDownloads

# Install any recommended (non-system) software updates.
if [[ "$softwareUpdateRECOMMENDED" == "TRUE" ]]; then
	installRecommendedSoftwareUpdates
	if [[ "$softwareUpdateERROR" != "TRUE" ]]; then
		sendToLog "Status: Completed installation of all recommended (non-system) updates."
	else
		sendToLog "Warning: Failed to install all recommended (non-system) updates."
	fi
	fullCheckREQUIRED="TRUE"
	checkSoftwareUpdates
	checkMacOSUpgrades
	checkMacOSDownloads
fi

# Log status of updates/upgrade completion.
if [[ "$softwareUpdateRECOMMENDED" == "FALSE" ]] && [[ "$softwareUpdateMACOS" == "FALSE" ]] && { [[ "$macOSUpgradeAVAILABLE" == "FALSE" ]] || { [[ "$macOSUpgradeAVAILABLE" != "FALSE" ]] && [[ "$upgradeWORKFLOW" == "FALSE" ]]; }; }; then
	sendToLog "Status: All available and enabled software updates/upgrade completed."
	fullCheckREQUIRED="FALSE"
else
	sendToLog "Warning: Some software updates/upgrade did not complete after last restart, continuing workflow."
fi

# For computers managed via Jamf Pro, submit inventory and check for policies.
if [[ "$jamfVERSION" != "FALSE" ]]; then
	if [[ "$jamfSERVER" != "FALSE" ]]; then
		sendToLog "Status: Submitting updated inventory to Jamf Pro. Use --verbose-mode or check /var/log/jamf.log for more detail..."
		if [[ "$verboseModeOPTION" == "TRUE" ]]; then
			jamfRESULT=$("$jamfBINARY" recon -verbose 2>&1)
			jamfRETURN=$?
			sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfRESULT is:\n$jamfRESULT"
			sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfRETURN is: $jamfRETURN"
		else
			"$jamfBINARY" recon > /dev/null 2>&1
		fi
		sleep 5
		sendToLog "Status: Running Jamf Pro check-in policies. Use --verbose-mode or check /var/log/jamf.log for more detail..."
		if [[ "$verboseModeOPTION" == "TRUE" ]]; then
			jamfRESULT=$("$jamfBINARY" policy -verbose 2>&1)
			jamfRETURN=$?
			sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfRESULT is:\n$jamfRESULT"
			sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfRETURN is: $jamfRETURN"
		else
			"$jamfBINARY" policy > /dev/null 2>&1
		fi
	else
		deferSECONDS="$errorDeferSECONDS"
		sendToLog "Error: Unable to submit inventory to Jamf Pro, trying again in $deferSECONDS seconds."
		sendToStatus "Pending: Unable to submit inventory to Jamf Pro, trying again in $deferSECONDS seconds."
		makeLaunchDaemonCalendar
	fi
fi
}

# MARK: *** Pre-Installation Prep ***
################################################################################

# Download macOS update or upgrade via softwareupdate command, and also save results to $superLOG, $asuLOG, and $superPLIST.
downloadMacOSSoftwareUpdate() {
sendToLog "softwareupdate: Starting $softwareUpdateTitleTARGET download workflow, check $asuLOG for more detail."
sendToStatus "Running: softwareupdate: Starting $softwareUpdateTitleTARGET download workflow."
sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD $softwareUpdateTitleTARGET SOFTWAREUPDATE START ****"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateLabelTARGET[] is:\n${softwareUpdateLabelTARGET[*]}"

# The softwareupdate download process is backgrounded and is watched via a while loop later on. Also note the difference between macOS versions.
if [[ $macOSMAJOR -ge 13 ]]; then # macOS 13+
	if [[ "$macOSARCH" == "arm64" ]]; then  # Apple Silicon.
		echo ' ' | launchctl asuser "$currentUserUID" sudo -u "$currentUserNAME" softwareupdate --download "$softwareUpdateLabelTARGET" --agree-to-license --user "$currentUserNAME" --stdinpass >> "$asuLOG" 2>&1 &
		softwareupdatePID=$!
	else # Intel.
		launchctl asuser "$currentUserUID" sudo -u "$currentUserNAME" softwareupdate --download "$softwareUpdateLabelTARGET" --agree-to-license >> "$asuLOG" 2>&1 &
		softwareupdatePID=$!
	fi
elif [[ $macOSMAJOR -ge 12 ]]; then # macOS 12
	if [[ "$macOSARCH" == "arm64" ]]; then  # Apple Silicon.
		launchctl asuser "$currentUserUID" sudo -u root softwareupdate --download "$softwareUpdateLabelTARGET" --agree-to-license --user "root" --stdinpass "" >> "$asuLOG" 2>&1 &
		softwareupdatePID=$!
	else # Intel.
		launchctl asuser "$currentUserUID" sudo -u root softwareupdate --download "$softwareUpdateLabelTARGET" --agree-to-license >> "$asuLOG" 2>&1 &
		softwareupdatePID=$!
	fi
elif [[ $macOSMAJOR -eq 11 ]]; then # macOS 11
	if [[ "$macOSARCH" == "arm64" ]]; then # Apple Silicon.
		echo ' ' | softwareupdate --download "$softwareUpdateLabelTARGET" --agree-to-license >> "$asuLOG" 2>&1 &
	else # Intel.
		softwareupdate --download "$softwareUpdateLabelTARGET" --agree-to-license >> "$asuLOG" 2>&1 &
		softwareupdatePID=$!
	fi
else # macOS 10.x
	softwareupdate --download "$softwareUpdateLabelTARGET" >> "$asuLOG" 2>&1 &
	softwareupdatePID=$!
fi

# Watch $asuLOG while waiting for the softwareupdate download workflow to complete.
# Note this while read loop has a timeout based on $initialStartTimeoutSECONDS then changes to $softwareUpdateTimeoutSECONDS or $softwareUpdateLegacyTimeoutSECONDS.
workflowStartTIMEOUT="TRUE"
workflowStartFAIL="TRUE"
workflowTIMEOUT="TRUE"
workflowTimeoutSECONDS=$initialStartTimeoutSECONDS
workflowPHASE="START"
workflowCompletePERCENT=0
workflowPreviousCompletePERCENT=0
softwareUpdateDownloadTITLE=""
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
while read -t $workflowTimeoutSECONDS -r logLINE ; do
	# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
	if [[ $(echo "$logLINE" | grep -c "Can’t connect" ) -gt 0 ]] || [[ $(echo "$logLINE" | grep -c "Couldn't communicate" ) -gt 0 ]] || [[ $(echo "$logLINE" | grep -c 'No such update' ) -gt 0 ]] || [[ $(echo "$logLINE" | grep -c 'Failed to download' ) -gt 0 ]]; then
		workflowStartFAIL="CONNECT"
		workflowStartTIMEOUT="FALSE"
		workflowTIMEOUT="FALSE"
		break
	elif [[ $(echo "$logLINE" | grep -c 'No such update' ) -gt 0 ]]; then
		workflowStartFAIL="NOUPDATE"
		workflowStartTIMEOUT="FALSE"
		workflowTIMEOUT="FALSE"
		break
	elif [[ $(echo "$logLINE" | grep -c 'Not enough free disk space' ) -gt 0 ]]; then
		workflowStartFAIL="SPACE"
		workflowStartTIMEOUT="FALSE"
		workflowTIMEOUT="FALSE"
		break
	elif [[ $(echo "$logLINE" | grep -c 'Failed to download & prepare' ) -gt 0 ]]; then
		workflowStartFAIL="FAILED"
		workflowStartTIMEOUT="FALSE"
		workflowTIMEOUT="FALSE"
		break
	elif [[ $macOSMAJOR -lt 11 ]] && [[ $(echo "$logLINE" | grep -c 'Software Update Tool') -gt 0 ]]; then
		sendToLog "softwareupdate: $softwareUpdateLabelTARGET is downloading, but detailed progress is not available for systems older than macOS 11..."
		sendToASULog "**** TIMESTAMP ****"
		workflowPHASE="DOWNLOADING"
		workflowTimeoutSECONDS=$softwareUpdateLegacyTimeoutSECONDS
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
		workflowStartTIMEOUT="FALSE"
		workflowStartFAIL="FALSE"
	elif [[ $macOSMAJOR -ge 11 ]] && [[ $(echo "$logLINE" | grep -c 'Downloading') -gt 0 ]] && [[ "$workflowPHASE" == "START" ]]; then
		softwareUpdateDownloadTITLE=$(echo "$logLINE" | sed -e 's/Downloading //')
		sendToLog "softwareupdate: $softwareUpdateDownloadTITLE is downloading..."
		sendToASULog "**** TIMESTAMP ****"
		workflowPHASE="DOWNLOADING"
		workflowTimeoutSECONDS=$softwareUpdateTimeoutSECONDS
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
		workflowStartTIMEOUT="FALSE"
		workflowStartFAIL="FALSE"
		[[ $(echo "$softwareUpdateDownloadTITLE" | grep -c 'macOS') -gt 0 ]] && workflowPHASE="DOWNLOADING"
	elif [[ $macOSMAJOR -ge 11 ]] && [[ $(echo "$logLINE" | grep -c 'Downloading') -gt 0 ]] && [[ "$workflowPHASE" == "DOWNLOADING" ]]; then
		workflowCompletePERCENT=$(echo "$logLINE" | sed -e 's/Downloading: //' -e 's/\.[0-9][0-9]//' | tr -d '\n' | tr -d '\r')
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowCompletePERCENT is: $workflowCompletePERCENT"
		if [[ $workflowCompletePERCENT -ge 60 ]]; then
			sendToEchoReplaceLine "$softwareUpdateDownloadTITLE download progress: 100%\n"
			sendToLog "softwareupdate: $softwareUpdateDownloadTITLE download complete, now preparing..."
			sendToASULog "**** TIMESTAMP ****"
			workflowPHASE="PREPARING"
		elif [[ $workflowCompletePERCENT -gt $workflowPreviousCompletePERCENT ]]; then
			workflowCompleteDISPLAY=$( (echo "$workflowCompletePERCENT * 1.69" | bc ) | cut -d '.' -f1)
			sendToEchoReplaceLine "$softwareUpdateDownloadTITLE download progress: $workflowCompleteDISPLAY%"
			workflowPreviousCompletePERCENT=$workflowCompletePERCENT
		fi
	elif [[ $macOSMAJOR -ge 11 ]] && [[ $(echo "$logLINE" | grep -c 'Downloading') -gt 0 ]] && [[ "$workflowPHASE" == "PREPARING" ]]; then
		workflowCompletePERCENT=$(echo "$logLINE" | sed -e 's/Downloading: //' -e 's/\.[0-9][0-9]//' | tr -d '\n' | tr -d '\r')
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowCompletePERCENT is: $workflowCompletePERCENT"
		if [[ $workflowCompletePERCENT -ge 100 ]]; then
			sendToEchoReplaceLine "$softwareUpdateDownloadTITLE preparing progress: 100%\n"
			sendToASULog "**** TIMESTAMP ****"
			workflowPHASE="DONE"
		elif [[ $workflowCompletePERCENT -gt $workflowPreviousCompletePERCENT ]]; then
			workflowCompleteDISPLAY=$(((workflowCompletePERCENT-60)*2))
			sendToEchoReplaceLine "$softwareUpdateDownloadTITLE preparing progress: $workflowCompleteDISPLAY%"
			workflowPreviousCompletePERCENT=$workflowCompletePERCENT
		fi
	elif [[ $(echo "$logLINE" | grep -c 'Downloaded') -gt 0 ]]; then
		softwareUpdateDownloadTITLE=$(echo "$logLINE" | sed -e 's/://' -e 's/Downloaded //')
		sendToLog "softwareupdate: $softwareUpdateDownloadTITLE download and preparation complete."
		workflowStartTIMEOUT="FALSE"
		workflowStartFAIL="FALSE"
		workflowTIMEOUT="FALSE"
		break
	fi
done < <(tail -n1 -F "$asuLOG" | tr -u '%' '\n')

# If the softwareupdate download workflow completed, then validate and collect information.
if [[ "$workflowStartTIMEOUT" == "FALSE" ]] && [[ "$workflowStartFAIL" == "FALSE" ]] && [[ "$workflowTIMEOUT" == "FALSE" ]]; then
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateTitleTARGET is: $softwareUpdateTitleTARGET"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateDownloadTITLE is: $softwareUpdateDownloadTITLE"
	if [[ "$softwareUpdateTitleTARGET" == "$softwareUpdateDownloadTITLE" ]]; then
		if [[ $macOSMAJOR -ge 11 ]]; then
			preparedMacOSATTRIBUTES=$(defaults read /System/Volumes/Update/Update update-asset-attributes 2> /dev/null)
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: preparedMacOSATTRIBUTES is:\n$preparedMacOSATTRIBUTES"
			preparedMacOSVERSION=$(echo "$preparedMacOSATTRIBUTES" | grep -w 'OSVersion' | awk -F '"' '{print $2}')
			if [[ $macOSMAJOR -ge 13 ]]; then
				preparedMacOSExtraVERSION=$(echo "$preparedMacOSATTRIBUTES" | grep -w 'ProductVersionExtra' | awk -F '"' '{print $2}')
				[[ -n $preparedMacOSExtraVERSION ]] && preparedMacOSVERSION="$preparedMacOSVERSION $preparedMacOSExtraVERSION"
				[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: preparedMacOSExtraVERSION is: $preparedMacOSExtraVERSION"
			fi
		fi
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: preparedMacOSVERSION is: $preparedMacOSVERSION"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeVersionTARGET is: $macOSUpgradeVersionTARGET"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateVERSION is: $macOSSoftwareUpdateVERSION"
		if { [[ $macOSVERSION -ge 1203 ]] && [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; } && [[ "$preparedMacOSVERSION" != "$macOSUpgradeVersionTARGET" ]]; then
			sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD SOFTWAREUPDATE FAILED ****"
			if [[ "$installNowOPTION" == "TRUE" ]]; then
				sendToASULog "Error: Downloaded macOS upgrade version of $preparedMacOSVERSION doesn't match expected version $macOSUpgradeVersionTARGET, install now workflow can not continue."
				sendToLog "Error: Downloaded macOS upgrade version of $preparedMacOSVERSION doesn't match expected version $macOSUpgradeVersionTARGET, install now workflow can not continue."
				sendToStatus "Inactive Error: Downloaded macOS upgrade version of $preparedMacOSVERSION doesn't match expected version $macOSUpgradeVersionTARGET, install now workflow can not continue."
				notifyInstallNowFailure
				errorExit
			else
				deferSECONDS="$errorDeferSECONDS"
				sendToASULog "Error: Downloaded macOS upgrade version of $preparedMacOSVERSION doesn't match expected version $macOSUpgradeVersionTARGET, trying again in $deferSECONDS seconds."
				sendToLog "Error: Downloaded macOS upgrade version of $preparedMacOSVERSION doesn't match expected version $macOSUpgradeVersionTARGET, trying again in $deferSECONDS seconds."
				sendToStatus "Pending: Downloaded macOS upgrade version of $preparedMacOSVERSION doesn't match expected version $macOSUpgradeVersionTARGET, trying again in $deferSECONDS seconds."
				kickSoftwareUpdateD
				makeLaunchDaemonCalendar
			fi
		fi
		if { [[ $macOSMAJOR -ge 11 ]] && [[ "$macOSUpgradeVersionTARGET" == "FALSE" ]]; } && [[ "$preparedMacOSVERSION" != "$macOSSoftwareUpdateVERSION" ]]; then
			sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD SOFTWAREUPDATE FAILED ****"
			if [[ "$installNowOPTION" == "TRUE" ]]; then
				sendToASULog "Error: Downloaded macOS update version of $preparedMacOSVERSION doesn't match expected version $macOSSoftwareUpdateVERSION, install now workflow can not continue."
				sendToLog "Error: Downloaded macOS update version of $preparedMacOSVERSION doesn't match expected version $macOSSoftwareUpdateVERSION, install now workflow can not continue."
				sendToStatus "Inactive Error: Downloaded macOS update version of $preparedMacOSVERSION doesn't match expected version $macOSSoftwareUpdateVERSION, install now workflow can not continue."
				notifyInstallNowFailure
				errorExit
			else
				deferSECONDS="$errorDeferSECONDS"
				sendToASULog "Error: Downloaded macOS update version of $preparedMacOSVERSION doesn't match expected version $macOSSoftwareUpdateVERSION, trying again in $deferSECONDS seconds."
				sendToLog "Error: Downloaded macOS update version of $preparedMacOSVERSION doesn't match expected version $macOSSoftwareUpdateVERSION, trying again in $deferSECONDS seconds."
				sendToStatus "Pending: Downloaded macOS update version of $preparedMacOSVERSION doesn't match expected version $macOSSoftwareUpdateVERSION, trying again in $deferSECONDS seconds."
				kickSoftwareUpdateD
				makeLaunchDaemonCalendar
			fi
		fi
		sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD SOFTWAREUPDATE COMPLETED ****"
		defaults write "$superPLIST" macOSSoftwareUpdateDownloadLabel -string "$softwareUpdateLabelTARGET"
		defaults write "$superPLIST" LastReboot -string "$lastREBOOT"
		macOSSoftwareUpdateDownloadREQUIRED="FALSE"
		[[ "$onlyDownloadOPTION" == "TRUE" ]] && onlyDownloadCOMPLETE="TRUE"
	else # The expected $softwareUpdateTitleTARGET did not match the $softwareUpdateDownloadTITLE.
		sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD SOFTWAREUPDATE INCOMPLETE ****"
		if [[ "$installNowOPTION" == "TRUE" ]]; then
			sendToASULog "Error: Download of $softwareUpdateTitleTARGET did not complete, install now workflow can not continue."
			sendToLog "Error: Download of $softwareUpdateTitleTARGET did not complete, install now workflow can not continue."
			sendToStatus "Inactive Error: Download of $softwareUpdateTitleTARGET did not complete, install now workflow can not continue."
			notifyInstallNowFailure
			errorExit
		else
			deferSECONDS="$errorDeferSECONDS"
			sendToASULog "Error: Download of $softwareUpdateTitleTARGET did not complete, trying again in $deferSECONDS seconds."
			sendToLog "Error: Download of $softwareUpdateTitleTARGET did not complete, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Download of $softwareUpdateTitleTARGET did not complete, trying again in $deferSECONDS seconds."
			kickSoftwareUpdateD
			makeLaunchDaemonCalendar
		fi
	fi
else # The softwareupdate download workflow failed so clean-up and try again later.
	sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD SOFTWAREUPDATE FAILED ****"
	kill -9 "$softwareupdatePID" > /dev/null 2>&1
	kickSoftwareUpdateD
	if [[ "$installNowOPTION" == "TRUE" ]]; then
		if [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
			sendToASULog "Error: Download of software updates failed to start after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			sendToLog "Error: Download of software updates failed to start after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			sendToStatus "Inactive Error: Download of software updates failed to start after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
		elif [[ "$workflowStartFAIL" == "CONNECT" ]]; then
			sendToASULog "Error: Unable to reach Apple Software Update server, install now workflow can not continue."
			sendToLog "Error: Unable to reach Apple Software Update server, install now workflow can not continue."
			sendToStatus "Inactive Error: Unable to reach Apple Software Update server, install now workflow can not continue."
		elif [[ "$workflowStartFAIL" == "NOUPDATE" ]]; then
			sendToASULog "Error: Unable to find requested software updates, install now workflow can not continue."
			sendToLog "Error: Unable to find requested software updates, install now workflow can not continue."
			sendToStatus "Inactive Error: Unable to find requested software updates, install now workflow can not continue."
		elif [[ "$workflowStartFAIL" == "SPACE" ]]; then
			sendToASULog "Error: Not enough free disk space to download software updates, install now workflow can not continue."
			sendToLog "Error: Not enough free disk space to download software updates, install now workflow can not continue."
			sendToStatus "Inactive Error: Not enough free disk space to download software updates, install now workflow can not continue."
		elif [[ "$workflowStartFAIL" == "FAILED" ]]; then
			sendToASULog "Error: Failed to download & prepare updates, install now workflow can not continue."
			sendToLog "Error: Failed to download & prepare updates, install now workflow can not continue."
			sendToStatus "Inactive Error: Failed to download & prepare updates, install now workflow can not continue."
		elif [[ "$workflowTIMEOUT" == "TRUE" ]]; then
			sendToASULog "Error: Download of software updates timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			sendToLog "Error: Download of software updates timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			sendToStatus "Inactive Error: Download of software updates timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
		fi
		notifyInstallNowFailure
		errorExit
	else
		deferSECONDS="$errorDeferSECONDS"
		if [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
			sendToASULog "Error: Download of software updates failed to start after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			sendToLog "Error: Download of software updates failed to start after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Download of software updates failed to start after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
		elif [[ "$workflowStartFAIL" == "CONNECT" ]]; then
			sendToASULog "Error: Unable to reach Apple Software Update server, trying again in $deferSECONDS seconds."
			sendToLog "Error: Unable to reach Apple Software Update server, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Unable to reach Apple Software Update server, trying again in $deferSECONDS seconds."
		elif [[ "$workflowStartFAIL" == "NOUPDATE" ]]; then
			sendToASULog "Error: Unable to find requested software updates, trying again in $deferSECONDS seconds."
			sendToLog "Error: Unable to find requested software updates, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Unable to find requested software updates, trying again in $deferSECONDS seconds."
		elif [[ "$workflowStartFAIL" == "SPACE" ]]; then
			sendToASULog "Error: Not enough free disk space to download software updates, trying again in $deferSECONDS seconds."
			sendToLog "Error: Not enough free disk space to download software updates, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Not enough free disk space to download software updates, trying again in $deferSECONDS seconds."
		elif [[ "$workflowStartFAIL" == "FAILED" ]]; then
			sendToASULog "Error: Failed to download & prepare updates, trying again in $deferSECONDS seconds."
			sendToLog "Error: Failed to download & prepare updates, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Failed to download & prepare updates, trying again in $deferSECONDS seconds."
		elif [[ "$workflowTIMEOUT" == "TRUE" ]]; then
			sendToASULog "Error: Download of software updates timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			sendToLog "Error: Download of software updates timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Download of software updates timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
		fi
		makeLaunchDaemonCalendar
	fi
fi
}

# Download macOS installer via $eraseInstallSCRIPT, and also save results to $superLOG, $installerLOG, and $superPLIST.
downloadMacOSInstaller() {
sendToLog "erase-install.sh: Starting $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET download installer workflow, check $installerLOG for more detail."
sendToStatus "Running: erase-install.sh: Starting $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET download installer workflow."
sendToInstallerLog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET INSTALLER START ****"

# Background the erase-install download process and send to $installerLOG.
if [[ "$betaWORKFLOW" != "FALSE" ]]; then
	"$eraseInstallSCRIPT" --update --seed "$betaWORKFLOW" --build "$macOSInstallerBuildTARGET" --move >> "$installerLOG" 2>&1 &
	eraseInstallPID=$!
else # Standard non-beta workflow.
	"$eraseInstallSCRIPT" --update --build "$macOSInstallerBuildTARGET" --move >> "$installerLOG" 2>&1 &
	eraseInstallPID=$!
fi

# Watch $installerLOG while waiting for the erase-install download process to complete.
# Note this while read loop has a timeout based on $initialStartTimeoutSECONDS then changes to $macOSInstallerDownloadTimeoutSECONDS.
workflowStartTIMEOUT="TRUE"
workflowStartFAIL="TRUE"
workflowTIMEOUT="TRUE"
workflowTimeoutSECONDS=$initialStartTimeoutSECONDS
workflowPHASE=""
workflowCompletePERCENT=0
workflowPreviousCompletePERCENT=0
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
while read -t $workflowTimeoutSECONDS -r logLINE ; do
	# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
	if [[ $(echo "$logLINE" | grep -c 'Cannot continue.' ) -gt 0 ]] || [[ $(echo "$macOSInstallerLIST" | grep -c 'exit code: 1') -gt 0 ]]; then
		workflowStartTIMEOUT="FALSE"
		workflowTIMEOUT="FALSE"
		break
	elif [[ $(echo "$logLINE" | grep -c 'installinstallmacos.py --workdir') -gt 0 ]]; then
		sendToLog "erase-install.sh: Install $macOSInstallerNameTARGET.app is downloading..."
		sendToInstallerLog "**** TIMESTAMP ****"
		workflowTimeoutSECONDS=$macOSInstallerDownloadTimeoutSECONDS
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
		workflowPHASE="DOWNLOADING"
		workflowStartTIMEOUT="FALSE"
		workflowStartFAIL="FALSE"
	elif [[ "$workflowPHASE" == "DOWNLOADING" ]] && [[ $(echo "$logLINE" | grep -c '^[1-9]') -gt 0 ]] && [[ $(echo "$logLINE" | grep -c 'M') -gt 0 ]]; then
		workflowCompletePERCENT=$(echo "$logLINE" | awk '{print $1}')
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowCompletePERCENT is: $workflowCompletePERCENT"
		if [[ $workflowCompletePERCENT -ge 100 ]]; then
			sendToEchoReplaceLine "Install $macOSInstallerNameTARGET.app download progress: 100%\n"
			sendToLog "erase-install.sh: Install $macOSInstallerNameTARGET.app download complete, now preparing..."
			sendToASULog "**** TIMESTAMP ****"
			workflowPHASE="DONE"
		elif [[ $workflowCompletePERCENT -gt $workflowPreviousCompletePERCENT ]]; then
			sendToEchoReplaceLine "Install $macOSInstallerNameTARGET.app download progress: $workflowCompletePERCENT%"
			workflowPreviousCompletePERCENT=$workflowCompletePERCENT
		fi
	elif [[ $(echo "$logLINE" | grep -c 'Invoking --move option') -gt 0 ]]; then
		sendToLog "erase-install.sh: Install $macOSInstallerNameTARGET.app is prepared, now moving to /Applications..."
		sendToInstallerLog "**** TIMESTAMP ****"
		workflowStartTIMEOUT="FALSE"
		workflowStartFAIL="FALSE"
	elif [[ $(echo "$logLINE" | grep -c 'Installation moved') -gt 0 ]]; then
		sendToLog "erase-install.sh: Install $macOSInstallerNameTARGET.app moved to /Applications."
		sendToInstallerLog "**** TIMESTAMP ****"
		workflowStartTIMEOUT="FALSE"
		workflowStartFAIL="FALSE"
	elif [[ $(echo "$logLINE" | grep -c 'Valid installer') -gt 0 ]]; then
		sendToLog "erase-install.sh: Install $macOSInstallerNameTARGET.app already found in /Applications."
		sendToInstallerLog "**** TIMESTAMP ****"
		workflowStartTIMEOUT="FALSE"
		workflowStartFAIL="FALSE"
	elif [[ $(echo "$logLINE" | grep -c 'finish') -gt 0 ]]; then
		sendToInstallerLog "**** TIMESTAMP ****"
		workflowTIMEOUT="FALSE"
		break
	fi
done < <(tail -n1 -F "$installerLOG" | tr -u 'G' '\n')

# If the erase-install download process completed, then prepare for future installation.
if [[ "$workflowStartTIMEOUT" == "FALSE" ]] && [[ "$workflowStartFAIL" == "FALSE" ]] && [[ "$workflowTIMEOUT" == "FALSE" ]]; then
	if [[ -d "/Applications/Install $macOSInstallerNameTARGET.app" ]]; then
		sendToLog "Status: Install $macOSInstallerNameTARGET.app Gatekeeper validation..."
		sendToInstallerLog "Status: Install $macOSInstallerNameTARGET.app Gatekeeper validation."
		startosinstallRESULTS=$("/Applications/Install $macOSInstallerNameTARGET.app/Contents/Resources/startosinstall" --usage 2>&1)
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: startosinstallRESULTS is:\n$startosinstallRESULTS"
		if [[ $(echo "$startosinstallRESULTS" | grep -c 'Usage: startosinstall') -gt 0 ]]; then
			sendToInstallerLog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD MACOS INSTALLER COMPLETE ****"
			sendToLog "Status: macOS installer is now available at: /Applications/Install $macOSInstallerNameTARGET.app"
			defaults write "$superPLIST" macOSInstallerDownloadVersion -string "$macOSInstallerVersionTARGET"
			defaults write "$superPLIST" macOSInstallerDownloadName -string "$macOSInstallerNameTARGET"
			macOSInstallerDownloadREQUIRED="FALSE"
			[[ "$onlyDownloadOPTION" == "TRUE" ]] && onlyDownloadCOMPLETE="TRUE"
		else # The installer can't be verified, so clean-up and try again later.
			sendToInstallerLog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD MACOS INSTALLER FAILURE ****"
			sendToInstallerLog "Warning: macOS installer failed Gatekeeper validation, removing installer: /Applications/Install $macOSInstallerNameTARGET.app"
			sendToLog "Warning: macOS installer failed Gatekeeper validation, removing installer: /Applications/Install $macOSInstallerNameTARGET.app"
			rm -Rf "/Applications/Install $macOSInstallerNameTARGET.app" > /dev/null 2>&1
			defaults delete "$superPLIST" macOSInstallerDownloadVersion 2> /dev/null
			defaults delete "$superPLIST" macOSInstallerDownloadName 2> /dev/null
			if [[ "$installNowOPTION" == "TRUE" ]]; then
				sendToInstallerLog "Error: macOS installer download could not be verified, install now workflow can not continue."
				sendToLog "Error: macOS installer download could not be verified, install now workflow can not continue."
				sendToStatus "Inactive Error: macOS installer download could not be verified, install now workflow can not continue."
				notifyInstallNowFailure
				errorExit
			else
				deferSECONDS="$errorDeferSECONDS"
				sendToInstallerLog "Error: macOS installer download could not be verified, trying again in $deferSECONDS seconds."
				sendToLog "Error: macOS installer download could not be verified, trying again in $deferSECONDS seconds."
				sendToStatus "Pending: macOS installer download could not be verified, trying again in $deferSECONDS seconds."
				makeLaunchDaemonCalendar
			fi
		fi
	else # The installer can't be found, so clean-up and try again later.
		sendToInstallerLog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD MACOS INSTALLER FAILURE ****"
		if [[ "$installNowOPTION" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer download could not be found, install now workflow can not continue."
			sendToLog "Error: macOS installer download could not be found, install now workflow can not continue."
			sendToStatus "Inactive Error: macOS installer download could not be found, install now workflow can not continue."
			notifyInstallNowFailure
			errorExit
		else
			deferSECONDS="$errorDeferSECONDS"
			sendToInstallerLog "Error: macOS installer download could not be found, trying again in $deferSECONDS seconds."
			sendToLog "Error: macOS installer download could not be found, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: macOS installer download could not be found, trying again in $deferSECONDS seconds."
			makeLaunchDaemonCalendar
		fi
	fi
else # The erase-install download workflow failed so clean-up and try again later.
	sendToInstallerLog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD MACOS INSTALLER FAILED ****"
	kill -9 "$eraseInstallPID" > /dev/null 2>&1
	if [[ "$installNowOPTION" == "TRUE" ]]; then
		if [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer download failed to start after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			sendToLog "Error: macOS installer download failed to start after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			sendToStatus "Inactive Error: macOS installer download failed to start after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
		elif [[ "$workflowStartFAIL" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer failed to download, install now workflow can not continue."
			sendToLog "Error: macOS installer failed to download, install now workflow can not continue."
			sendToStatus "Inactive Error: macOS installer failed to download, install now workflow can not continue."
		elif [[ "$workflowTIMEOUT" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer download timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			sendToLog "Error: macOS installer download timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			sendToStatus "Inactive Error: macOS installer download timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
		fi
		notifyInstallNowFailure
		errorExit
	else
		deferSECONDS="$errorDeferSECONDS"
		if [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer download failed to start after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			sendToLog "Error: macOS installer download failed to start after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: macOS installer download failed to start after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
		elif [[ "$workflowStartFAIL" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer failed to download, trying again in $deferSECONDS seconds."
			sendToLog "Error: macOS installer failed to download, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: macOS installer failed to download, trying again in $deferSECONDS seconds."
		elif [[ "$workflowTIMEOUT" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer download timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			sendToLog "Error: macOS installer download timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: macOS installer download timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
		fi
		makeLaunchDaemonCalendar
	fi
fi
}

# This function contains logic to determine the correct download behavior based on system condition and specified options.
downloadMacOSWorkflow() {
# Check to make sure system has enough available free storage space.
checkAvailableStorage
if [[ "$storageREADY" == "FALSE" ]]; then
	if [[ "$currentUserNAME" == "FALSE" ]]; then
		deferSECONDS="$errorDeferSECONDS"
		sendToLog "Error: Current available storage is at $availableStorageGB GBs which is below the $requiredStorageGB GBs that is required for download. No active user is logged in so trying again in $deferSECONDS seconds."
		sendToStatus "Inactive Error: Current available storage is at $availableStorageGB GBs which is below the $requiredStorageGB GBs that is required for download. No active user is logged in so trying again in $deferSECONDS seconds."
		makeLaunchDaemonCalendar
	else # A normal user is currently logged in.
		notifyStorage
	fi
fi
# If the workflow made it this far there is sufficient free space to continue with download.
if [[ "$testModeOPTION" != "TRUE" ]]; then
	onlyDownloadCOMPLETE="FALSE"
	if [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; then # A macOS upgrade is available and option to allow upgrade is enabled.
		if [[ $macOSVERSION -ge 1203 ]] && [[ "$upgradeWORKFLOW" != "JAMF" ]]; then # macOS 12.3 or newer can upgrade via softwareupdate, unless using MDM workflow.
			if [[ "$macOSSoftwareUpdateDownloadREQUIRED" == "TRUE" ]]; then
				[[ "$installNowOPTION" == "TRUE" ]] && notifyInstallNowDownload
				downloadMacOSSoftwareUpdate
			else
				sendToLog "Status: Previously downloaded macOS upgrade is prepared: $macOSSoftwareUpdateDownloadLABEL"
			fi
		else # Systems older than macOS 12.3 or using the MDM workflow upgrade via installer.
			if [[ "$macOSInstallerDownloadREQUIRED" == "TRUE" ]]; then
				[[ "$installNowOPTION" == "TRUE" ]] && notifyInstallNowDownload
				downloadMacOSInstaller
			else
				sendToLog "Status: Previously downloaded $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET installer is available at: /Applications/Install $macOSInstallerNameTARGET.app"
			fi
		fi
	else # Only macOS updates are available.
		if [[ "$macOSSoftwareUpdateDownloadREQUIRED" == "TRUE" ]]; then
			[[ "$installNowOPTION" == "TRUE" ]] && notifyInstallNowDownload
			downloadMacOSSoftwareUpdate
		else
			sendToLog "Status: Previously downloaded macOS update is prepared: $macOSSoftwareUpdateDownloadLABEL"
		fi
	fi
else # Test mode.
	if [[ "$installNowOPTION" == "TRUE" ]]; then
		notifyInstallNowDownload
		sendToLog "Test Mode: Pausing $testModeTimeoutSECONDS seconds for install now download notification..."
		sleep "$testModeTimeoutSECONDS"
	else
		sendToLog "Test Mode: Ignoring macOS download workflow."
	fi
fi
}

# Install any optional $policyTRIGGERS.
runJamfPolicies() {
sendToLog "Status: Starting Jamf Policy triggers. Use --verbose-mode or check /var/log/jamf.log for more detail..."
sendToStatus "Running: Starting Jamf Policy triggers."
oldIFS="$IFS"; IFS=','
read -r -a triggerARRAY <<< "$policyTRIGGERS"
for trigger in "${triggerARRAY[@]}"; do
	if [[ "$testModeOPTION" != "TRUE" ]]; then
		sendToLog "Status: Jamf Policy with Trigger \"$trigger\" is starting..."
		if [[ "$verboseModeOPTION" == "TRUE" ]]; then
			jamfRESULT=$("$jamfBINARY" policy -event "$trigger" -verbose 2>&1)
			jamfRETURN=$?
			sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfRESULT is:\n$jamfRESULT"
			sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfRETURN is: $jamfRETURN"
		else
			"$jamfBINARY" policy -event "$trigger" > /dev/null 2>&1
			jamfRETURN=$?
		fi
		if [ $jamfRETURN -ne 0 ]; then
			sendToLog "Error: Jamf Policy with Trigger \"$trigger\" failed!"; jamfERROR="TRUE"
		else
			sendToLog "Status: Jamf Policy with Trigger \"$trigger\" was successful."
		fi
	else
		sendToLog "Test Mode: Skipping Jamf Policy with Trigger: $trigger."
	fi
done
IFS="$oldIFS"
if [[ "$testModeOPTION" != "TRUE" ]]; then
	if [[ "$jamfERROR" != "TRUE" ]]; then
		sendToLog "Status: All Jamf Policies completed, deleting local policy triggers preference."
		defaults delete "$superPLIST" PolicyTriggers 2> /dev/null
	else
		sendToLog "Status: Some Jamf Policies failed, not deleting local policy triggers preference."
	fi
else
	sendToLog "Test Mode: Pausing $testModeTimeoutSECONDS seconds for the restart notification..."
	sleep "$testModeTimeoutSECONDS"
	kill -9 "$notifyPID" > /dev/null 2>&1
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		killall -9 "IBM Notifier" "IBM Notifier Popup" > /dev/null 2>&1
	else
		killall -9 "jamfHelper" > /dev/null 2>&1
	fi
fi
}

# MARK: *** Install & Restart Workflows ***
################################################################################

# Install only recommended (non-system) updates via the softwareupdate command, and also save results to $superLOG and $asuLOG.
installRecommendedSoftwareUpdates() {
sendToLog "softwareupdate: Starting recommended (non-system) software installation workflow, check $asuLOG for more detail."
sendToStatus "Running: softwareupdate: Starting recommended (non-system) software installation workflow."
sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL RECOMMENDED (NON-SYSTEM) UPDATES SOFTWAREUPDATE START ****"
oldIFS="$IFS"; IFS=$' '
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: recommendedSoftwareUpdateLABELS[] is:\n${recommendedSoftwareUpdateLABELS[*]}"

# The update process is backgrounded and is watched via a while loop later on. Also note the different requirements between macOS versions.
if [[ $macOSMAJOR -ge 12 ]]; then
	if [[ "$currentUserNAME" == "FALSE" ]]; then
		sudo -i softwareupdate --install "${recommendedSoftwareUpdateLABELS[@]}" --agree-to-license >> "$asuLOG" 2>&1 &
		softwareupdatePID=$!
	else # Local user is logged in.
		launchctl asuser "$currentUserUID" sudo -i softwareupdate --install "${recommendedSoftwareUpdateLABELS[@]}" --agree-to-license >> "$asuLOG" 2>&1 &
		softwareupdatePID=$!
	fi
elif [[ $macOSMAJOR -eq 11 ]]; then
	softwareupdate --install "${recommendedSoftwareUpdateLABELS[@]}" --agree-to-license >> "$asuLOG" 2>&1 &
	softwareupdatePID=$!
else # macOS 10.X
	softwareupdate --install "${recommendedSoftwareUpdateLABELS[@]}" >> "$asuLOG" 2>&1 &
	softwareupdatePID=$!
fi

# Watch $asuLOG while waiting for the softwareupdate installation workflow to complete.
# Note this while read loop has a timeout based on $initialStartTimeoutSECONDS then changes to $softwareUpdateRecommendedTimeoutSECONDS.
workflowStartTIMEOUT="TRUE"
workflowStartFAIL="TRUE"
workflowTIMEOUT="TRUE"
workflowTimeoutSECONDS=$initialStartTimeoutSECONDS
softwareUpdateInstalledTITLES=()
softwareUpdateERROR="TRUE"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
while read -t $workflowTimeoutSECONDS -r logLINE ; do
	# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
	if [[ $(echo "$logLINE" | grep -c "Can’t connect" ) -gt 0 ]] || [[ $(echo "$logLINE" | grep -c "Couldn't communicate" ) -gt 0 ]] || [[ $(echo "$logLINE" | grep -c 'No such update' ) -gt 0 ]]; then
		workflowStartTIMEOUT="FALSE"
		break
	elif [[ $(echo "$logLINE" | grep -c 'Downloading') -gt 0 ]]; then
		softwareUpdateDownloadTITLE=$(echo "$logLINE" | sed -e 's/://' | awk -F 'Downloading ' '{print $2}')
		sendToLog "softwareupdate: $softwareUpdateDownloadTITLE is downloading..."
		sendToASULog "**** TIMESTAMP ****"
		workflowTimeoutSECONDS=$softwareUpdateRecommendedTimeoutSECONDS
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
		workflowStartTIMEOUT="FALSE"
		workflowStartFAIL="FALSE"
	elif [[ $(echo "$logLINE" | grep -c 'Downloaded') -gt 0 ]]; then
		softwareUpdateDownloadTITLE=$(echo "$logLINE" | sed -e 's/://' | awk -F 'Downloaded ' '{print $2}')
		sendToLog "softwareupdate: $softwareUpdateDownloadTITLE download complete."
		workflowTimeoutSECONDS=$softwareUpdateRecommendedTimeoutSECONDS
		sendToASULog "**** TIMESTAMP ****"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
		workflowStartTIMEOUT="FALSE"
		workflowStartFAIL="FALSE"
	elif [[ $(echo "$logLINE" | grep -c 'Done with') -gt 0 ]]; then
		softwareUpdateInstalledTITLE=$(echo "$logLINE" | sed -e 's/://' | awk -F 'Done with ' '{print $2}')
		sendToLog "softwareupdate: $softwareUpdateInstalledTITLE installed."
		softwareUpdateInstalledTITLES+=("${softwareUpdateInstalledTITLE}")
		sendToASULog "**** TIMESTAMP ****"
		workflowStartTIMEOUT="FALSE"
		workflowStartFAIL="FALSE"
	elif [[ $(echo "$logLINE" | grep -c 'Done.') -gt 0 ]]; then
		sendToASULog "**** TIMESTAMP ****"
		workflowTIMEOUT="FALSE"
		break
	fi
done < <(tail -n1 -F "$asuLOG")

# If the softwareupdate installation workflow completed, then validate and collect information.
if [[ "$workflowStartTIMEOUT" == "FALSE" ]] && [[ "$workflowStartFAIL" == "FALSE" ]] && [[ "$workflowTIMEOUT" == "FALSE" ]]; then
	oldIFS="$IFS"; IFS=$'\n'
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: recommendedSoftwareUpdateTITLES[] is:\n${recommendedSoftwareUpdateTITLES[*]}"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateInstalledTITLES[] is:\n${softwareUpdateInstalledTITLES[*]}"
	if [[ ! $(echo -e "${recommendedSoftwareUpdateTITLES[*]}\n${softwareUpdateInstalledTITLES[*]}" | sort | uniq -u) ]]; then
		sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION RECOMMENDED (NON-SYSTEM) UPDATES SOFTWAREUPDATE COMPLETED ****"
		softwareUpdateERROR="FALSE"
	else # The expected $recommendedSoftwareUpdateTITLES[] did not match the $softwareUpdateInstalledTITLES[].
		sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION RECOMMENDED (NON-SYSTEM) UPDATES SOFTWAREUPDATE INCOMPLETE ****"
		sendToASULog "Error: Installation of recommended (non-system) software updates did not complete."
		sendToLog "Error: Installation of recommended (non-system) software updates did not complete."
	fi
else # The softwareupdate installation workflow failed.
	sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION RECOMMENDED (NON-SYSTEM) UPDATES SOFTWAREUPDATE FAILED ****"
	if [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
		sendToASULog "Error: Installation of recommended (non-system) software updates failed to start after $workflowTimeoutSECONDS seconds."
		sendToLog "Error: Installation of recommended (non-system) software updates failed to start after $workflowTimeoutSECONDS seconds."
	elif [[ "$workflowStartFAIL" == "TRUE" ]]; then
		sendToASULog "Error: Unable to reach Apple Software Update server."
		sendToLog "Error: Unable to reach Apple Software Update server."
	elif [[ "$workflowTIMEOUT" == "TRUE" ]]; then
		sendToASULog "Error: Installation of recommended (non-system) software updates timed out after $workflowTimeoutSECONDS seconds."
		sendToLog "Error: Installation of recommended (non-system) software updates timed out after $workflowTimeoutSECONDS seconds."
	fi
	kill -9 "$softwareupdatePID" > /dev/null 2>&1
	kickSoftwareUpdateD
fi
IFS="$oldIFS"
}

# Install macOS updates via the softwareupdate command, and also save results to $superLOG, $asuLOG, and $superPLIST.
installMacOSSoftwareUpdate() {
if [[ "$testModeOPTION" != "TRUE" ]]; then # Not in test mode.
	if [[ $macOSVERSION -ge 1203 ]] && [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; then # macOS 12.3 or newer upgrade via softwareupdate.
		softwareUpdateLabelTARGET="$macOSSoftwareUpgradeLabelTARGET"
		if [[ "$macOSSoftwareUpdateDownloadREQUIRED" == "TRUE" ]]; then # If no $currentUserNAME then the sytem update was not pre-downloaded.
			sendToLog "softwareupdate: Starting $macOSSoftwareUpgradeLabelTARGET download and upgrade workflow, check $asuLOG for more detail."
			sendToStatus "Running: softwareupdate: Starting $macOSSoftwareUpgradeLabelTARGET download and upgrade workflow."
			sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD AND UPGRADE $macOSSoftwareUpgradeLabelTARGET SOFTWAREUPDATE START ****"
		else
			sendToLog "softwareupdate: Starting $macOSSoftwareUpgradeLabelTARGET upgrade workflow, check $asuLOG for more detail."
			sendToStatus "Running: softwareupdate: Starting $macOSSoftwareUpgradeLabelTARGET upgrade workflow."
			sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION UPGRADE $macOSSoftwareUpgradeLabelTARGET SOFTWAREUPDATE START ****"
		fi
	else # Older than macOS 12 and/or only macOS updates available.
		softwareUpdateLabelTARGET="$macOSSoftwareUpdateLABEL"
		if [[ "$macOSSoftwareUpdateDownloadREQUIRED" == "TRUE" ]]; then # If no $currentUserNAME then the sytem update was not pre-downloaded.
			sendToLog "softwareupdate: Starting $macOSSoftwareUpdateLABEL download and update workflow, check $asuLOG for more detail."
			sendToStatus "Running: softwareupdate: Starting $macOSSoftwareUpdateLABEL download and update workflow."
			sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION DOWNLOAD AND UPDATE $macOSSoftwareUpdateLABEL SOFTWAREUPDATE START ****"
		else
			sendToLog "softwareupdate: Starting $macOSSoftwareUpdateLABEL update workflow, check $asuLOG for more detail."
			sendToStatus "Running: softwareupdate: Starting $macOSSoftwareUpdateLABEL update workflow."
			sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE $macOSSoftwareUpdateLABEL SOFTWAREUPDATE START ****"
		fi
	fi
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateLabelTARGET is: $softwareUpdateLabelTARGET"
	
	# The update/upgrade process is backgrounded and is watched via while loops later on. Also note the different requirements between macOS versions.
	if [[ $macOSMAJOR -ge 13 ]]; then  # macOS 13+
		if [[ "$currentUserNAME" == "FALSE" ]]; then # Local user not is logged in.
			if [[ "$macOSARCH" == "arm64" ]]; then # Apple Silicon.
				echo "$installPASSWORD" | sudo -u root softwareupdate --install "$softwareUpdateLabelTARGET" --restart --force --no-scan --agree-to-license --user "$installACCOUNT" --stdinpass >> "$asuLOG" 2>&1 &
				softwareupdatePID=$!
			else # Intel.
				sudo -u root softwareupdate --install "$softwareUpdateLabelTARGET" --restart --force --no-scan --agree-to-license >> "$asuLOG" 2>&1 &
				softwareupdatePID=$!
			fi
		else # Local user is logged in.
			if [[ "$macOSARCH" == "arm64" ]]; then # Apple Silicon.
				echo "$installPASSWORD" | launchctl asuser "$currentUserUID" sudo -u root softwareupdate --install "$softwareUpdateLabelTARGET" --restart --force --no-scan --agree-to-license --user "$installACCOUNT" --stdinpass >> "$asuLOG" 2>&1 &
				softwareupdatePID=$!
			else # Intel.
				launchctl asuser "$currentUserUID" sudo -u root softwareupdate --install "$softwareUpdateLabelTARGET" --restart --force --no-scan --agree-to-license >> "$asuLOG" 2>&1 &
				softwareupdatePID=$!
			fi
		fi
	elif [[ $macOSMAJOR -ge 12 ]]; then  # macOS 12
		if [[ "$currentUserNAME" == "FALSE" ]]; then # Local user not is logged in.
			if [[ "$macOSARCH" == "arm64" ]]; then # Apple Silicon.
				sudo -u root softwareupdate --install "$softwareUpdateLabelTARGET" --restart --force --no-scan --agree-to-license --user "$installACCOUNT" --stdinpass "$installPASSWORD" >> "$asuLOG" 2>&1 &
				softwareupdatePID=$!
			else # Intel.
				sudo -u root softwareupdate --install "$softwareUpdateLabelTARGET" --restart --force --no-scan --agree-to-license >> "$asuLOG" 2>&1 &
				softwareupdatePID=$!
			fi
		else # Local user is logged in.
			if [[ "$macOSARCH" == "arm64" ]]; then # Apple Silicon.
				launchctl asuser "$currentUserUID" sudo -u root softwareupdate --install "$softwareUpdateLabelTARGET" --restart --force --no-scan --agree-to-license --user "$installACCOUNT" --stdinpass "$installPASSWORD" >> "$asuLOG" 2>&1 &
				softwareupdatePID=$!
			else # Intel.
				launchctl asuser "$currentUserUID" sudo -u root softwareupdate --install "$softwareUpdateLabelTARGET" --restart --force --no-scan --agree-to-license >> "$asuLOG" 2>&1 &
				softwareupdatePID=$!
			fi
		fi
	elif [[ $macOSMAJOR -eq 11 ]]; then  # macOS 11
		if [[ "$macOSARCH" == "arm64" ]]; then # Apple Silicon.
			echo ' ' | softwareupdate --install "$softwareUpdateLabelTARGET" --restart --force --no-scan --agree-to-license >> "$asuLOG" 2>&1 &
			softwareupdatePID=$!
		else # Intel.
			softwareupdate --install "$softwareUpdateLabelTARGET" --restart --force --no-scan --agree-to-license >> "$asuLOG" 2>&1 &
			softwareupdatePID=$!
		fi
	else # macOS 10.x
		softwareupdate --install "$softwareUpdateLabelTARGET" --restart --force --no-scan >> "$asuLOG" 2>&1 &
		softwareupdatePID=$!
	fi
	disown -a
	workflowTIMEOUT="TRUE"
	
	# Watch $asuLOG while waiting for the softwareupdate installation workflow to complete.
	# Note this while read loop has a timeout based on $initialStartTimeoutSECONDS then changes to $softwareUpdateTimeoutSECONDS or $softwareUpdateLegacyTimeoutSECONDS.
	workflowStartTIMEOUT="TRUE"
	workflowStartFAIL="TRUE"
	workflowTIMEOUT="TRUE"
	workflowTimeoutSECONDS=$initialStartTimeoutSECONDS
	workflowPHASE=""
	workflowCompletePERCENT=0
	workflowPreviousCompletePERCENT=0
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
	while read -t $workflowTimeoutSECONDS -r logLINE ; do
		# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
		if [[ $(echo "$logLINE" | grep -c "Can’t connect" ) -gt 0 ]] || [[ $(echo "$logLINE" | grep -c "Couldn't communicate" ) -gt 0 ]] || [[ $(echo "$logLINE" | grep -c 'No such update' ) -gt 0 ]] || [[ $(echo "$logLINE" | grep -c 'Failed to download' ) -gt 0 ]]; then
			workflowStartTIMEOUT="FALSE"
			break
		elif [[ $macOSMAJOR -lt 11 ]] && [[ $(echo "$logLINE" | grep -c 'Finding available software') -gt 0 ]]; then
			sendToLog "softwareupdate: The download workflow has started but detailed progress is not available for systems older than macOS 11..."
			workflowTimeoutSECONDS=$softwareUpdateLegacyTimeoutSECONDS
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
			workflowStartFAIL="FALSE"
		elif [[ $macOSMAJOR -ge 11 ]] && [[ $(echo "$logLINE" | grep -c 'Downloading') -gt 0 ]] && [[ $(echo "$logLINE" | grep -c 'Downloading:') -eq 0 ]]; then
			softwareUpdateDownloadTITLE=$(echo "$logLINE" | sed -e 's/Downloading //')
			sendToLog "softwareupdate: $softwareUpdateDownloadTITLE is downloading..."
			sendToASULog "**** TIMESTAMP ****"
			workflowTimeoutSECONDS=$softwareUpdateTimeoutSECONDS
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
			workflowStartFAIL="FALSE"
			[[ $(echo "$softwareUpdateDownloadTITLE" | grep -c 'macOS') -gt 0 ]] && workflowPHASE="DOWNLOADING"
		elif [[ $macOSMAJOR -ge 11 ]] && [[ $(echo "$logLINE" | grep -c 'Downloading:') -gt 0 ]] && [[ "$workflowPHASE" == "DOWNLOADING" ]]; then
			workflowCompletePERCENT=$(echo "$logLINE" | sed -e 's/Downloading: //' -e 's/\.[0-9][0-9]//' | tr -d '\n' | tr -d '\r')
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowCompletePERCENT is: $workflowCompletePERCENT"
			if [[ $workflowCompletePERCENT -ge 60 ]]; then
				sendToEchoReplaceLine "$softwareUpdateDownloadTITLE download progress: 100%\n"
				sendToLog "softwareupdate: $softwareUpdateDownloadTITLE download complete, now preparing..."
				sendToASULog "**** TIMESTAMP ****"
				workflowPHASE="PREPARING"
			elif [[ $workflowCompletePERCENT -gt $workflowPreviousCompletePERCENT ]]; then
				workflowCompleteDISPLAY=$( (echo "$workflowCompletePERCENT * 1.69" | bc ) | cut -d '.' -f1)
				sendToEchoReplaceLine "$softwareUpdateDownloadTITLE download progress: $workflowCompleteDISPLAY%"
				workflowPreviousCompletePERCENT=$workflowCompletePERCENT
			fi
		elif [[ $macOSMAJOR -ge 11 ]] && [[ $(echo "$logLINE" | grep -c 'Downloading:') -gt 0 ]] && [[ "$workflowPHASE" == "PREPARING" ]]; then
			workflowCompletePERCENT=$(echo "$logLINE" | sed -e 's/Downloading: //' -e 's/\.[0-9][0-9]//' | tr -d '\n' | tr -d '\r')
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowCompletePERCENT is: $workflowCompletePERCENT"
			if [[ $workflowCompletePERCENT -ge 100 ]]; then
				sendToEchoReplaceLine "$softwareUpdateDownloadTITLE preparing progress: 100%\n"
				sendToASULog "**** TIMESTAMP ****"
				workflowStartTIMEOUT="FALSE"
				workflowStartFAIL="FALSE"
				workflowTIMEOUT="FALSE"
				break
			elif [[ $workflowCompletePERCENT -gt $workflowPreviousCompletePERCENT ]]; then
				workflowCompleteDISPLAY=$(((workflowCompletePERCENT-60)*2))
				sendToEchoReplaceLine "$softwareUpdateDownloadTITLE preparing progress: $workflowCompleteDISPLAY%"
				workflowPreviousCompletePERCENT=$workflowCompletePERCENT
			fi
		elif [[ $(echo "$logLINE" | grep -c 'Downloaded') -gt 0 ]]; then
			softwareUpdateDownloadTITLE=$(echo "$logLINE" | sed -e 's/://' -e 's/Downloaded //')
			sendToASULog "**** TIMESTAMP ****"
			workflowStartTIMEOUT="FALSE"
			workflowStartFAIL="FALSE"
			workflowTIMEOUT="FALSE"
			break
		fi
	done < <(tail -n1 -F "$asuLOG" | tr -u '%' '\n')

	# If the softwareupdate installation workflow completed, then prepare for restart.
	if [[ "$workflowStartTIMEOUT" == "FALSE" ]] && [[ "$workflowStartFAIL" == "FALSE" ]] && [[ "$workflowTIMEOUT" == "FALSE" ]]; then
		sendToLog "softwareupdate: macOS update/upgrade is prepared and ready for restart."
		sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE/UPGRADE MACOS SOFTWAREUPDATE COMPLETED ****"
		installRestartComplete
	else # The softwareupdate download workflow failed so clean-up and try again later.
		sendToASULog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE/UPGRADE MACOS SOFTWAREUPDATE FAILED ****"
		kill -9 "$softwareupdatePID" > /dev/null 2>&1
		kickSoftwareUpdateD
		if [[ "$installNowOPTION" == "TRUE" ]]; then
			if [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
				sendToASULog "Error: Installation of macOS update/upgrade failed to start after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
				sendToLog "Error: Installation of macOS update/upgrade failed to start after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
				sendToStatus "Inactive Error: Installation of macOS update/upgrade failed to start after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			elif [[ "$workflowStartFAIL" == "TRUE" ]]; then
				sendToASULog "Error: Unable to reach Apple Software Update server, install now workflow can not continue."
				sendToLog "Error: Unable to reach Apple Software Update server, install now workflow can not continue."
				sendToStatus "Inactive Error: Unable to reach Apple Software Update server, install now workflow can not continue."
			elif [[ "$workflowTIMEOUT" == "TRUE" ]]; then
				sendToASULog "Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
				sendToLog "Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
				sendToStatus "Inactive Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			fi
			notifyInstallNowFailure
			errorExit
		else
			deferSECONDS="$errorDeferSECONDS"
			if [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
				sendToASULog "Error: Installation of macOS update/upgrade failed to start after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
				sendToLog "Error: Installation of macOS update/upgrade failed to start after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
				sendToStatus "Pending: Installation of macOS update/upgrade failed to start after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			elif [[ "$workflowStartFAIL" == "TRUE" ]]; then
				sendToASULog "Error: Unable to reach Apple Software Update server, trying again in $deferSECONDS seconds."
				sendToLog "Error: Unable to reach Apple Software Update server, trying again in $deferSECONDS seconds."
				sendToStatus "Pending: Unable to reach Apple Software Update server, trying again in $deferSECONDS seconds."
			elif [[ "$workflowTIMEOUT" == "TRUE" ]]; then
				sendToASULog "Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
				sendToLog "Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
				sendToStatus "Pending: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			fi
			[[ "$currentUserNAME" != "FALSE" ]] && notifyFailure
			makeLaunchDaemonCalendar
		fi
	fi
else # Test Mode.
	sendToLog "Test Mode: Skipping the macOS softwareupdate workflow."
	if [[ "$currentUserNAME" != "FALSE" ]]; then
		sendToLog "Test Mode: Pausing $testModeTimeoutSECONDS seconds for the restart notification..."
		sleep "$testModeTimeoutSECONDS"
		kill -9 "$notifyPID" > /dev/null 2>&1
		if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
			killall -9 "IBM Notifier" "IBM Notifier Popup" > /dev/null 2>&1
		else
			killall -9 "jamfHelper" > /dev/null 2>&1
		fi
	fi
	# Reset various items after test macOS update is complete.
	restartZeroDay
	restartDeferralCounters
fi
}

# Install macOS update/upgrade via MDM push command, and also save results to $superLOG, $mdmCommandLOG, $mdmWorkflowLOG, and $superPLIST.
installMacOSMDM() {
if [[ "$testModeOPTION" != "TRUE" ]]; then # Not in test mode.
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeVersionTARGET is: $macOSUpgradeVersionTARGET"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSSoftwareUpdateDownloadREQUIRED is: $macOSSoftwareUpdateDownloadREQUIRED"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: userAuthMDMFAILOVER is: $userAuthMDMFAILOVER"
	if [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; then # macOS upgrade via installer, further the installer is always pre-downloaded.
		if [[ "$userAuthMDMFAILOVER" == "TRUE" ]]; then
			sendToLog "MDM: Starting $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET install workflow with user authenticated failover."
			sendToStatus "Running: MDM: Starting $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET install workflow with user authenticated failover."
		else
			sendToLog "MDM: Starting $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET install workflow."
			sendToStatus "Running: MDM: Starting $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET install workflow."
		fi
		sendToMDMCommandLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET MDM START ****"
		sendToMDMWorkflowLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET MDM START ****"
	else # macOS update.
		if [[ "$macOSSoftwareUpdateDownloadREQUIRED" == "TRUE" ]]; then
			if [[ "$userAuthMDMFAILOVER" == "TRUE" ]]; then
				sendToLog "MDM: Starting macOS $macOSSoftwareUpdateVERSION download and update workflow with user authenticated failover."
				sendToStatus "Running: MDM: Starting macOS $macOSSoftwareUpdateVERSION download and update workflow with user authenticated failover."
			else
				sendToLog "MDM: Starting macOS $macOSSoftwareUpdateVERSION download and update workflow."
				sendToStatus "Running: MDM: Starting macOS $macOSSoftwareUpdateVERSION download and update workflow."
			fi
			sendToMDMCommandLog "**** DOWNLOAD AND UPDATE S.U.P.E.R.M.A.N. MACOS $macOSSoftwareUpdateVERSION MDM START ****"
			sendToMDMWorkflowLog "**** DOWNLOAD AND UPDATE S.U.P.E.R.M.A.N. MACOS $macOSSoftwareUpdateVERSION MDM START ****"
		else
			if [[ "$userAuthMDMFAILOVER" == "TRUE" ]]; then
				sendToLog "MDM: Starting macOS $macOSSoftwareUpdateVERSION update workflow with user authenticated failover."
				sendToStatus "Running: MDM: Starting macOS $macOSSoftwareUpdateVERSION update workflow with user authenticated failover."
			else
				sendToLog "MDM: Starting macOS $macOSSoftwareUpdateVERSION update workflow."
				sendToStatus "Running: MDM: Starting macOS $macOSSoftwareUpdateVERSION update workflow."
			fi
			sendToMDMCommandLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE MACOS $macOSSoftwareUpdateVERSION MDM START ****"
			sendToMDMWorkflowLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE MACOS $macOSSoftwareUpdateVERSION MDM START ****"
		fi
	fi
	sendToLog "MDM: check $mdmCommandLOG and $mdmWorkflowLOG for more detail."
	
	# For macOS 11 or newer restarting the softwareupdate processes helps to prevent macOS updates from hanging.
	kickSoftwareUpdateD
	
	# This pre-flights the MDM query locally and may also be useful for troubleshooting.
	availableOSUPDATES=$(/usr/libexec/mdmclient AvailableOSUpdates 2> /dev/null)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: availableOSUPDATES is: $availableOSUPDATES"
	
	# Validate Jamf Pro API token.
	checkJamfProServerToken
	
	# Start log streaming for MDM push commands and send to $mdmCommandLOG.
	log stream --style compact --predicate 'subsystem == "com.apple.ManagedClient" AND category == "HTTPUtil"' >> "$mdmCommandLOG" &
	mdmCommandStreamPID=$!
	if [[ "$verboseModeOPTION" == "TRUE" ]]; then
		sendToLog "Verbose Mode: Starting debug log for MDM client command progress at: $mdmCommandDebugLOG"
		log stream --style compact --predicate 'subsystem == "com.apple.ManagedClient"' >> "$mdmCommandDebugLOG" &
		mdmCommandDebugPID=$!
	fi
	
	# Start log streaming for MDM update/upgrade progress and send to $mdmWorkflowLOG.
	log stream --style compact --predicate 'process == "softwareupdated" AND composedMessage CONTAINS "Reported progress"' >> "$mdmWorkflowLOG" &
	mdmWorkflowStreamPID=$!
	if [[ "$verboseModeOPTION" == "TRUE" ]]; then
		sendToLog "Verbose Mode: Starting debug log for MDM update/upgrade workflow progress at: $mdmWorkflowDebugLOG"
		log stream --style compact --predicate 'process == "softwareupdated"' >> "$mdmWorkflowDebugLOG" &
		mdmWorkflowDebugPID=$!
	fi
	
	# Send the Jamf Pro API command to update and restart via MDM.
	jamfAPIURL="${jamfSERVER}api/v1/macos-managed-software-updates/send-updates"
	if [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; then # macOS upgrade.
		mdmWorkflowTYPE="INSTALLER"
		if [[ "$betaWORKFLOW" != "FALSE" ]]; then
			jamfJSON='{ "deviceIds": ["'${jamfProID}'"], "applyMajorUpdate": true, "skipVersionVerification": true, "updateAction": "DOWNLOAD_AND_INSTALL" }'
		else # Standard non-beta workflow.
			jamfJSON='{ "deviceIds": ["'${jamfProID}'"], "applyMajorUpdate": true, "updateAction": "DOWNLOAD_AND_INSTALL" }'
		fi
	else # macOS update.
		mdmWorkflowTYPE="UPDATE"
		if [[ "$betaWORKFLOW" != "FALSE" ]] || [[ "$softwareUpdateRSR" == "TRUE" ]]; then
			jamfJSON='{ "deviceIds": ["'${jamfProID}'"], "applyMajorUpdate": false, "skipVersionVerification": true, "updateAction": "DOWNLOAD_AND_INSTALL", "forceRestart": true }'
		else # Standard non-beta workflow.
			jamfJSON='{ "deviceIds": ["'${jamfProID}'"], "applyMajorUpdate": false, "updateAction": "DOWNLOAD_AND_INSTALL", "forceRestart": true }'
		fi
	fi
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: mdmWorkflowTYPE is: $mdmWorkflowTYPE"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfAPIURL is: $jamfAPIURL"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfJSON is: $jamfJSON"
	commandRESULT=$(curl --header "Authorization: Bearer ${jamfProTOKEN}" --header "Content-Type: application/json" --write-out "%{http_code}" --silent --show-error --request POST --url "${jamfAPIURL}" --data "${jamfJSON}")
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: commandRESULT is:\n$commandRESULT"
	
	# If the Jamf Pro API command was successfully created, monitor the update progress.
	if [[ $(echo "$commandRESULT" | grep -c '200') -gt 0 ]] || [[ $(echo "$commandRESULT" | grep -c '201') -gt 0 ]]; then
		sendToLog "MDM: Successful macOS update/upgrade command request."
		sendBlankPush
		mdmTIMEOUT="TRUE"
		mdmFAIL="TRUE"
		
		# Some helpfull logging while waiting for Jamf Pro's mandatory 5 minute delay. Note this while read loop has a timeout based on $mdmTimeoutSECONDS.
		while read -t $mdmTimeoutSECONDS -r logLINE ; do
			# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
			if [[ $(echo "$logLINE" | grep -c 'Received HTTP response (200) \[Error') -gt 0 ]]; then
				sendToLog "MDM: Workflow error detected."
				sendToMDMCommandLog "**** TIMESTAMP ****"
				mdmTIMEOUT="FALSE"
				break
			elif [[ $(echo "$logLINE" | grep -c 'Received HTTP response (200) \[Acknowledged(ScheduleOSUpdateScan)') -gt 0 ]]; then
				sendToLog "MDM: Received push command \"ScheduleOSUpdateScan\", checking back after Jamf Pro's mandatory 5 minute delay..."
				sendToMDMCommandLog "**** TIMESTAMP ****"
				mdmTIMEOUT="FALSE"
				mdmFAIL="FALSE"
				pkill -P $$ tail
				break
			fi
		done < <(tail -n1 -F "$mdmCommandLOG")
		
		# Only continue workflow if it did not timeout or fail.
		if [[ "$mdmTIMEOUT" == "FALSE" ]] && [[ "$mdmFAIL" == "FALSE" ]]; then
			timerEND=300
			while [[ $timerEND -ge 0 ]]; do
				sendToEchoReplaceLine "Waiting for Jamf Pro's mandatory 5 minute delay: -$(date -u -r $timerEND +%M:%S)"
				timerEND=$((timerEND - 1))
				sleep 1
			done
			sendToEchoReplaceLine "Waiting for Jamf Pro's mandatory 5 minute delay: 00:00\n)"
			sendToLog "MDM: Jamf Pro's mandatory 5 minute delay should be complete, sending Blank Push..."
			sendBlankPush
			mdmTIMEOUT="TRUE"
			mdmFAIL="TRUE"
			if [[ "$currentUserNAME" != "FALSE" ]]; then
				if [[ "$mdmWorkflowTYPE" == "INSTALLER" ]]; then
					prepareTimeEstimateDISPLAY="20-25"
					notifyPrepare
				else
					notifyRestart
				fi
			fi
			
			# Watch $mdmCommandLOG while waiting for the MDM workflow to complete. Note this while read loop has a timeout based on $mdmTimeoutSECONDS.
			while read -t $mdmTimeoutSECONDS -r logLINE ; do
				# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
				if [[ $(echo "$logLINE" | grep -c 'Received HTTP response (200) \[Error') -gt 0 ]]; then
					sendToLog "MDM: Workflow error detected."
					sendToMDMCommandLog "**** TIMESTAMP ****"
					mdmTIMEOUT="FALSE"
					break
				elif [[ $(echo "$logLINE" | grep -c 'Received HTTP response (200) \[Idle\]') -gt 0 ]]; then
					sendToLog "MDM: Received blank push."
					sendToMDMCommandLog "**** TIMESTAMP ****"
				elif [[ $(echo "$logLINE" | grep -c 'Received HTTP response (200) \[Acknowledged(AvailableOSUpdates)') -gt 0 ]]; then
					sendToLog "MDM: Received push command \"AvailableOSUpdates\"."
					sendToMDMCommandLog "**** TIMESTAMP ****"
				elif [[ $(echo "$logLINE" | grep -c 'Received HTTP response (200) \[Acknowledged(ScheduleOSUpdate)') -gt 0 ]]; then
					kill -9 "$mdmCommandStreamPID" > /dev/null 2>&1
					[[ "$verboseModeOPTION" == "TRUE" ]] && kill -9 "$mdmCommandDebugPID" > /dev/null 2>&1
					sendToMDMCommandLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE/UPGRADE MACOS MDM PUSH COMPLETED ****"
					sendToLog "MDM: Received push command \"ScheduleOSUpdate\", local update/upgrade workflow should start soon..."
					mdmTIMEOUT="FALSE"
					mdmFAIL="FALSE"
					break
				fi
			done < <(tail -n1 -F "$mdmCommandLOG")
		fi
		
		# If the MDM push commands did not complete after $mdmTimeoutSECONDS seconds, then clean-up and try again later.
		if [[ "$mdmTIMEOUT" == "TRUE" ]] && [[ "$mdmFAIL" == "TRUE" ]]; then
			sendToMDMCommandLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE/UPGRADE MACOS MDM PUSH FAILED ****"
			kill -9 "$mdmCommandStreamPID" > /dev/null 2>&1
			[[ "$verboseModeOPTION" == "TRUE" ]] && kill -9 "$mdmCommandDebugPID" > /dev/null 2>&1
			sendToMDMWorkflowLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE/UPGRADE MACOS MDM PUSH FAILED ****"
			kill -9 "$mdmWorkflowStreamPID" > /dev/null 2>&1
			[[ "$verboseModeOPTION" == "TRUE" ]] && kill -9 "$mdmWorkflowDebugPID" > /dev/null 2>&1
			kickSoftwareUpdateD
			if [[ "$installNowOPTION" == "TRUE" ]]; then
				if [[ "$userAuthMDMFAILOVER" == "TRUE" ]]; then
					if [[ "$mdmTIMEOUT" == "TRUE" ]]; then
						sendToMDMCommandLog "Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, failing over to user authenticated workflow."
						sendToMDMWorkflowLog "Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, failing over to user authenticated workflow."
						sendToLog "Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, failing over to user authenticated workflow."
					elif [[ "$mdmFAIL" == "TRUE" ]]; then
						sendToMDMCommandLog "Error: Push workflow for macOS update/upgrade via MDM failed, failing over to user authenticated workflow"
						sendToMDMWorkflowLog "Error: Push workflow for macOS update/upgrade via MDM failed, failing over to user authenticated workflow"
						sendToLog "Error: Push workflow for macOS update/upgrade via MDM failed, failing over to user authenticated workflow"
					fi
					upgradeWORKFLOW="MDMFAIL"
					updateWORKFLOW="MDMFAIL"
					unset policyTRIGGERS
					installRestartWorkflowActiveUser
					return
				else # No user authentication MDM failover option.
					if [[ "$mdmTIMEOUT" == "TRUE" ]]; then
						sendToMDMCommandLog "Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, install now workflow can not continue."
						sendToMDMWorkflowLog "Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, install now workflow can not continue."
						sendToLog "Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, install now workflow can not continue."
						sendToStatus "Inactive Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, install now workflow can not continue."
					elif [[ "$mdmFAIL" == "TRUE" ]]; then
						sendToMDMCommandLog "Error: Push workflow for macOS update/upgrade via MDM failed, install now workflow can not continue."
						sendToMDMWorkflowLog "Error: Push workflow for macOS update/upgrade via MDM failed, install now workflow can not continue."
						sendToLog "Error: Push workflow for macOS update/upgrade via MDM failed, install now workflow can not continue."
						sendToStatus "Inactive Error: Push workflow for macOS update/upgrade via MDM failed, install now workflow can not continue."
					fi
					notifyInstallNowFailure
					errorExit
				fi
			else # Default super workflow.
				if [[ "$currentUserNAME" != "FALSE" ]] && [[ "$userAuthMDMFAILOVER" == "TRUE" ]]; then
					if [[ "$mdmTIMEOUT" == "TRUE" ]]; then
						sendToMDMCommandLog "Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, failing over to user authenticated workflow."
						sendToMDMWorkflowLog "Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, failing over to user authenticated workflow."
						sendToLog "Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, failing over to user authenticated workflow."
					elif [[ "$mdmFAIL" == "TRUE" ]]; then
						sendToMDMCommandLog "Error: Push workflow for macOS update/upgrade via MDM failed, failing over to user authenticated workflow."
						sendToMDMWorkflowLog "Error: Push workflow for macOS update/upgrade via MDM failed, failing over to user authenticated workflow."
						sendToLog "Error: Push workflow for macOS update/upgrade via MDM failed, failing over to user authenticated workflow."
					fi
					upgradeWORKFLOW="MDMFAIL"
					updateWORKFLOW="MDMFAIL"
					unset policyTRIGGERS
					installRestartWorkflowActiveUser
					return
				else # No user authentication MDM failover option.
					deferSECONDS="$errorDeferSECONDS"
					if [[ "$mdmTIMEOUT" == "TRUE" ]]; then
						sendToMDMCommandLog "Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
						sendToMDMWorkflowLog "Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
						sendToLog "Error: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
						sendToStatus "Pending: Push workflow for macOS update/upgrade via MDM timed out after $mdmTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
					elif [[ "$mdmFAIL" == "TRUE" ]]; then
						sendToMDMCommandLog "Error: Push workflow for macOS update/upgrade via MDM failed, trying again in $deferSECONDS seconds."
						sendToMDMWorkflowLog "Error: Push workflow for macOS update/upgrade via MDM failed, trying again in $deferSECONDS seconds."
						sendToLog "Error: Push workflow for macOS update/upgrade via MDM failed, trying again in $deferSECONDS seconds."
						sendToStatus "Pending: Push workflow for macOS update/upgrade via MDM failed, trying again in $deferSECONDS seconds."
					fi
					[[ "$currentUserNAME" != "FALSE" ]] && notifyFailure
					makeLaunchDaemonCalendar
				fi
			fi
		fi
		
		# Watch $mdmWorkflowLOG while waiting for the update/upgrade workflow to complete.
		# Note this while read loop has a timeout based on $mdmTimeoutSECONDS then may change to $mdmWorkflowTimeoutSECONDS.
		workflowTIMEOUT="TRUE"
		workflowTimeoutSECONDS=$mdmTimeoutSECONDS
		workflowPHASE=""
		workflowCompletePERCENT=0
		workflowPreviousCompletePERCENT=0
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: mdmWorkflowTYPE is: $mdmWorkflowTYPE"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
		if [[ "$mdmWorkflowTYPE" == "UPGRADE" ]] || [[ "$mdmWorkflowTYPE" == "UPDATE" ]]; then
			while read -t $workflowTimeoutSECONDS -r logLINE ; do
				# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
				if [[ $(echo "$logLINE" | grep -c 'phase:PREFLIGHT') -gt 0 ]]; then
					if [[ "$workflowPHASE" != "PREFLIGHT" ]] && [[ "$workflowPHASE" != "DOWNLOADING" ]] && [[ "$workflowPHASE" != "PREPARING" ]]; then
						[[ "$mdmWorkflowTYPE" == "UPGRADE" ]] && sendToLog "MDM: $macOSSoftwareUpgradeLabelTARGET upgrade preflight..."
						[[ "$mdmWorkflowTYPE" == "UPDATE" ]] && sendToLog "MDM: $macOSSoftwareUpdateLABEL update preflight..."
						sendToMDMWorkflowLog "**** TIMESTAMP ****"
						workflowTimeoutSECONDS=$mdmWorkflowTimeoutSECONDS
						[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
						workflowPHASE="PREFLIGHT"
					fi
				elif [[ $(echo "$logLINE" | grep -c 'phase:DOWNLOADING_UPDATE') -gt 0 ]]; then
					if [[ "$workflowPHASE" != "DOWNLOADING" ]]; then
						[[ "$mdmWorkflowTYPE" == "UPGRADE" ]] && sendToLog "MDM: $macOSSoftwareUpgradeLabelTARGET upgrade is downloading..."
						[[ "$mdmWorkflowTYPE" == "UPDATE" ]] && sendToLog "MDM: $macOSSoftwareUpdateLABEL update is downloading..."
						sendToMDMWorkflowLog "**** TIMESTAMP ****"
						workflowTimeoutSECONDS=$mdmWorkflowTimeoutSECONDS
						[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
						workflowPHASE="DOWNLOADING"
					fi
					workflowCompletePERCENT=$(echo "$logLINE" | awk '{print $17}' | sed -e 's/portionComplete:0.//' | cut -c 1-2)
					[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowCompletePERCENT is: $workflowCompletePERCENT"
					if [[ $workflowCompletePERCENT -ge 60 ]]; then
						[[ "$mdmWorkflowTYPE" == "UPGRADE" ]] && sendToEchoReplaceLine "$macOSSoftwareUpgradeLabelTARGET upgrade download progress: 100%\n"
						[[ "$mdmWorkflowTYPE" == "UPDATE" ]] && sendToEchoReplaceLine "$macOSSoftwareUpdateLABEL update download progress: 100%\n"
					elif [[ $workflowCompletePERCENT -gt $workflowPreviousCompletePERCENT ]]; then
						workflowCompleteDISPLAY=$( (echo "$workflowCompletePERCENT * 1.69" | bc ) | cut -d '.' -f1)
						[[ "$mdmWorkflowTYPE" == "UPGRADE" ]] && sendToEchoReplaceLine "$macOSSoftwareUpgradeLabelTARGET upgrade download progress: $workflowCompleteDISPLAY%"
						[[ "$mdmWorkflowTYPE" == "UPDATE" ]] && sendToEchoReplaceLine "$macOSSoftwareUpdateLABEL update download progress: $workflowCompleteDISPLAY%"
						workflowPreviousCompletePERCENT=$workflowCompletePERCENT
					fi
				elif [[ $(echo "$logLINE" | grep -c 'phase:PREPARING_UPDATE') -gt 0 ]]; then
					if [[ "$workflowPHASE" != "PREPARING" ]]; then
						[[ "$mdmWorkflowTYPE" == "UPGRADE" ]] && sendToLog "MDM: $macOSSoftwareUpgradeLabelTARGET upgrade download complete, now preparing..."
						[[ "$mdmWorkflowTYPE" == "UPDATE" ]] && sendToLog "MDM: $macOSSoftwareUpdateLABEL update download complete, now preparing..."
						sendToMDMWorkflowLog "**** TIMESTAMP ****"
						workflowTimeoutSECONDS=$mdmWorkflowTimeoutSECONDS
						[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
						workflowPHASE="PREPARING"
					fi
					workflowCompletePERCENT=$(echo "$logLINE" | awk '{print $17}' | sed -e 's/portionComplete:0.//' | cut -c 1-2)
					[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowCompletePERCENT is: $workflowCompletePERCENT"
					if [[ $workflowCompletePERCENT -ge 98 ]]; then
						[[ "$mdmWorkflowTYPE" == "UPGRADE" ]] && sendToEchoReplaceLine "$macOSSoftwareUpgradeLabelTARGET upgrade preparing progress: 100%\n"
						[[ "$mdmWorkflowTYPE" == "UPGRADE" ]] && sendToLog "MDM: $macOSSoftwareUpgradeLabelTARGET upgrade is downloaded and prepared, system restart is soon..."
						[[ "$mdmWorkflowTYPE" == "UPDATE" ]] && sendToEchoReplaceLine "$macOSSoftwareUpdateLABEL update preparing progress: 100%\n"
						[[ "$mdmWorkflowTYPE" == "UPDATE" ]] && sendToLog "MDM: $macOSSoftwareUpdateLABEL update is downloaded and prepared, system restart is soon..."
						sendToMDMWorkflowLog "**** TIMESTAMP ****"
					elif [[ $workflowCompletePERCENT -gt $workflowPreviousCompletePERCENT ]]; then
						workflowCompleteDISPLAY=$(((workflowCompletePERCENT-60)*2))
						[[ "$mdmWorkflowTYPE" == "UPGRADE" ]] && sendToEchoReplaceLine "$macOSSoftwareUpgradeLabelTARGET upgrade preparing progress: $workflowCompleteDISPLAY%"
						[[ "$mdmWorkflowTYPE" == "UPDATE" ]] && sendToEchoReplaceLine "$macOSSoftwareUpdateLABEL update preparing progress: $workflowCompleteDISPLAY%"
						workflowPreviousCompletePERCENT=$workflowCompletePERCENT
					fi
				elif [[ $(echo "$logLINE" | grep -c 'phase:PREPARED_COMMITTING_STASH') -gt 0 ]]; then
					sendToMDMWorkflowLog "**** TIMESTAMP ****"
					workflowTIMEOUT="FALSE"
					workflowPHASE="DONE"
					break
				fi
			done < <(tail -n1 -F "$mdmWorkflowLOG")
		else # $mdmWorkflowTYPE == "INSTALLER"
			# This while loop is broken into sections to allow for the notifyPrepare function to update. Putting this function inside the while loop breaks the tail.
			while read -t $workflowTimeoutSECONDS -r logLINE ; do
				# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
				if [[ $(echo "$logLINE" | grep -c 'phase:PREFLIGHT') -gt 0 ]]; then
					sendToLog "MDM: $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET installer preflight..."
					sendToMDMWorkflowLog "**** TIMESTAMP ****"
					workflowTimeoutSECONDS=$mdmWorkflowTimeoutSECONDS
					[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
					workflowTIMEOUT="FALSE"
					workflowPHASE="PREFLIGHT"
					break
				fi
			done < <(tail -n1 -F "$mdmWorkflowLOG")
			if [[ "$workflowTIMEOUT" == "FALSE" ]]; then
			workflowTIMEOUT="TRUE"
				while read -t $workflowTimeoutSECONDS -r logLINE ; do
					# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
					if [[ $(echo "$logLINE" | grep -c 'phase:DOWNLOADING_SFR') -gt 0 ]]; then
						sendToLog "MDM: $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET downloading additional items..."
						sendToMDMWorkflowLog "**** TIMESTAMP ****"
						workflowPHASE="DOWNLOADING"
					elif [[ $(echo "$logLINE" | grep -c 'phase:PREPARING_UPDATE') -gt 0 ]]; then
						sendToLog "MDM: $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET installer preparing..."
						sendToMDMWorkflowLog "**** TIMESTAMP ****"
						workflowTIMEOUT="FALSE"
						workflowPHASE="PREPARING"
						break
					fi
				done < <(tail -n1 -F "$mdmWorkflowLOG")
			fi
			if [[ "$workflowTIMEOUT" == "FALSE" ]] && [[ "$currentUserNAME" != "FALSE" ]]; then
				prepareTimeEstimateDISPLAY="10-15"
				notifyPrepare
			fi
			if [[ "$workflowTIMEOUT" == "FALSE" ]]; then
			workflowTIMEOUT="TRUE"
				while read -t $workflowTimeoutSECONDS -r logLINE ; do
					# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
					if [[ $(echo "$logLINE" | grep -c 'phase:PREPARED') -gt 0 ]]; then
						sendToLog "MDM: $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET installer is prepared, system restart is soon..."
						sendToMDMWorkflowLog "**** TIMESTAMP ****"
						workflowTIMEOUT="FALSE"
						workflowPHASE="DONE"
						break
					fi
				done < <(tail -n1 -F "$mdmWorkflowLOG")
			fi
			{ [[ "$workflowTIMEOUT" == "FALSE" ]] && [[ "$currentUserNAME" != "FALSE" ]]; } && notifyRestart 
			if [[ "$workflowTIMEOUT" == "FALSE" ]]; then
			workflowTIMEOUT="TRUE"
				while read -t $workflowTimeoutSECONDS -r logLINE ; do
					# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
					if [[ $(echo "$logLINE" | grep -c 'phase:ACCEPTED') -gt 0 ]] || [[ $(echo "$logLINE" | grep -c 'phase:APPLYING') -gt 0 ]] || [[ $(echo "$logLINE" | grep -c 'phase:APPLYING') -gt 0 ]]; then
						sendToMDMWorkflowLog "**** TIMESTAMP ****"
						workflowTIMEOUT="FALSE"
						workflowPHASE="DONE"
						break
					fi
				done < <(tail -n1 -F "$mdmWorkflowLOG")
			fi
		fi
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTIMEOUT is: $workflowTIMEOUT"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowPHASE is: $workflowPHASE"
		
		# If the macOS update/upgrade completed, then prepare for restart.
		if [[ "$workflowTIMEOUT" == "FALSE" ]]; then
			[[ "$mdmWorkflowTYPE" == "UPGRADE" ]] && sendToLog "MDM: $macOSSoftwareUpgradeLabelTARGET upgrade is prepared and ready for restart."
			[[ "$mdmWorkflowTYPE" == "UPDATE" ]] && sendToLog "MDM: $macOSSoftwareUpdateLABEL update is prepared and ready for restart."
			[[ "$mdmWorkflowTYPE" == "INSTALLER" ]] && sendToLog "MDM: $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET installer is prepared and ready for restart."
			if [[ "$mdmWorkflowTYPE" == "INSTALLER" ]] && [[ "$currentUserNAME" != "FALSE" ]]; then
				sendToLog "MDM: Forcing logout for user \"$currentUserNAME\" with UID $currentUserUID."
				launchctl bootout "user/$currentUserUID" &
				disown %
			fi
			kill -9 "$mdmWorkflowStreamPID" > /dev/null 2>&1
			[[ "$verboseModeOPTION" == "TRUE" ]] && kill -9 "$mdmWorkflowDebugPID" > /dev/null 2>&1
			sendToMDMWorkflowLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE/UPGRADE MACOS MDM COMPLETED ****"
			installRestartComplete
		else # The macOS update/upgrade workflow timed out so clean-up and try again later.
			kill -9 "$mdmWorkflowStreamPID" > /dev/null 2>&1
			[[ "$verboseModeOPTION" == "TRUE" ]] && kill -9 "$mdmWorkflowDebugPID" > /dev/null 2>&1
			sendToMDMWorkflowLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE/UPGRADE MACOS MDM FAILED ****"
			kickSoftwareUpdateD
			if [[ "$installNowOPTION" == "TRUE" ]]; then
				if [[ "$userAuthMDMFAILOVER" == "TRUE" ]]; then
					sendToMDMWorkflowLog "Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, failing over to user authenticated workflow."
					sendToLog "Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, failing over to user authenticated workflow."
					upgradeWORKFLOW="MDMFAIL"
					updateWORKFLOW="MDMFAIL"
					unset policyTRIGGERS
					installRestartWorkflowActiveUser
					return
				else # No user authentication MDM failover option.
					sendToMDMWorkflowLog "Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
					sendToLog "Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
					sendToStatus "Inactive Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
					notifyInstallNowFailure
					errorExit
				fi
			else # Default super workflow.
				if [[ "$currentUserNAME" != "FALSE" ]] && [[ "$userAuthMDMFAILOVER" == "TRUE" ]]; then
					sendToMDMWorkflowLog "Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, failing over to user authenticated workflow."
					sendToLog "Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, failing over to user authenticated workflow."
					upgradeWORKFLOW="MDMFAIL"
					updateWORKFLOW="MDMFAIL"
					unset policyTRIGGERS
					installRestartWorkflowActiveUser
					return
				else # No user authentication MDM failover option.
					deferSECONDS="$errorDeferSECONDS"
					sendToMDMWorkflowLog "Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
					sendToLog "Error: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
					sendToStatus "Pending: Installation of macOS update/upgrade timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
					[[ "$currentUserNAME" != "FALSE" ]] && notifyFailure
					makeLaunchDaemonCalendar
				fi
			fi
		fi
	else # The MDM push workflow failed so clean-up and try again later.
		kill -9 "$mdmCommandStreamPID" > /dev/null 2>&1
		[[ "$verboseModeOPTION" == "TRUE" ]] && kill -9 "$mdmCommandDebugPID" > /dev/null 2>&1
		sendToMDMCommandLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE/UPGRADE MACOS MDM PUSH FAILED ****"
		sendToMDMCommandLog "Error: Failed to send MDM install update/upgrade request. Verify that the Jamf Pro API account \"$jamfACCOUNT\" has the privileges \"Jamf Pro Server Objects > Computers > Create & Read\" and \"Jamf Pro Server Actions > Send Computer Remote Command to Download and Install macOS Update\"."
		kill -9 "$mdmWorkflowStreamPID" > /dev/null 2>&1
		[[ "$verboseModeOPTION" == "TRUE" ]] && kill -9 "$mdmWorkflowDebugPID" > /dev/null 2>&1
		sendToMDMWorkflowLog "Error: Failed to send MDM install update/upgrade request. Verify that the Jamf Pro API account \"$jamfACCOUNT\" has the privileges \"Jamf Pro Server Objects > Computers > Create & Read\" and \"Jamf Pro Server Actions > Send Computer Remote Command to Download and Install macOS Update\"."
		sendToMDMWorkflowLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE/UPGRADE MACOS MDM PUSH FAILED ****"
		sendToLog "Error: Failed to send MDM install update/upgrade request. Verify that the Jamf Pro API account \"$jamfACCOUNT\" has the privileges \"Jamf Pro Server Objects > Computers > Create & Read\" and \"Jamf Pro Server Actions > Send Computer Remote Command to Download and Install macOS Update\"."
		kickSoftwareUpdateD
		if [[ "$installNowOPTION" == "TRUE" ]]; then
			if [[ "$userAuthMDMFAILOVER" == "TRUE" ]]; then
				sendToMDMCommandLog "Error: Push workflow for macOS update/upgrade via MDM failed, failing over to user authenticated workflow."
				sendToLog "Error: Push workflow for macOS update/upgrade via MDM failed, failing over to user authenticated workflow."
				upgradeWORKFLOW="MDMFAIL"
				updateWORKFLOW="MDMFAIL"
				unset policyTRIGGERS
				installRestartWorkflowActiveUser
				return
			else # No user authentication MDM failover option.
				sendToLog "Error: Push workflow for macOS update/upgrade via MDM failed, install now workflow can not continue."
				sendToStatus "Inactive Error: Push workflow for macOS update/upgrade via MDM failed, install now workflow can not continue."
				notifyInstallNowFailure
				errorExit
			fi
		else # Default super workflow.
			if [[ "$currentUserNAME" != "FALSE" ]] && [[ "$userAuthMDMFAILOVER" == "TRUE" ]]; then
				sendToMDMCommandLog "Error: Push workflow for macOS update/upgrade via MDM failed, failing over to user authenticated workflow."
				sendToLog "Error: Push workflow for macOS update/upgrade via MDM failed, failing over to user authenticated workflow."
				upgradeWORKFLOW="MDMFAIL"
				updateWORKFLOW="MDMFAIL"
				unset policyTRIGGERS
				installRestartWorkflowActiveUser
				return
			else
				deferSECONDS="$errorDeferSECONDS"
				sendToLog "Error: Push workflow for macOS update/upgrade via MDM failed, trying again in $deferSECONDS seconds."
				sendToStatus "Pending: Push workflow for macOS update/upgrade via MDM failed, trying again in $deferSECONDS seconds."
				[[ "$currentUserNAME" != "FALSE" ]] && notifyFailure
				makeLaunchDaemonCalendar
			fi
		fi
	fi
else # Test mode.
	sendToLog "Test Mode: Skipping the macOS MDM update/upgrade workflow."
	if [[ "$currentUserNAME" != "FALSE" ]]; then
		sendToLog "Test Mode: Pausing $testModeTimeoutSECONDS seconds for the MDM preparation notification..."
		sleep "$testModeTimeoutSECONDS"
		notifyRestart
		sendToLog "Test Mode: Pausing $testModeTimeoutSECONDS seconds for the restart notification..."
		sleep "$testModeTimeoutSECONDS"
		kill -9 "$notifyPID" > /dev/null 2>&1
		if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
			killall -9 "IBM Notifier" "IBM Notifier Popup" > /dev/null 2>&1
		else
			killall -9 "jamfHelper" > /dev/null 2>&1
		fi
	fi
	# Reset various items after test macOS update is complete.
	restartZeroDay
	restartDeferralCounters
fi
}

# Install macOS update/upgrade via macOS installer application, and also save results to $superLOG, $installerLOG, and $superPLIST.
installMacOSAPP() {
sendToLog "startosinstall: Starting $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET install upgrade workflow, check $installerLOG for more detail."
sendToStatus "Running: Starting $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET install upgrade workflow."
sendToInstallerLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET START ****"

# Background the startosinstall process and send to $installerLOG.
if [[ "$macOSARCH" == "arm64" ]]; then # Apple Silicon.
	"/Applications/Install $macOSInstallerNameTARGET.app/Contents/Resources/startosinstall" --agreetolicense --forcequitapps --user "$installACCOUNT" --stdinpass <<< "$installPASSWORD" >> "$installerLOG" 2>&1 &
else # Intel.
	"/Applications/Install $macOSInstallerNameTARGET.app/Contents/Resources/startosinstall" --agreetolicense --forcequitapps >> "$installerLOG" 2>&1 &
fi
startosinstallPID=$!

# Watch $installerLOG while waiting for the startosinstall process to complete.
# Note this while read loop has a timeout based on $initialStartTimeoutSECONDS then changes to $macOSInstallerTimeoutSECONDS.
workflowStartTIMEOUT="TRUE"
workflowStartFAIL="TRUE"
workflowTIMEOUT="TRUE"
workflowTimeoutSECONDS=$initialStartTimeoutSECONDS
workflowPHASE=""
workflowCompletePERCENT=0
workflowPreviousCompletePERCENT=0
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
while read -t $workflowTimeoutSECONDS -r logLINE ; do
	# sendToLog "Debug Mode: Function ${FUNCNAME[0]}: logLINE is:\n$logLINE"
	if [[ $(echo "$logLINE" | grep -c 'Preparing to run') -gt 0 ]]; then
		sendToLog "startosinstall: $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET preparing installation..."
		sendToInstallerLog "**** TIMESTAMP ****"
		workflowPHASE="PREPARING"
		workflowTimeoutSECONDS=$macOSInstallerTimeoutSECONDS
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowTimeoutSECONDS is: $workflowTimeoutSECONDS"
		workflowStartTIMEOUT="FALSE"
		workflowStartFAIL="FALSE"
	elif [[ $(echo "$logLINE" | grep -c 'Preparing:') -gt 0 ]] && [[ "$workflowPHASE" == "PREPARING" ]]; then
		workflowCompletePERCENT=$(echo "$logLINE" | sed -e 's/Preparing: //' -e 's/\.[0-9]//' | tr -d '\n' | tr -d '\r')
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: workflowCompletePERCENT is: $workflowCompletePERCENT"
		if [[ $workflowCompletePERCENT -ge 99 ]]; then
			sendToInstallerLog "**** TIMESTAMP ****"
			sendToEchoReplaceLine "$macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET installation preparing progress: 100%\n"
			workflowTIMEOUT="FALSE"
			break
		elif [[ $workflowCompletePERCENT -gt $workflowPreviousCompletePERCENT ]]; then
			sendToEchoReplaceLine "$macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET installation preparing progress: $workflowCompletePERCENT%"
			workflowPreviousCompletePERCENT=$workflowCompletePERCENT
		fi
	elif [[ $(echo "$logLINE" | grep -c -e 'Preparing: 99' -e 'Preparing: 100' -e 'Restarting') -gt 0 ]]; then
		sendToInstallerLog "**** TIMESTAMP ****"
		sendToEchoReplaceLine "$macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET installation preparing progress: 100%\n"
		workflowTIMEOUT="FALSE"
		break
	fi
done < <(tail -n1 -F "$installerLOG" | tr -u '%' '\n')

# If the startosinstall workflow completed, then prepare for restart.
if [[ "$workflowStartTIMEOUT" == "FALSE" ]] && [[ "$workflowStartFAIL" == "FALSE" ]] && [[ "$workflowTIMEOUT" == "FALSE" ]]; then
	sendToInstallerLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL MACOS COMPLETED ****"
	sendToLog "Status: $macOSInstallerNameTARGET $macOSInstallerVersionTARGET-$macOSInstallerBuildTARGET is prepared and ready for restart."
	[[ "$currentUserNAME" != "FALSE" ]] && notifyRestart
	installRestartComplete
else
	sendToInstallerLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL MACOS FAILED ****"
	kill -9 "$startosinstallPID" > /dev/null 2>&1
	if [[ "$installNowOPTION" == "TRUE" ]]; then
		if [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer failed to start after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			sendToLog "Error: macOS installer failed to start after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			sendToStatus "Inactive Error: macOS installer failed to start after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
		elif [[ "$workflowStartFAIL" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer failed, install now workflow can not continue."
			sendToLog "Error: macOS installer failed, install now workflow can not continue."
			sendToStatus "Inactive Error: macOS installer failed, install now workflow can not continue."
		elif [[ "$workflowTIMEOUT" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			sendToLog "Error: macOS installer timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
			sendToStatus "Inactive Error: macOS installer timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
		fi
		notifyInstallNowFailure
		errorExit
	else
		deferSECONDS="$errorDeferSECONDS"
		if [[ "$workflowStartTIMEOUT" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer failed to start after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			sendToLog "Error: macOS installer failed to start after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: macOS installer failed to start after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
		elif [[ "$workflowStartFAIL" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer failed, trying again in $deferSECONDS seconds."
			sendToLog "Error: macOS installer failed, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: macOS installer failed, trying again in $deferSECONDS seconds."
		elif [[ "$workflowTIMEOUT" == "TRUE" ]]; then
			sendToInstallerLog "Error: macOS installer timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			sendToLog "Error: macOS installer timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: macOS installer timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
		fi
		[[ "$currentUserNAME" != "FALSE" ]] && notifyFailure
		makeLaunchDaemonCalendar
	fi
fi
}

# This is the install workflow for all (non-system) updates when enforced.
installRecommendedWorkflow() {
[[ "$currentUserNAME" != "FALSE" ]] && notifyRecommended
if [[ "$testModeOPTION" != "TRUE" ]]; then
	installRecommendedSoftwareUpdates
	
	# Double-check to make sure all updates are complete.
	fullCheckREQUIRED="TRUE"
	checkSoftwareUpdates
	checkMacOSUpgrades
	checkMacOSDownloads
	
	# If we had failures, then try again.
	if [[ "$softwareUpdateERROR" == "TRUE" ]]; then
		sendToLog "Warning: Failed to install all recommended (non-system) updates."
		[[ "$softwareUpdateRECOMMENDED" == "TRUE" ]] && installRecommendedSoftwareUpdates
		# If it failed twice, then try again later.
		if [[ "$softwareUpdateERROR" == "TRUE" ]]; then
			if [[ "$installNowOPTION" == "TRUE" ]]; then
				sendToLog "Error: Failed to install all recommended (non-system) updates after multiple attempts, install now workflow can not continue."
				sendToStatus "Inactive Error: Failed to install all recommended (non-system) updates after multiple attempts, install now workflow can not continue."
				notifyInstallNowFailure
				errorExit
			else
				deferSECONDS="$errorDeferSECONDS"
				sendToLog "Warning: Failed to install all recommended (non-system) updates after multiple attempts, trying again in $deferSECONDS seconds."
				sendToStatus "Pending: Failed to install all recommended (non-system) updates after multiple attempts, trying again in $deferSECONDS seconds."
				makeLaunchDaemonCalendar
			fi
		else
			fullCheckREQUIRED="TRUE"
			checkSoftwareUpdates
			checkMacOSUpgrades
			checkMacOSDownloads
		fi
	fi
	
	# Log status of recommended update completion.
	if [[ "$softwareUpdateRECOMMENDED" == "FALSE" ]]; then
		sendToLog "Status: Completed installation of all recommended (non-system) updates."
		kill -9 "$notifyPID" > /dev/null 2>&1
		if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
			killall -9 "IBM Notifier" "IBM Notifier Popup" > /dev/null 2>&1
		else
			killall -9 "jamfHelper" > /dev/null 2>&1
		fi
		# For computers managed via Jamf Pro, submit inventory.
		if [[ "$jamfVERSION" != "FALSE" ]]; then
			if [[ "$jamfSERVER" != "FALSE" ]]; then
				sendToLog "Status: Submitting updated inventory to Jamf Pro. Use --verbose-mode or check /var/log/jamf.log for more detail..."
				if [[ "$verboseModeOPTION" == "TRUE" ]]; then
					jamfRESULT=$("$jamfBINARY" recon -verbose 2>&1)
					jamfRETURN=$?
					sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfRESULT is:\n$jamfRESULT"
					sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfRETURN is: $jamfRETURN"
				else
					"$jamfBINARY" recon > /dev/null 2>&1
				fi
			else
				if [[ "$installNowOPTION" == "TRUE" ]]; then
					sendToLog "Error: Unable to submit inventory to Jamf Pro, install now workflow can not continue."
					sendToStatus "Inactive Error: Unable to submit inventory to Jamf Pro, install now workflow can not continue."
					notifyInstallNowFailure
					errorExit
				else
					deferSECONDS="$errorDeferSECONDS"
					sendToLog "Error: Unable to submit inventory to Jamf Pro, trying again in $deferSECONDS seconds."
					sendToStatus "Pending: Unable to submit inventory to Jamf Pro, trying again in $deferSECONDS seconds."
					makeLaunchDaemonCalendar
				fi
			fi
		fi
	else # Some software updates did not complete
		if [[ "$installNowOPTION" == "TRUE" ]]; then
			sendToLog "Error: Some recommended (non-system) updates did not complete, install now workflow can not continue."
			sendToStatus "Inactive Error: Some recommended (non-system) updates did not complete, install now workflow can not continue."
			notifyInstallNowFailure
			errorExit
		else
			deferSECONDS="$errorDeferSECONDS"
			sendToLog "Warning: Some recommended (non-system) updates did not complete, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Some recommended (non-system) updates did not complete, trying again in $deferSECONDS seconds."
			makeLaunchDaemonCalendar
		fi
	fi
else # Test mode.
	sendToLog "Test Mode: Skipping the install recommended updates workflow."
	sendToLog "Test Mode: Pausing $testModeTimeoutSECONDS seconds for the recommended update notification..."
	sleep "$testModeTimeoutSECONDS"
	kill -9 "$notifyPID" > /dev/null 2>&1
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		killall -9 "IBM Notifier" "IBM Notifier Popup" > /dev/null 2>&1
	else
		killall -9 "jamfHelper" > /dev/null 2>&1
	fi
fi
}

# This is the install and restart workflow when a user is NOT logged in.
installRestartWorkflowNoUser() {
# Check to make sure system has enough available free storage space.
checkAvailableStorage
if [[ "$storageREADY" == "FALSE" ]]; then
	deferSECONDS="$errorDeferSECONDS"
	sendToLog "Status: Current available storage is at $availableStorageGB GBs which is below the $requiredStorageGB GBs that is required for download, trying again in $deferSECONDS seconds."
	sendToStatus "Pending: Current available storage is at $availableStorageGB GBs which is below the $requiredStorageGB GBs that is required for download, trying again in $deferSECONDS seconds."
	makeLaunchDaemonCalendar
fi
# Check to make sure system is plugged into AC power or that the current battery level is above $batteryLevelPERCENT.
checkAvailablePower
if [[ "$powerREADY" == "FALSE" ]]; then
	deferSECONDS="$errorDeferSECONDS"
	sendToLog "Status: Current battery level is at $currentBatteryLEVEL% which is below the minimum required level of $batteryLevelPERCENT%, trying again in $deferSECONDS seconds."
	sendToStatus "Pending: Current battery level is at $currentBatteryLEVEL% which is below the minimum required level of $batteryLevelPERCENT%, trying again in $deferSECONDS seconds."
	makeLaunchDaemonCalendar
fi
# At this point the system has adequate storage and power to continue macOS update/upgrade installation.
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeVersionTARGET is: $macOSUpgradeVersionTARGET"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateMACOS is: $softwareUpdateMACOS"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: upgradeWORKFLOW is: $upgradeWORKFLOW"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: updateWORKFLOW is: $updateWORKFLOW"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: installNowOPTION is: $installNowOPTION"

# If MDM workflow is expected, first check for MDM service and bootstrap token.
if { [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]] && [[ "$upgradeWORKFLOW" == "JAMF" ]]; } || { [[ "$softwareUpdateMACOS" == "TRUE" ]] && [[ "$updateWORKFLOW" == "JAMF" ]]; }; then
	checkMDMService
	if [[ "$mdmSERVICE" == "FALSE" ]]; then
		deferSECONDS="$errorDeferSECONDS"
		sendToLog "Error: Can not use MDM workflow because the MDM service is not available, trying again in $deferSECONDS seconds."
		sendToStatus "Pending: Can not use MDM workflow because the MDM service is not available, trying again in $deferSECONDS seconds."
		makeLaunchDaemonCalendar
	else # MDM service is available.
		checkBootstrapToken
		if [[ "$bootstrapTOKEN" == "FALSE" ]]; then
			deferSECONDS="$errorDeferSECONDS"
			sendToLog "Error: Can not use MDM workflow because this computer's bootstrap token is not escrowed, trying again in $deferSECONDS seconds."
			sendToStatus "Pending: Can not use MDM workflow because this computer's bootstrap token is not escrowed, trying again in $deferSECONDS seconds."
			makeLaunchDaemonCalendar
		fi
	fi
fi

# Logic to start the appropriate update/upgrade workflow.
if [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; then # A macOS upgrade is available and option to allow upgrade is enabled.
	if [[ "$upgradeWORKFLOW" == "LOCAL" ]]; then
		if [[ $macOSVERSION -ge 1203 ]]; then # macOS 12.3 or newer upgrade via softwareupdate.
			[[ -n $policyTRIGGERS ]] && runJamfPolicies
			installMacOSSoftwareUpdate
		else # Systems older than macOS 12.3 upgrade via installer.
			downloadMacOSInstaller
			[[ -n $policyTRIGGERS ]] && runJamfPolicies
			installMacOSAPP
		fi
	elif [[ "$upgradeWORKFLOW" == "JAMF" ]]; then
		downloadMacOSInstaller
		[[ -n $policyTRIGGERS ]] && runJamfPolicies
		installMacOSMDM
	else # Apple Silicon with no valid update/upgrade credentials can not enforce macOS upgrade.
		deferSECONDS="$errorDeferSECONDS"
		sendToLog "Status: No valid Apple Silicon credentials and no logged in user, trying again in $deferSECONDS seconds."
		sendToStatus "Pending: No valid Apple Silicon credentials and no logged in user, trying again in $deferSECONDS seconds."
		makeLaunchDaemonCalendar
	fi
elif [[ "$softwareUpdateMACOS" == "TRUE" ]]; then # macOS updates are available.
	if [[ "$updateWORKFLOW" == "LOCAL" ]]; then
		[[ -n $policyTRIGGERS ]] && runJamfPolicies
		installMacOSSoftwareUpdate
	elif [[ "$updateWORKFLOW" == "JAMF" ]]; then
		[[ -n $policyTRIGGERS ]] && runJamfPolicies
		installMacOSMDM
	else # Apple Silicon with no valid update/upgrade credentials can not enforce macOS update.
		deferSECONDS="$errorDeferSECONDS"
		sendToLog "Status: No valid Apple Silicon credentials and no logged in user, trying again in $deferSECONDS seconds."
		sendToStatus "Pending: No valid Apple Silicon credentials and no logged in user, trying again in $deferSECONDS seconds."
		makeLaunchDaemonCalendar
	fi
else # Workflow when there is no macOS updates/upgrade.
	[[ -n $policyTRIGGERS ]] && runJamfPolicies
	if [[ "$restartWithoutUpdatesOPTION" == "TRUE" ]]; then # If requested, restart without updates.
		sendToLog "Forced Restart Mode: Restarting computer..."
		installRestartComplete
		shutdown -o -r +1 &
		disown -a
	else # Option to restart without updates is not enabled.
		sendToLog "Warning: When no macOS update/upgrade is available you must also specify the --restart-without-updates option to restart automatically."
	fi
fi
}

# This is the install and restart workflow when a user is logged in.
installRestartWorkflowActiveUser() {
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeVersionTARGET is: $macOSUpgradeVersionTARGET"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateMACOS is: $softwareUpdateMACOS"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: upgradeWORKFLOW is: $upgradeWORKFLOW"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: updateWORKFLOW is: $updateWORKFLOW"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: installNowOPTION is: $installNowOPTION"

# If MDM workflow is expected, first check for MDM service, bootstrap token, and possibly failover to user authentication workflow.
if { [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]] && [[ "$upgradeWORKFLOW" == "JAMF" ]]; } || { [[ "$softwareUpdateMACOS" == "TRUE" ]] && [[ "$updateWORKFLOW" == "JAMF" ]]; }; then
	checkMDMService
	if [[ "$mdmSERVICE" == "FALSE" ]]; then
		if [[ "$userAuthMDMFAILOVER" == "TRUE" ]] || [[ "$userAuthMDMFailoverNOSERVICE" == "TRUE" ]] || { [[ "$installNowOPTION" == "TRUE" ]] && [[ "$userAuthMDMFailoverINSTALLNOW" == "TRUE" ]]; }; then
			sendToLog "Warning: MDM service is not available, failing over to user authenticated workflow."
			upgradeWORKFLOW="MDMFAIL"
		else
			if [[ "$installNowOPTION" == "TRUE" ]]; then
				sendToLog "Error: Can not use MDM workflow because the MDM service is not available, install now workflow can not continue."
				sendToStatus "Inactive Error: Can not use MDM workflow because the MDM service is not available, install now workflow can not continue."
				notifyInstallNowFailure
				errorExit
			else
				deferSECONDS="$errorDeferSECONDS"
				sendToLog "Error: Can not use MDM workflow because the MDM service is not available, trying again in $deferSECONDS seconds."
				sendToStatus "Pending: Can not use MDM workflow because the MDM service is not available, trying again in $deferSECONDS seconds."
				notifyFailure
				makeLaunchDaemonCalendar
			fi
		fi
	else # MDM service is available.
		checkBootstrapToken
		if [[ "$bootstrapTOKEN" == "FALSE" ]]; then
			if [[ "$userAuthMDMFAILOVER" == "TRUE" ]] || [[ "$userAuthMDMFailoverBOOTSTRAP" == "TRUE" ]] || { [[ "$installNowOPTION" == "TRUE" ]] && [[ "$userAuthMDMFailoverINSTALLNOW" == "TRUE" ]]; }; then
				sendToLog "Warning: Missing or invalid bootstrap token escrow, failing over to user authenticated workflow."
				updateWORKFLOW="MDMFAIL"
			else
				if [[ "$installNowOPTION" == "TRUE" ]]; then
					sendToLog "Error: Can not use MDM workflow because this computer's bootstrap token is not escrowed, install now workflow can not continue."
					sendToStatus "Inactive Error: Can not use MDM workflow because this computer's bootstrap token is not escrowed, install now workflow can not continue."
					notifyInstallNowFailure
					errorExit
				else
					deferSECONDS="$errorDeferSECONDS"
					sendToLog "Error: Can not use MDM workflow because this computer's bootstrap token is not escrowed, trying again in $deferSECONDS seconds."
					sendToStatus "Pending: Can not use MDM workflow because this computer's bootstrap token is not escrowed, trying again in $deferSECONDS seconds."
					notifyFailure
					makeLaunchDaemonCalendar
				fi
			fi
		fi
	fi
fi

# Logic to start the appropriate update/upgrade workflow.
if [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; then # A macOS upgrade is available and option to allow upgrade is enabled.
	if [[ "$upgradeWORKFLOW" == "LOCAL" ]] || [[ "$upgradeWORKFLOW" == "USER" ]] || [[ "$upgradeWORKFLOW" == "MDMFAIL" ]]; then
		if [[ "$upgradeWORKFLOW" == "MDMFAIL" ]]; then
			dialogUserAuth
		elif [[ "$upgradeWORKFLOW" == "USER" ]] && [[ "$installNowOPTION" != "TRUE" ]]; then
			dialogUserAuth
		fi
		checkAvailableStorage
		[[ "$storageREADY" == "FALSE" ]] && notifyStorage
		checkAvailablePower
		[[ "$powerREADY" == "FALSE" ]] && notifyPower
		if [[ $macOSVERSION -ge 1203 ]] && [[ "$upgradeWORKFLOW" != "MDMFAIL" ]]; then # macOS 12.3 or newer can upgrade via softwareupdate, but not when the MDM workflow fails.
			notifyRestart
			[[ -n $policyTRIGGERS ]] && runJamfPolicies
			installMacOSSoftwareUpdate
		else # Systems older than macOS 12.3 upgrade via installer, or when the MDM workflow fails.
			prepareTimeEstimateDISPLAY="15-25"
			notifyPrepare
			[[ -n $policyTRIGGERS ]] && runJamfPolicies
			installMacOSAPP
		fi
	elif [[ "$upgradeWORKFLOW" == "JAMF" ]]; then
		checkAvailableStorage
		[[ "$storageREADY" == "FALSE" ]] && notifyStorage
		checkAvailablePower
		[[ "$powerREADY" == "FALSE" ]] && notifyPower
		prepareTimeEstimateDISPLAY="25-30"
		notifyPrepare
		[[ -n $policyTRIGGERS ]] && runJamfPolicies
		installMacOSMDM
	fi
elif [[ "$softwareUpdateMACOS" == "TRUE" ]]; then # macOS updates are available.
	if [[ "$updateWORKFLOW" == "LOCAL" ]] || [[ "$updateWORKFLOW" == "USER" ]] || [[ "$updateWORKFLOW" == "MDMFAIL" ]]; then
		if [[ "$updateWORKFLOW" == "MDMFAIL" ]]; then
			dialogUserAuth
		elif [[ "$updateWORKFLOW" == "USER" ]] && [[ "$installNowOPTION" != "TRUE" ]]; then
			dialogUserAuth
		fi
		checkAvailableStorage
		[[ "$storageREADY" == "FALSE" ]] && notifyStorage
		checkAvailablePower
		[[ "$powerREADY" == "FALSE" ]] && notifyPower
		notifyRestart
		[[ -n $policyTRIGGERS ]] && runJamfPolicies
		installMacOSSoftwareUpdate
	elif [[ "$updateWORKFLOW" == "JAMF" ]]; then
		checkAvailableStorage
		[[ "$storageREADY" == "FALSE" ]] && notifyStorage
		checkAvailablePower
		[[ "$powerREADY" == "FALSE" ]] && notifyPower
		prepareTimeEstimateDISPLAY="5"
		notifyPrepare
		[[ -n $policyTRIGGERS ]] && runJamfPolicies
		installMacOSMDM
	fi
else # Workflow when there is no macOS updates/upgrade.
	notifyRestart
	[[ -n $policyTRIGGERS ]] && runJamfPolicies
	if [[ "$restartWithoutUpdatesOPTION" == "TRUE" ]]; then # If requested, restart without updates.
		if [[ "$testModeOPTION" != "TRUE" ]]; then
			sendToLog "Forced Restart Mode: Restarting computer..."
			installRestartComplete
			shutdown -o -r +1 &
			disown -a
		else # Test mode.
			sendToLog "Test Mode: Pausing $testModeTimeoutSECONDS seconds for the restart notification..."
			sleep "$testModeTimeoutSECONDS"
			kill -9 "$notifyPID" > /dev/null 2>&1
			if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
				killall -9 "IBM Notifier" "IBM Notifier Popup" > /dev/null 2>&1
			else
				killall -9 "jamfHelper" > /dev/null 2>&1
			fi
		fi
	else # Option to restart without updates is not enabled.
		sendToLog "Warning: When no macOS update/upgrade is available you must also specify the --restart-without-updates option to restart automatically."
	fi
fi
}

# This is the final set of maintenance commands that run after a successful macOS update/upgrade workflow.
installRestartComplete() {
unset recheckDeferSECONDS
restartVALIDATE="TRUE"
touch "$restartValidateFilePATH"
}

# MARK: *** LaunchDaemons ***
################################################################################

# This unloads and deletes any previous LaunchDaemons.
removeLaunchDaemon() {
if [[ -f "/Library/LaunchDaemons/$launchDaemonNAME.plist" ]]; then
	sendToLog "Status: Removing previous LaunchDaemon $launchDaemonNAME.plist."
	launchctl bootout system "/Library/LaunchDaemons/$launchDaemonNAME.plist" 2> /dev/null
	rm -f "/Library/LaunchDaemons/$launchDaemonNAME.plist"
fi
defaults delete "$superPLIST" FailSafeActive 2> /dev/null
}

# Create a LaunchDaemon to run super-starter again right now, thus releasing any Jamf Pro Policy that may have started super.
makeLaunchDaemonRestartNow() {
removeLaunchDaemon

# This creates a LaunchDaemon.plist file.
/bin/cat <<EOLDL > "/Library/LaunchDaemons/$launchDaemonNAME.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>$launchDaemonNAME</string>
	<key>LaunchOnlyOnce</key>
	<true/>
	<key>AbandonProcessGroup</key>
	<true/>
	<key>UserName</key>
	<string>root</string>
	<key>ProgramArguments</key>
	<array>
		<string>$superFOLDER/super-starter</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
</dict>
</plist>
EOLDL

# Set proper permissions and load the LaunchDaemon.
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: LaunchDaemon $launchDaemonNAME.plist:\n$(cat "/Library/LaunchDaemons/$launchDaemonNAME.plist")"
chmod 644 "/Library/LaunchDaemons/$launchDaemonNAME.plist"
chown root:wheel "/Library/LaunchDaemons/$launchDaemonNAME.plist"
sendToLog "Exit: LaunchDaemon $launchDaemonNAME.plist is scheduled to start right now."
sendToPending "Right Now."
launchctl bootstrap system "/Library/LaunchDaemons/$launchDaemonNAME.plist"
sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION EXIT ****"
rm -f "$superPIDFILE"
exit 0
}

# Create a LaunchDaemon to run super-starter again after restart.
makeLaunchDaemonOnStartup() {
removeLaunchDaemon

# This creates a LaunchDaemon.plist file.
/bin/cat <<EOLDL > "/Library/LaunchDaemons/$launchDaemonNAME.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>$launchDaemonNAME</string>
	<key>LaunchOnlyOnce</key>
	<true/>
	<key>AbandonProcessGroup</key>
	<true/>
	<key>UserName</key>
	<string>root</string>
	<key>ProgramArguments</key>
	<array>
		<string>$superFOLDER/super-starter</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
</dict>
</plist>
EOLDL

# Set proper permissions for the LaunchDaemon.
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: LaunchDaemon $launchDaemonNAME.plist:\n$(cat "/Library/LaunchDaemons/$launchDaemonNAME.plist")"
chmod 644 "/Library/LaunchDaemons/$launchDaemonNAME.plist"
chown root:wheel "/Library/LaunchDaemons/$launchDaemonNAME.plist"
sendToLog "Status: LaunchDaemon $launchDaemonNAME.plist is scheduled at next startup."
}

# Create a LaunchDaemon to run super-starter again $deferSECONDS from now.
makeLaunchDaemonCalendar() {
removeLaunchDaemon

# Calculate the appropriate deferment timer for the LaunchDaemon.
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: deferSECONDS is: $deferSECONDS"
deferCALC=$(($(date +%s) + deferSECONDS))
month=$(date -j -f "%s" "$deferCALC" "+%m" | xargs)
day=$(date -j -f "%s" "$deferCALC" "+%e" | xargs)
hour=$(date -j -f "%s" "$deferCALC" "+%H" | xargs)
minute=$(date -j -f "%s" "$deferCALC" "+%M" | xargs)

# This creates a LaunchDaemon.plist file.
/bin/cat <<EOLDL > "/Library/LaunchDaemons/$launchDaemonNAME.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>$launchDaemonNAME</string>
	<key>LaunchOnlyOnce</key>
	<true/>
	<key>AbandonProcessGroup</key>
	<true/>
	<key>UserName</key>
	<string>root</string>
	<key>ProgramArguments</key>
	<array>
		<string>$superFOLDER/super-starter</string>
	</array>
	<key>StartCalendarInterval</key>
	<array>
		<dict>
		<key>Month</key>
		<integer>$month</integer>
		<key>Day</key>
		<integer>$day</integer>
		<key>Hour</key>
		<integer>$hour</integer>
		<key>Minute</key>
		<integer>$minute</integer>
		</dict>
	</array>
</dict>
</plist>
EOLDL

# Set proper permissions and load the LaunchDaemon.
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: LaunchDaemon $launchDaemonNAME.plist:\n$(cat "/Library/LaunchDaemons/$launchDaemonNAME.plist")"
chmod 644 "/Library/LaunchDaemons/$launchDaemonNAME.plist"
chown root:wheel "/Library/LaunchDaemons/$launchDaemonNAME.plist"
sendToLog "Exit: LaunchDaemon $launchDaemonNAME.plist is scheduled to start at $hour:$minute on $month/$day."
sendToPending "$(date -j -f "%s" "$deferCALC" "+%F %T" | xargs)"
launchctl bootstrap system "/Library/LaunchDaemons/$launchDaemonNAME.plist"
cleanExit
}

# MARK: *** User Interface Prep ***
################################################################################

# Set language strings for notifications and dialogs.
setDisplayLanguage() {
#### Langauge for the restart button in dialogs. Note that for deadline dialogs this is the default button.
restartButtonDISPLAY="Restart"

#### Language for the deferral button in dialogs that do not show the $menuDeferOPTION but instead show the $DefaultDefer time in the button display. Note that for non-deadline dialogs this is the default button.
deferForButtonDISPLAY="Defer For"

#### Language for the deferral button in dialogs that also show the $menuDeferOPTION. Note that for non-deadline dialogs this is the default button.
deferButtonDISPLAY="Defer"

#### Language for the ok button in certain notifications.
okButtonDISPLAY="OK"

### Language for various deferral time durations.
dialogRestartOrDeferMinutesDISPLAY="Minutes"
dialogRestartOrDeferHourDISPLAY="Hour"
dialogRestartOrDeferHoursDISPLAY="Hours"
dialogRestartOrDeferDayDISPLAY="Day"

#### This code generates the $titleWorkflowDISPLAY variable to include the appropriate macOS update or upgrade.
if [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; then # A macOS upgrade is available and option to allow upgrade is enabled.
	if [[ $macOSVERSION -ge 1203 ]] && [[ "$upgradeWORKFLOW" != "JAMF" ]]; then # Newer systems upgrade via softwareupdate unless via MDM workflow.
		titleWorkflowDISPLAY="macOS $macOSSoftwareUpgradeVersionTARGET Upgrade"
	else # Systems older than macOS 12.3 or using MDM workflow upgrade via installer.
		titleWorkflowDISPLAY="macOS $macOSInstallerVersionTARGET Upgrade"
	fi
elif [[ "$softwareUpdateMACOS" == "TRUE" ]]; then # macOS updates are available.
	titleWorkflowDISPLAY="macOS $macOSSoftwareUpdateVERSION Update"
else # Only recommended (non-system) updates are available.
	titleWorkflowDISPLAY="Apple Software Updates"
fi
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: titleWorkflowDISPLAY is: $titleWorkflowDISPLAY"

#### Useful display variables:
# $titleWorkflowDISPLAY is the macOS update or upgrade workflow title that includes the target macOS version number.
# $availableStorageGB is the number of gigabytes of currently available storage.
# $requiredStorageGB is the number of gigabytes required for the current macOS update/upgrade workflow.
# $countDISPLAY is the current number of user soft/hard deferrals.
# $countMaxDISPLAY is the maximum number of user soft/hard deferrals.
# $softDaysMAX is the maximum number of deferral days before a soft deadline.
# $hardDaysMAX is the maximum number of deferral days before a hard deadline.
# $zeroDayDISPLAY is the date:time of the zero day that is used for calculating the maximum days deferral deadlines.
# $deadlineDaysDISPLAY is the soonest date:time based on evaluating the maximum days deferral deadlines.
# $deadlineDateDISPLAY is the soonest date:time based on evaluating the maximum date deferral deadlines.
# $deadlineDISPLAY is the soonest date:time based on evaluating both the maximum date and days deferral deadlines.
# $prepareTimeEstimateDISPLAY is a estimated number of minutes that an update/upgrade process needs for preparation before a restart.
# $currentUserRealNAME is the current users full (display friendly) name.
# See $dateFORMAT and $timeFORMAT in the setDefaults() function to adjust how the date:time is shown.

#### Language for notifyInstallNowStart(), a non-interactive notification informing the user that the install now workflow has started.
notifyInstallNowStartTITLE="Apple Software Update Starting"
# Note that IBM Notifier interprets "\n" as a return, while jamfHelper interprets "real" returns.
notifyInstallNowStartBodyIBM="The Apple software update workflow has started, and you will be notified if this computer needs to restart.\n\nDuring this time you can continue to use the computer or lock the screen, but please do not restart or sleep the computer as it will prolong the Apple software update process."
notifyInstallNowStartBodyJAMF="The Apple software update workflow has started, and you will be notified if this computer needs to restart.

During this time you can continue to use the computer or lock the screen, but please do not restart or sleep the computer as it will prolong the Apple software update process."

#### Language for notifyInstallNowDownload(), a non-interactive notification informing the user that the install now workflow is downloading the macOS update/upgrade.
notifyInstallNowDownloadTITLE="Downloading $titleWorkflowDISPLAY"
# Note that IBM Notifier interprets "\n" as a return, while jamfHelper interprets "real" returns.
notifyInstallNowDownloadBodyIBM="The $titleWorkflowDISPLAY is downloading from Apple. This may take a while, but you will be notified before this computer automatically restarts.\n\nDuring this time you can continue to use the computer or lock the screen, but please do not restart or sleep the computer as it will prolong the update/upgrade process."
notifyInstallNowDownloadBodyJAMF="The $titleWorkflowDISPLAY is downloading from Apple. This may take a while, but you will be notified before this computer automatically restarts.

During this time you can continue to use the computer or lock the screen, but please do not restart or sleep the computer as it will prolong the update/upgrade process."

#### Language for notifyInstallNowUpToDate(), a non-interactive notification informing the user that the install now workflow doesn't have anything else to do.
notifyInstallNowUpToDateTITLE="Apple Software Update Complete"
# Note that IBM Notifier interprets "\n" as a return, while jamfHelper interprets "real" returns.
notifyInstallNowUpToDateBodyIBM="Apple system software is already up to date or is the latest version allowed by management."
notifyInstallNowUpToDateBodyJAMF="Apple system software is already up to date or is the latest version allowed by management."

#### Language for notifyInstallNowFailure(), a non-interactive notification informing the user that the install now workflow has failed.
# This is used for all update/upgrade workflows if they fail to start or timeout after a pending restart notification has been shown.
notifyInstallNowFailureTITLE="$titleWorkflowDISPLAY Failed"
# Note that IBM Notifier interprets "\n" as a return, while jamfHelper interprets "real" returns.
notifyInstallNowFailureBodyIBM="The $titleWorkflowDISPLAY failed to complete, the computer will not be restarting.\n\nYou can try again or consider contacting your technical support team if you're experiencing consistent failures."
notifyInstallNowFailureBodyJAMF="The $titleWorkflowDISPLAY failed to complete, the computer will not be restarting.

You can try again or consider contacting your technical support team if you're experiencing consistent failures."

#### Language for notifyStorage(), a non-interactive notification informing the user that there is insufficient free space for macOS update/upgrade.
# This is used for both non-deadline and deadline workflows.
notifyStorageTITLE="Insufficient Storage For $titleWorkflowDISPLAY"
# Note that IBM Notifier interprets "\n" as a return, while jamfHelper interprets "real" returns.
notifyStorageBodyDefaultIBM="A required macOS update needs $requiredStorageGB GBs of free storage space and only $availableStorageGB GBs is available.\n\nPlease use the storage settings (shown behind this notification) to remove unnecessary items."
notifyStorageBodyDefaultJAMF="A required macOS update needs $requiredStorageGB GBs of free storage space and only $availableStorageGB GBs is available.

Please use the storage settings (shown behind this notification) to remove unnecessary items."
notifyStorageBodyDeadlineCountIBM="You have deferred the maximum number of $countMaxDISPLAY times.\n\nA required macOS update needs $requiredStorageGB GBs of free storage space and only $availableStorageGB GBs is available.\n\nPlease use the storage settings (shown behind this notification) to remove unnecessary items."
notifyStorageBodyDeadlineCountJAMF="You have deferred the maximum number of $countMaxDISPLAY times.

A required macOS update needs $requiredStorageGB GBs of free storage space and only $availableStorageGB GBs is available.

Please use the storage settings (shown behind this notification) to remove unnecessary items."
notifyStorageBodyDeadlineDaysIBM="You have deferred the maximum number of $hardDaysMAX days.\n\nA required macOS update needs $requiredStorageGB GBs of free storage space and only $availableStorageGB GBs is available.\n\nPlease use the storage settings (shown behind this notification) to remove unnecessary items."
notifyStorageBodyDeadlineDaysJAMF="You have deferred the maximum number of $hardDaysMAX days.

A required macOS update needs $requiredStorageGB GBs of free storage space and only $availableStorageGB GBs is available. Please use the Storage settings to remove unnecessary items."
notifyStorageBodyDeadlineDateIBM="The deferment deadline of $deadlineDateDISPLAY has passed.\n\nA required macOS update needs $requiredStorageGB GBs of free storage space and only $availableStorageGB GBs is available.\n\nPlease use the storage settings (shown behind this notification) to remove unnecessary items."
notifyStorageBodyDeadlineDateJAMF="The deferment deadline of $deadlineDateDISPLAY has passed.

A required macOS update needs $requiredStorageGB GBs of free storage space and only $availableStorageGB GBs is available.

Please use the storage settings (shown behind this notification) to remove unnecessary items."

#### Language for notifyPower(), a non-interactive notification informing the user that they need to plug the computer into AC power.
# This is used for both non-deadline and deadline workflows.
notifyPowerTITLE="$titleWorkflowDISPLAY Requires Power Source"
# Note that IBM Notifier interprets "\n" as a return, while jamfHelper interprets "real" returns.
notifyPowerBodyDefaultIBM="You must connect this computer to a power supply in order to install the required macOS update."
notifyPowerBodyDefaultJAMF="You must connect this computer to a power supply in order to install the required macOS update."
notifyPowerBodyDeadlineCountIBM="You have deferred the maximum number of $countMaxDISPLAY times.\n\nYou must connect this computer to a power supply in order to install the required macOS update."
notifyPowerBodyDeadlineCountJAMF="You have deferred the maximum number of $countMaxDISPLAY times.

You must connect this computer to a power supply in order to install the required macOS update."
notifyPowerBodyDeadlineDaysIBM="You have deferred the maximum number of $hardDaysMAX days.\n\nYou must connect this computer to a power supply in order to install the required macOS update."
notifyPowerBodyDeadlineDaysJAMF="You have deferred the maximum number of $hardDaysMAX days.

You must connect this computer to a power supply in order to install the required macOS update."
notifyPowerBodyDeadlineDateIBM="The deferment deadline of $deadlineDateDISPLAY has passed.\n\nYou must connect this computer to a power supply in order to install the required macOS update."
notifyPowerBodyDeadlineDateJAMF="The deferment deadline of $deadlineDateDISPLAY has passed.

You must connect this computer to a power supply in order to install the required macOS update."

#### Language for notifyPrepare(), a non-interactive notification informing the user that a update/upgrade preparation process has started.
# This is used for both non-deadline and deadline workflows.
notifyPrepTITLE="$titleWorkflowDISPLAY Requires Restart"
# Note that IBM Notifier interprets "\n" as a return, while jamfHelper interprets "real" returns.
notifyPrepBodyDefaultIBM="A required software update will automatically restart this computer in about $prepareTimeEstimateDISPLAY minutes.\n\nDuring this time you can continue to use the computer or lock the screen, but please do not restart or sleep the computer as it will prolong the update process."
notifyPrepBodyDefaultJAMF="A required software update will automatically restart this computer in about $prepareTimeEstimateDISPLAY minutes.

During this time you can continue to use the computer or lock the screen, but please do not restart or sleep the computer as it will prolong the update process."
notifyPrepBodyDeadlineCountIBM="You have deferred the maximum number of $countMaxDISPLAY times.\n\nA required software update will automatically restart this computer in about $prepareTimeEstimateDISPLAY minutes.\n\nDuring this time you can continue to use the computer or lock the screen, but please do not restart or sleep the computer as it will prolong the update process."
notifyPrepBodyDeadlineCountJAMF="You have deferred the maximum number of $countMaxDISPLAY times.

A required software update will automatically restart this computer in about $prepareTimeEstimateDISPLAY minutes.

During this time you can continue to use the computer or lock the screen, but please do not restart or sleep the computer as it will prolong the update process."
notifyPrepBodyDeadlineDaysIBM="You have deferred the maximum number of $hardDaysMAX days.\n\nA required software update will automatically restart this computer in about $prepareTimeEstimateDISPLAY minutes.\n\nDuring this time you can continue to use the computer or lock the screen, but please do not restart or sleep the computer as it will prolong the update process."
notifyPrepBodyDeadlineDaysJAMF="You have deferred the maximum number of $hardDaysMAX days.

A required software update will automatically restart this computer in about $prepareTimeEstimateDISPLAY minutes.

During this time you can continue to use the computer or lock the screen, but please do not restart or sleep the computer as it will prolong the update process."
notifyPrepBodyDeadlineDateIBM="The deferment deadline of $deadlineDateDISPLAY has passed.\n\nA required software update will automatically restart this computer in about $prepareTimeEstimateDISPLAY minutes.\n\nDuring this time you can continue to use the computer or lock the screen, but please do not restart or sleep the computer as it will prolong the update process."
notifyPrepBodyDeadlineDateJAMF="The deferment deadline of $deadlineDateDISPLAY has passed.

A required software update will automatically restart this computer in about $prepareTimeEstimateDISPLAY minutes.

During this time you can continue to use the computer or lock the screen, but please do not restart or sleep the computer as it will prolong the update process."

#### Language for notifyRestart(), a non-interactive notification informing the user that the computer is going to restart very soon.
# This is used for all softwareupdate workflows and near the end of the MDM workflow.
# This is used for both non-deadline and deadline workflows.
notifyRestartTITLE="$titleWorkflowDISPLAY Requires Restart"
# Note that IBM Notifier interprets "\n" as a return, while jamfHelper interprets "real" returns.
notifyRestartBodyDefaultIBM="This computer will automatically restart very soon.\n\nSave any open documents now."
notifyRestartBodyDefaultJAMF="This computer will automatically restart very soon.

Save any open documents now."
notifyRestartBodyDeadlineCountIBM="You have deferred the maximum number of $countMaxDISPLAY times.\n\nThis computer will automatically restart very soon.\n\nSave any open documents now."
notifyRestartBodyDeadlineCountJAMF="You have deferred the maximum number of $countMaxDISPLAY times.

This computer will automatically restart very soon.

Save any open documents now."
notifyRestartBodyDeadlineDaysIBM="You have deferred the maximum number of $hardDaysMAX days.\n\nThis computer will automatically restart very soon.\n\nSave any open documents now."
notifyRestartBodyDeadlineDaysJAMF="You have deferred the maximum number of $hardDaysMAX days.

This computer will automatically restart very soon.

Save any open documents now."
notifyRestartBodyDeadlineDateIBM="The deferment deadline of $deadlineDateDISPLAY has passed.\n\nThis computer will automatically restart very soon.\n\nSave any open documents now."
notifyRestartBodyDeadlineDateJAMF="The deferment deadline of $deadlineDateDISPLAY has passed.

This computer will automatically restart very soon.

Save any open documents now."

#### Language for notifyRecommended(), a non-interactive notification informing the user that the install now workflow is installing recommended (non-system) software updates.
notifyRecommendedTITLE="Installing $titleWorkflowDISPLAY"
# Note that IBM Notifier interprets "\n" as a return, while jamfHelper interprets "real" returns.
notifyRecommendedBodyIBM="Required Apple software updates are now installing.\n\nThe computer will not restart but some Apple applications (like Safari) may automatically restart.\n\nThis should only take a few minutes, but please do not restart or sleep the computer as it will prolong the update process."
notifyRecommendedBodyJAMF="Required Apple software updates are now installing.

The computer will not restart but some Apple applications (like Safari) may automatically restart.

This should only take a few minutes, but please do not restart or sleep the computer as it will prolong the update process."

#### Language for notifyFailure(), a non-interactive notification informing the user that the managed update/upgrade process has failed.
# This is used for all update/upgrade workflows if they fail to start or timeout after a pending restart notification has been shown.
notifyFailureTITLE="$titleWorkflowDISPLAY Failed"
# Note that IBM Notifier interprets "\n" as a return, while jamfHelper interprets "real" returns.
notifyFailureBodyIBM="The $titleWorkflowDISPLAY failed to complete.\n\nThe computer will not restart right now, but you will be notified later when the software update is attempted again."
notifyFailureBodyJAMF="The $titleWorkflowDISPLAY failed to complete.

The computer will not restart right now, but you will be notified later when the software update is attempted again."

#### Language for dialogRestartOrDefer(), an interactive dialog giving the user a choice to defer the update or restart.
dialogRestartOrDeferTITLE="$titleWorkflowDISPLAY Requires Restart"
dialogRestartOrDeferDeferMenuTitleIBM="Defer software update for:" # jamfHelper does not allow for customizing the deferral menu language.
dialogRestartOrDeferTimeoutIBM="Please make selection in" # jamfHelper does not allow for customizing the display timeout language.
# Note that IBM Notifier interprets "\n" as a return, while jamfHelper interprets "real" returns.
dialogRestartOrDeferBodyUnlimitedIBM="• No deadline date and unlimited deferrals.\n"
dialogRestartOrDeferBodyUnlimitedJAMF="• No deadline date and unlimited deferrals."
dialogRestartOrDeferBodyDateIBM="• Deferral available until $deadlineDISPLAY.\n"
dialogRestartOrDeferBodyDateJAMF="• Deferral available until $deadlineDISPLAY."
dialogRestartOrDeferBodyCountIBM="• $countDISPLAY out of $countMaxDISPLAY deferrals remaining.\n"
dialogRestartOrDeferBodyCountJAMF="• $countDISPLAY out of $countMaxDISPLAY deferrals remaining."
dialogRestartOrDeferBodyDateCountIBM="• Deferral available until $deadlineDISPLAY.\n\n• $countDISPLAY out of $countMaxDISPLAY deferrals remaining.\n"
dialogRestartOrDeferBodyDateCountJAMF="• Deferral available until $deadlineDISPLAY.

• $countDISPLAY out of $countMaxDISPLAY deferrals remaining."

#### Language for dialogSoftDeadline(), an interactive dialog when a soft deadline has passed, giving the user only one button to continue the workflow.
dialogSoftDeadlineTITLE="$titleWorkflowDISPLAY Requires Restart"
dialogSoftDeadlineTimeoutIBM="Update will automatically start in" # jamfHelper does not allow for customizing the display timeout language.
# Note that IBM Notifier interprets "\n" as a return, while jamfHelper interprets "real" returns.
dialogSoftDeadlineBodyCountIBM="You have deferred the maximum number of $countMaxDISPLAY times."
dialogSoftDeadlineBodyCountJAMF="You have deferred the maximum number of $countMaxDISPLAY times."
dialogSoftDeadlineBodyDaysIBM="You have deferred the maximum number of $softDaysMAX days."
dialogSoftDeadlineBodyDaysJAMF="You have deferred the maximum number of $softDaysMAX days."
dialogSoftDeadlineBodyDateIBM="The deferment deadline has passed:\n$deadlineDateDISPLAY."
dialogSoftDeadlineBodyDateJAMF="The deferment deadline has passed:

$deadlineDateDISPLAY."

#### Language for dialogUserAuth(), an interactive IBM Notifier dialog to collect user credentials for macOS update/upgrade workflow
# This is used for both non-deadline and deadline workflows.
dialogUserAuthTITLE="$titleWorkflowDISPLAY Requires Authentication"
dialogUserAuthDefaultBODY="You must enter the password for user \"$currentUserRealNAME\" to install the $titleWorkflowDISPLAY.\n"
dialogUserAuthDeadlineCountBODY="You have deferred the maximum number of $countMaxDISPLAY times.\n\nYou must enter the password for user \"$currentUserRealNAME\" to install the $titleWorkflowDISPLAY.\n"
dialogUserAuthDeadlineSoftDaysBODY="You have deferred the maximum number of $softDaysMAX days.\n\nYou must enter the password for user \"$currentUserRealNAME\" to install the $titleWorkflowDISPLAY.\n"
dialogUserAuthDeadlineHardDaysBODY="You have deferred the maximum number of $hardDaysMAX days.\n\nYou must enter the password for user \"$currentUserRealNAME\" to install the $titleWorkflowDISPLAY.\n"
dialogUserAuthDeadlineDateBODY="The deferment deadline of $deadlineDateDISPLAY has passed.\n\nYou must enter the password for user \"$currentUserRealNAME\" to install the $titleWorkflowDISPLAY.\n"
dialogUserAuthPassTITLE="Enter Password Here:"
dialogUserAuthPassPLACEHOLDER="Password Required"
dialogUserAuthRetryDefaultBODY="You must enter the password for user \"$currentUserRealNAME\" to install the $titleWorkflowDISPLAY.\n"
dialogUserAuthRetryDeadlineCountBODY="You have deferred the maximum number of $countMaxDISPLAY times.\n\nYou must enter the password for user \"$currentUserRealNAME\" to install the $titleWorkflowDISPLAY.\n"
dialogUserAuthRetryDeadlineSoftDaysBODY="You have deferred the maximum number of $softDaysMAX days.\n\nYou must enter the password for user \"$currentUserRealNAME\" to install the $titleWorkflowDISPLAY.\n"
dialogUserAuthRetryDeadlineHardDaysBODY="You have deferred the maximum number of $hardDaysMAX days.\n\nYou must enter the password for user \"$currentUserRealNAME\" to install the $titleWorkflowDISPLAY.\n"
dialogUserAuthRetryDeadlineDateBODY="The deferment deadline of $deadlineDateDISPLAY has passed.\n\nYou must enter the password for user \"$currentUserRealNAME\" to install the $titleWorkflowDISPLAY.\n"
dialogUserAuthRetryPassTITLE="Authentication Failed - Try Password Again:"
dialogUserAuthRetryPassPLACEHOLDER="Password Required"
}

# For IBM Notifier dialogs set a new $deferButtonDISPLAY showing the $deferSECONDS.
setDeferButton() {
if [[ $deferSECONDS -lt 3600 ]]; then
	deferButtonDISPLAY="$deferForButtonDISPLAY $((deferSECONDS / 60)) $dialogRestartOrDeferMinutesDISPLAY"
elif [[ $deferSECONDS -eq 3600 ]]; then
	deferButtonDISPLAY="$deferForButtonDISPLAY 1 $dialogRestartOrDeferHourDISPLAY"
elif [[ $deferSECONDS -gt 3600 ]] && [[ $deferSECONDS -lt 7200 ]]; then
	deferButtonDISPLAY="$deferForButtonDISPLAY 1 $dialogRestartOrDeferHourDISPLAY $((deferSECONDS % 3600 / 60)) $dialogRestartOrDeferMinutesDISPLAY"
elif [[ $deferSECONDS -ge 7200 ]] && [[ $deferSECONDS -lt 86400 ]] && [[ $((deferSECONDS % 3600)) -eq 0 ]]; then
	deferButtonDISPLAY="$deferForButtonDISPLAY $((deferSECONDS / 3600)) $dialogRestartOrDeferHoursDISPLAY"
elif [[ $deferSECONDS -gt 7200 ]] && [[ $deferSECONDS -lt 86400 ]] && [[ $((deferSECONDS % 3600)) -ne 0 ]]; then
	deferButtonDISPLAY="$deferForButtonDISPLAY $((deferSECONDS / 3600)) $dialogRestartOrDeferHoursDISPLAY $((deferSECONDS % 3600 / 60)) $dialogRestartOrDeferMinutesDISPLAY"
elif [[ $deferSECONDS -eq 86400 ]]; then
	deferButtonDISPLAY="$deferForButtonDISPLAY 1 $dialogRestartOrDeferDayDISPLAY"
fi
}

# For IBM Notifier dialogs handle the $helpBUTTON, $warningBUTTON, and $displaySilentlyOPTION options.
setIbmNotifierOptions() {
if [[ -n $helpBUTTON ]]; then
	if [[ $(echo "$helpBUTTON" | grep -c '^http://\|^https://\|^mailto:\|^jamfselfservice://') -gt 0 ]]; then
		if [[ $(echo "$helpButtonOPTION" | grep -c '^http://\|^https://') -gt 0 ]]; then
			commandRESULT=$(curl -Is "$helpButtonOPTION" | head -1)
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: commandRESULT is: $commandRESULT"
			if [[ $(echo "$commandRESULT" | grep -c '200') -gt 0 ]] || [[ $(echo "$commandRESULT" | grep -c '302') -gt 0 ]]; then
				ibmNotifierARRAY+=(-help_button_cta_type link -help_button_cta_payload "$helpBUTTON")
			else
				sendToLog "Warning: Help button not shown because URL cannot be reached: $helpBUTTON"
			fi
		else
			ibmNotifierARRAY+=(-help_button_cta_type link -help_button_cta_payload "$helpBUTTON")
		fi
	else
		ibmNotifierARRAY+=(-help_button_cta_type infopopup -help_button_cta_payload "$helpBUTTON")
	fi
fi
if [[ -n $warningBUTTON ]]; then
	if [[ $(echo "$warningBUTTON" | grep -c '^http://\|^https://\|^mailto:\|^jamfselfservice://') -gt 0 ]]; then
		if [[ $(echo "$warningButtonOPTION" | grep -c '^http://\|^https://') -gt 0 ]]; then
			commandRESULT=$(curl -Is "$warningButtonOPTION" | head -1)
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: commandRESULT is: $commandRESULT"
			if [[ $(echo "$commandRESULT" | grep -c '200') -gt 0 ]] || [[ $(echo "$commandRESULT" | grep -c '302') -gt 0 ]]; then
				ibmNotifierARRAY+=(-warning_button_cta_type link -warning_button_cta_payload "$warningBUTTON")
			else
				sendToLog "Warning: Warning button not shown because URL cannot be reached: $warningBUTTON"
			fi
		else
			ibmNotifierARRAY+=(-warning_button_cta_type link -warning_button_cta_payload "$warningBUTTON")
		fi
	else
		ibmNotifierARRAY+=(-warning_button_cta_type infopopup -warning_button_cta_payload "$warningBUTTON")
	fi
fi
[[ "$displaySilentlyOPTION" == "TRUE" ]] && ibmNotifierARRAY+=(-silent)
}

# Open $ibmNotifierBINARY for non-interactive notifications using the $ibmNotifierARRAY[] options.
openNotifyIbmNotifier() {
# Kill any previous notifications so new ones can take its place.
kill -9 "$notifyPID" > /dev/null 2>&1
killall -9 "IBM Notifier" "IBM Notifier Popup" > /dev/null 2>&1

# Open notification in the background allowing super to continue.
setIbmNotifierOptions
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: ibmNotifierARRAY[] is:\n${ibmNotifierARRAY[*]}"
"$ibmNotifierBINARY" "${ibmNotifierARRAY[@]}" & 
disown %
notifyPID=$!
}

# Open $jamfHELPER for non-interactive notifications using the $jamfHelperARRAY[] options.
openNotifyJamfHelper() {
# Kill any previous notifications so new ones can take its place.
kill -9 "$notifyPID" > /dev/null 2>&1
killall -9 "jamfHelper" > /dev/null 2>&1

# Open notification in the background allowing super to continue.
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfHelperARRAY[] is:\n${jamfHelperARRAY[*]}"
"$jamfHELPER" "${jamfHelperARRAY[@]}" &
disown %
notifyPID=$!
}

# Open $ibmNotifierBINARY for interactive dialogs using the $ibmNotifierARRAY[] options, and also handle any $displayTimeoutSECONDS, $displayRedrawSECONDS, $secureAccessoryPAYLOAD, $displayAccessoryCONTENT, and $displayAccessoryPAYLOAD options.
openDialogIbmNotifier() {
# Kill any previous notifications so new ones can take its place.
kill -9 "$notifyPID" > /dev/null 2>&1
killall -9 "IBM Notifier" "IBM Notifier Popup" > /dev/null 2>&1

unset dialogRESULT
unset dialogRETURN
customDisplayACCESSORY="FALSE"
if [[ -n $displayAccessoryCONTENT ]]; then
	if [[ $(echo "$displayAccessoryCONTENT" | grep -c '^http://\|^https://') -gt 0 ]]; then
		if [[ $displayAccessoryTYPE =~ ^TEXTBOX$|^HTMLBOX$|^HTML$ ]]; then
			displayAccessoryPAYLOAD=$(curl -s -f "$displayAccessoryCONTENT")
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: displayAccessoryPAYLOAD is:\n$displayAccessoryPAYLOAD"
			if [[ -n $displayAccessoryPAYLOAD ]]; then
				customDisplayACCESSORY="TRUE"
			else
				sendToLog "Warning: Custom display accessory not shown because URL cannot be downloaded: $displayAccessoryCONTENT"
			fi
		else # $displayAccessoryTYPE is IMAGE or VIDEO or VIDEOAUTO.
			commandRESULT=$(curl -Is "$displayAccessoryCONTENT" | head -1)
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: commandRESULT is: $commandRESULT"
			if [[ $(echo "$commandRESULT" | grep -c '200') -gt 0 ]] || [[ $(echo "$commandRESULT" | grep -c '302') -gt 0 ]]; then
				displayAccessoryPAYLOAD="$displayAccessoryCONTENT"
				customDisplayACCESSORY="TRUE"
			else
				sendToLog "Warning: Custom display accessory not shown because URL cannot be found: $displayAccessoryCONTENT"
			fi
		fi
	else # Assume it's a local path.
		if [[ $displayAccessoryTYPE =~ ^TEXTBOX$|^HTMLBOX$|^HTML$ ]]; then
			displayAccessoryPAYLOAD=$(<"$displayAccessoryCONTENT")
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: displayAccessoryPAYLOAD is:\n$displayAccessoryPAYLOAD"
			if [[ -n $displayAccessoryPAYLOAD ]]; then
				customDisplayACCESSORY="TRUE"
			else
				sendToLog "Warning: Custom display accessory not shown because file path cannot be read: $displayAccessoryCONTENT"
			fi
		else # $displayAccessoryTYPE is IMAGE or VIDEO or VIDEOAUTO.
			if [[ -f "$displayAccessoryCONTENT" ]]; then
				displayAccessoryPAYLOAD="$displayAccessoryCONTENT"
				customDisplayACCESSORY="TRUE"
			else
				sendToLog "Warning: Custom display accessory not shown because file path cannot be found: $displayAccessoryCONTENT"
			fi
		fi
	fi
fi
if [[ "$customDisplayACCESSORY" == "TRUE" ]]; then
	[[ "$displayAccessoryTYPE" == "TEXTBOX" ]] && ibmNotifierARRAY+=(-accessory_view_type whitebox -accessory_view_payload "$displayAccessoryPAYLOAD")
	[[ "$displayAccessoryTYPE" == "HTMLBOX" ]] && ibmNotifierARRAY+=(-accessory_view_type htmlwhitebox -accessory_view_payload "$displayAccessoryPAYLOAD")
	[[ "$displayAccessoryTYPE" == "HTML" ]] && ibmNotifierARRAY+=(-accessory_view_type html -accessory_view_payload "$displayAccessoryPAYLOAD")
	[[ "$displayAccessoryTYPE" == "IMAGE" ]] && ibmNotifierARRAY+=(-accessory_view_type image -accessory_view_payload "$displayAccessoryPAYLOAD")
	[[ "$displayAccessoryTYPE" == "VIDEO" ]] && ibmNotifierARRAY+=(-accessory_view_type video -accessory_view_payload "/url $displayAccessoryPAYLOAD")
	[[ "$displayAccessoryTYPE" == "VIDEOAUTO" ]] && ibmNotifierARRAY+=(-accessory_view_type video -accessory_view_payload "/url $displayAccessoryPAYLOAD /autoplay")
fi
setIbmNotifierOptions
if [[ -n $displayRedrawSECONDS ]]; then
	[[ -n $displayTimeoutSECONDS ]] && displayTimeoutSECONDS=$((displayTimeoutSECONDS-1))
	ibmNotifierBackupARRAY=("${ibmNotifierARRAY[@]}")
	while [[ -z $dialogRETURN ]] || [[ "$dialogRETURN" -eq 137 ]]; do
		if [[ "$customDisplayACCESSORY" == "TRUE" ]]; then
			if [[ -n $secureAccessoryPAYLOAD ]]; then
				ibmNotifierARRAY+=(-secondary_accessory_view_type secureinput -secondary_accessory_view_payload "$secureAccessoryPAYLOAD" -timeout "$displayTimeoutSECONDS")
			else
				{ [[ -n $menuDeferSECONDS ]] && [[ -z $displayTimeoutSECONDS ]]; } && ibmNotifierARRAY+=(-secondary_accessory_view_type dropdown -secondary_accessory_view_payload "/title $dialogRestartOrDeferDeferMenuTitleIBM /list $menuDisplayTEXT /selected 0")
				{ [[ -z $menuDeferSECONDS ]] && [[ -n $displayTimeoutSECONDS ]]; } && ibmNotifierARRAY+=(-secondary_accessory_view_type timer -secondary_accessory_view_payload "$displayTimeoutTEXT %@" -timeout "$displayTimeoutSECONDS")
				if [[ -n $menuDeferSECONDS ]] && [[ -n $displayTimeoutSECONDS ]]; then
					sendToLog "Warning: Unable to show display timeout countdown due to the custom display accessory option. However, there is still a display timeout at $displayTimeoutSECONDS seconds."
					ibmNotifierARRAY+=(-secondary_accessory_view_type dropdown -secondary_accessory_view_payload "/title $dialogRestartOrDeferDeferMenuTitleIBM /list $menuDisplayTEXT /selected 0" -timeout "$displayTimeoutSECONDS")
				fi
			fi
		else # No custom display accessory.
			if [[ -n $secureAccessoryPAYLOAD ]]; then
				ibmNotifierARRAY+=(-accessory_view_type secureinput -accessory_view_payload "$secureAccessoryPAYLOAD" -timeout "$displayTimeoutSECONDS")
			else
				{ [[ -n $menuDeferSECONDS ]] && [[ -z $displayTimeoutSECONDS ]]; } && ibmNotifierARRAY+=(-accessory_view_type dropdown -accessory_view_payload "/title $dialogRestartOrDeferDeferMenuTitleIBM /list $menuDisplayTEXT /selected 0")
				{ [[ -z $menuDeferSECONDS ]] && [[ -n $displayTimeoutSECONDS ]]; } && ibmNotifierARRAY+=(-accessory_view_type timer -accessory_view_payload "$displayTimeoutTEXT %@" -timeout "$displayTimeoutSECONDS")
				{ [[ -n $displayTimeoutSECONDS ]] && [[ -n $menuDeferSECONDS ]]; } && ibmNotifierARRAY+=(-accessory_view_type dropdown -accessory_view_payload "/title $dialogRestartOrDeferDeferMenuTitleIBM /list $menuDisplayTEXT /selected 0" -secondary_accessory_view_type timer -secondary_accessory_view_payload "$displayTimeoutTEXT %@" -timeout "$displayTimeoutSECONDS")
			fi
		fi
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: userAuthMODE is: $userAuthMODE"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: ibmNotifierARRAY[] is:\n${ibmNotifierARRAY[*]}"
		(sleep "$displayRedrawSECONDS"; killall -9 "IBM Notifier" "IBM Notifier Popup") &
		killerPID=$!
		disown
		dialogRESULT=$("$ibmNotifierBINARY" "${ibmNotifierARRAY[@]}")
		dialogRETURN="$?"
		kill -0 "$killerPID" && kill -9 "$killerPID" > /dev/null 2>&1
		{ [[ "$verboseModeOPTION" == "TRUE" ]] && [[ "$userAuthMODE" != "TRUE" ]]; } && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: dialogRESULT is: $dialogRESULT"
		{ [[ "$verboseModeOPTION" == "TRUE" ]] && [[ "$userAuthMODE" == "TRUE" ]]; } && sendToEcho "Verbose Mode: Function ${FUNCNAME[0]}: dialogRESULT is: $dialogRESULT"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: dialogRETURN is: $dialogRETURN"
		[[ -n $displayTimeoutSECONDS ]] && displayTimeoutSECONDS=$((displayTimeoutSECONDS - displayRedrawSECONDS))
		ibmNotifierARRAY=("${ibmNotifierBackupARRAY[@]}")
	done
else
	if [[ "$customDisplayACCESSORY" == "TRUE" ]]; then
		if [[ -n $secureAccessoryPAYLOAD ]]; then
			ibmNotifierARRAY+=(-secondary_accessory_view_type secureinput -secondary_accessory_view_payload "$secureAccessoryPAYLOAD" -timeout "$displayTimeoutSECONDS")
		else
			{ [[ -n $menuDeferSECONDS ]] && [[ -z $displayTimeoutSECONDS ]]; } && ibmNotifierARRAY+=(-secondary_accessory_view_type dropdown -secondary_accessory_view_payload "/title $dialogRestartOrDeferDeferMenuTitleIBM /list $menuDisplayTEXT /selected 0")
			{ [[ -z $menuDeferSECONDS ]] && [[ -n $displayTimeoutSECONDS ]]; } && ibmNotifierARRAY+=(-secondary_accessory_view_type timer -secondary_accessory_view_payload "$displayTimeoutTEXT %@" -timeout "$displayTimeoutSECONDS")
			if [[ -n $menuDeferSECONDS ]] && [[ -n $displayTimeoutSECONDS ]]; then
				sendToLog "Warning: Unable to show display timeout countdown due to the custom display accessory option. However, there is still a display timeout at $displayTimeoutSECONDS seconds."
				ibmNotifierARRAY+=(-secondary_accessory_view_type dropdown -secondary_accessory_view_payload "/title $dialogRestartOrDeferDeferMenuTitleIBM /list $menuDisplayTEXT /selected 0" -timeout "$displayTimeoutSECONDS")
			fi
		fi
	else # No custom display accessory.
		if [[ -n $secureAccessoryPAYLOAD ]]; then
			ibmNotifierARRAY+=(-accessory_view_type secureinput -accessory_view_payload "$secureAccessoryPAYLOAD" -timeout "$displayTimeoutSECONDS")
		else
			{ [[ -n $menuDeferSECONDS ]] && [[ -z $displayTimeoutSECONDS ]]; } && ibmNotifierARRAY+=(-accessory_view_type dropdown -accessory_view_payload "/title $dialogRestartOrDeferDeferMenuTitleIBM /list $menuDisplayTEXT /selected 0")
			{ [[ -z $menuDeferSECONDS ]] && [[ -n $displayTimeoutSECONDS ]]; } && ibmNotifierARRAY+=(-accessory_view_type timer -accessory_view_payload "$displayTimeoutTEXT %@" -timeout "$displayTimeoutSECONDS")
			{ [[ -n $displayTimeoutSECONDS ]] && [[ -n $menuDeferSECONDS ]]; } && ibmNotifierARRAY+=(-accessory_view_type dropdown -accessory_view_payload "/title $dialogRestartOrDeferDeferMenuTitleIBM /list $menuDisplayTEXT /selected 0" -secondary_accessory_view_type timer -secondary_accessory_view_payload "$displayTimeoutTEXT %@" -timeout "$displayTimeoutSECONDS")
		fi
	fi
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: userAuthMODE is: $userAuthMODE"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: ibmNotifierARRAY[] is:\n${ibmNotifierARRAY[*]}"
	dialogRESULT=$("$ibmNotifierBINARY" "${ibmNotifierARRAY[@]}")
	dialogRETURN="$?"
	{ [[ "$verboseModeOPTION" == "TRUE" ]] && [[ "$userAuthMODE" != "TRUE" ]]; } && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: dialogRESULT is: $dialogRESULT"
	{ [[ "$verboseModeOPTION" == "TRUE" ]] && [[ "$userAuthMODE" == "TRUE" ]]; } && sendToEcho "Verbose Mode: Function ${FUNCNAME[0]}: dialogRESULT is: $dialogRESULT"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: dialogRETURN is: $dialogRETURN"
fi
}

# Open $jamfHELPER for interactive dialogs using the $jamfHelperARRAY[] options, and also handle any $displayTimeoutSECONDS and $displayRedrawSECONDS options.
openDialogJamfHelper() {
# Kill any previous notifications so new ones can take its place.
kill -9 "$notifyPID" > /dev/null 2>&1
killall -9 "jamfHelper" > /dev/null 2>&1

unset dialogRESULT
unset dialogRETURN
if [[ -n $displayRedrawSECONDS ]]; then
	[[ -n $displayTimeoutSECONDS ]] && displayTimeoutSECONDS=$((displayTimeoutSECONDS-1))
	jamfHelperBackupARRAY=("${jamfHelperARRAY[@]}")
	while [[ -z $dialogRESULT ]]; do
		[[ -n $displayTimeoutSECONDS ]] && jamfHelperARRAY+=(-timeout "$displayTimeoutSECONDS" -countdown)
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfHelperARRAY[] is:\n${jamfHelperARRAY[*]}"
		(sleep "$displayRedrawSECONDS"; killall -9 "jamfHelper") &
		killerPID=$!
		disown
		dialogRESULT=$("$jamfHELPER" "${jamfHelperARRAY[@]}")
		dialogRETURN="$?"
		kill -0 "$killerPID" && kill -9 "$killerPID" > /dev/null 2>&1
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: dialogRESULT is: $dialogRESULT"
		[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: dialogRETURN is: $dialogRETURN"
		[[ -n $displayTimeoutSECONDS ]] && displayTimeoutSECONDS=$((displayTimeoutSECONDS - displayRedrawSECONDS))
		jamfHelperARRAY=("${jamfHelperBackupARRAY[@]}")
	done
else
	[[ -n $displayTimeoutSECONDS ]] && jamfHelperARRAY+=(-timeout "$displayTimeoutSECONDS" -countdown)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfHelperARRAY[] is:\n${jamfHelperARRAY[*]}"
	dialogRESULT=$("$jamfHELPER" "${jamfHelperARRAY[@]}")
	dialogRETURN="$?"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: dialogRESULT is: $dialogRESULT"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: dialogRETURN is: $dialogRETURN"
fi
}

# MARK: *** Install Now Notifications ***
################################################################################

# Display a non-interactive notification informing the user that the install now workflow has started.
notifyInstallNowStart() {
setDisplayLanguage
if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	sendToLog "IBM Notifier: Opening install now start notification..."
	ibmNotifierARRAY=(-type popup -always_on_top -position top_right -bar_title "$notifyInstallNowStartTITLE" -subtitle "$notifyInstallNowStartBodyIBM" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -accessory_view_type progressbar -accessory_view_payload "/percent indeterminate")
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: ibmNotifierARRAY[] is:\n${ibmNotifierARRAY[*]}"
	openNotifyIbmNotifier
else
	sendToLog "jamfHelper: Opening install now start notification..."
	jamfHelperARRAY=(-windowType hud -windowPosition ur -lockHUD -title "$notifyInstallNowStartTITLE" -description "$notifyInstallNowStartBodyJAMF" -icon "$cachedICON" -iconSize "$jamfHelperIconSIZE")
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfHelperARRAY[] is:\n${jamfHelperARRAY[*]}"
	openNotifyJamfHelper
fi
}

# Display a non-interactive notification informing the user that the install now workflow is downloading the macOS update/upgrade.
notifyInstallNowDownload() {
setDisplayLanguage
if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	sendToLog "IBM Notifier: Opening install now downloading notification..."
	ibmNotifierARRAY=(-type popup -always_on_top -position top_right -bar_title "$notifyInstallNowDownloadTITLE" -subtitle "$notifyInstallNowDownloadBodyIBM" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -accessory_view_type progressbar -accessory_view_payload "/percent indeterminate")
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: ibmNotifierARRAY[] is:\n${ibmNotifierARRAY[*]}"
	openNotifyIbmNotifier
else
	sendToLog "jamfHelper: Opening install now downloading notification..."
	jamfHelperARRAY=(-windowType hud -windowPosition ur -lockHUD -title "$notifyInstallNowDownloadTITLE" -description "$notifyInstallNowDownloadBodyJAMF" -icon "$cachedICON" -iconSize "$jamfHelperIconSIZE")
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfHelperARRAY[] is:\n${jamfHelperARRAY[*]}"
	openNotifyJamfHelper
fi
}

# Display a non-interactive notification informing the user that macOS is up to date.
notifyInstallNowUpToDate() {
setDisplayLanguage
if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	sendToLog "IBM Notifier: Opening install now up to date notification..."
	ibmNotifierARRAY=(-type popup -always_on_top -position top_right -bar_title "$notifyInstallNowUpToDateTITLE" -subtitle "$notifyInstallNowUpToDateBodyIBM" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -main_button_label "$okButtonDISPLAY")
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: ibmNotifierARRAY[] is:\n${ibmNotifierARRAY[*]}"
	openNotifyIbmNotifier
else
	sendToLog "jamfHelper: Opening install now up to date notification..."
	jamfHelperARRAY=(-windowType hud -windowPosition ur -lockHUD -title "$notifyInstallNowUpToDateTITLE" -description "$notifyInstallNowUpToDateBodyJAMF" -icon "$cachedICON" -iconSize "$jamfHelperIconSIZE" -button1 "$okButtonDISPLAY" -defaultButton 1)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfHelperARRAY[] is:\n${jamfHelperARRAY[*]}"
	openNotifyJamfHelper
fi
}

# Display a non-interactive notification informing the user that the install now workflow has failed.
notifyInstallNowFailure() {
setDisplayLanguage
if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	sendToLog "IBM Notifier: Opening install now failure notification..."
	ibmNotifierARRAY=(-type popup -always_on_top -position top_right -bar_title "$notifyInstallNowFailureTITLE" -subtitle "$notifyInstallNowFailureBodyIBM" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -main_button_label "$okButtonDISPLAY")
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: ibmNotifierARRAY[] is:\n${ibmNotifierARRAY[*]}"
	openNotifyIbmNotifier
else
	sendToLog "jamfHelper: Opening install now failure notification..."
	jamfHelperARRAY=(-windowType hud -windowPosition ur -lockHUD -title "$notifyInstallNowFailureTITLE" -description "$notifyInstallNowFailureBodyJAMF" -icon "$cachedICON" -iconSize "$jamfHelperIconSIZE" -button1 "$okButtonDISPLAY" -defaultButton 1)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfHelperARRAY[] is:\n${jamfHelperARRAY[*]}"
	openNotifyJamfHelper
fi
}

# MARK: *** Default Workflow Notifications ***
################################################################################

# Display a non-interactive notification informing the user there is insufficient free space for a macOS update/upgrade.
notifyStorage() {
sendToLog "Warning: Current available storage is at $availableStorageGB GBs which is below the $requiredStorageGB GBs that is required for macOS update/upgrade workflow."
sendToStatus "Running: Notification insufficient free space."
workflowTimeoutSECONDS=$freeSpaceTimeoutSECONDS
setDisplayLanguage

# The initial $ibmNotifierARRAY[] settings for the insufficient free space notification.
ibmNotifierARRAY=(-type popup -always_on_top -bar_title "$notifyStorageTITLE" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -accessory_view_type progressbar -accessory_view_payload "/percent indeterminate")

# The initial $jamfHelperARRAY[] settings for the insufficient free space notification.
jamfHelperARRAY=(-windowType hud -lockHUD -title "$notifyStorageTITLE" -icon "$cachedICON" -iconSize "$jamfHelperIconSIZE")

# Variations for the main body text of the insufficient free space notification.
if [[ "$deadlineDateSTATUS" == "SOFT" ]] || [[ "$deadlineDateSTATUS" == "HARD" ]]; then
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Date deadline insufficient free space notification with a $workflowTimeoutSECONDS second timeout."
		ibmNotifierARRAY+=(-subtitle "$notifyStorageBodyDeadlineDateIBM")
	else
		sendToLog "jamfHelper Notification: Date deadline insufficient free space notification with a $workflowTimeoutSECONDS second timeout."
		jamfHelperARRAY+=(-description "$notifyStorageBodyDeadlineDateJAMF")
	fi
elif [[ "$deadlineDaysSTATUS" == "SOFT" ]] || [[ "$deadlineDaysSTATUS" == "HARD" ]]; then
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Days deadline insufficient free space notification with a $workflowTimeoutSECONDS second timeout."
		ibmNotifierARRAY+=(-subtitle "$notifyStorageBodyDeadlineDaysIBM")
	else
		sendToLog "jamfHelper Notification: Days deadline insufficient free space notification with a $workflowTimeoutSECONDS second timeout."
		jamfHelperARRAY+=(-description "$notifyStorageBodyDeadlineDaysJAMF")
	fi
elif [[ "$deadlineCountSTATUS" == "SOFT" ]] || [[ "$deadlineCountSTATUS" == "HARD" ]]; then
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Count deadline insufficient free space notification with a $workflowTimeoutSECONDS second timeout."
		ibmNotifierARRAY+=(-subtitle "$notifyStorageBodyDeadlineCountIBM")
	else
		sendToLog "jamfHelper Notification: Count deadline insufficient free space notification with a $workflowTimeoutSECONDS second timeout."
		jamfHelperARRAY+=(-description "$notifyStorageBodyDeadlineCountJAMF")
	fi
else # No deadlines, this is the default insufficient free space notification.
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Default insufficient free space notification with a $workflowTimeoutSECONDS second timeout."
		ibmNotifierARRAY+=(-subtitle "$notifyStorageBodyDefaultIBM")
	else
		sendToLog "jamfHelper: Default insufficient free space notification with a $workflowTimeoutSECONDS second timeout."
		jamfHelperARRAY+=(-description "$notifyStorageBodyDefaultJAMF")
	fi
fi

# Open the appropriate storage assistant and the insufficient free space notification.
if [[ "$macOSMAJOR" -ge 13 ]]; then
	sendToLog "Status: Opening the Storage pane of the System Settings.app."
	sudo -u "$currentUserNAME" open "x-apple.systempreferences:com.apple.settings.Storage" &
else
	sendToLog "Status: Opening the Storage Management.app."
	sudo -u "$currentUserNAME" open "/System/Library/CoreServices/Applications/Storage Management.app" &
fi
if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	openNotifyIbmNotifier
else
	openNotifyJamfHelper
fi

# This handles the $freeSpaceTimeoutSECONDS and $displayRedrawSECONDS options while watching for available free space.
whileTimeoutSECONDS=$workflowTimeoutSECONDS
[[ -n $displayRedrawSECONDS ]] && redrawTimerSECONDS=0
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: storageRecheckSECONDS is: $storageRecheckSECONDS"
while [[ "$whileTimeoutSECONDS" -ge 0 ]]; do
	sleep "$storageRecheckSECONDS"
	checkAvailableStorage
	if [[ "$storageREADY" == "TRUE" ]]; then
		sendToLog "Status: Current available storage is now at $availableStorageGB GBs, the macOS update/upgrade workflow can continue."
		kill -9 "$notifyPID" > /dev/null 2>&1
		if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
			killall -9 "IBM Notifier" "IBM Notifier Popup" > /dev/null 2>&1
		else
			killall -9 "jamfHelper" > /dev/null 2>&1
		fi
		break
	fi
	if [[ -n $displayRedrawSECONDS ]]; then
		if [[ $redrawTimerSECONDS -ge $displayRedrawSECONDS ]]; then
			if [[ "$macOSMAJOR" -ge 13 ]]; then
				sudo -u "$currentUserNAME" open "x-apple.systempreferences:com.apple.settings.Storage" &
			else
				sudo -u "$currentUserNAME" open "/System/Library/CoreServices/Applications/Storage Management.app" &
			fi
			if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
				openNotifyIbmNotifier
			else
				openNotifyJamfHelper
			fi
			redrawTimerSECONDS=0
		else
			redrawTimerSECONDS=$((redrawTimerSECONDS+storageRecheckSECONDS))
		fi
	fi
	whileTimeoutSECONDS=$((whileTimeoutSECONDS-storageRecheckSECONDS))
done

# If there still is not sufficient free space, then exit.
if [[ "$storageREADY" == "FALSE" ]]; then
	if [[ "$installNowOPTION" == "TRUE" ]]; then
		sendToLog "Error: Waiting for user to make more free space available timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
		sendToStatus "Inactive Error: Waiting for user to make more free space available timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
		notifyInstallNowFailure
		errorExit
	else
		deferSECONDS="$errorDeferSECONDS"
		sendToLog "Error: Waiting for user to make more free space available timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
		sendToStatus "Pending: Waiting for user to make more free space available timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
		notifyFailure
		makeLaunchDaemonCalendar
	fi
fi
}

# Display a non-interactive notification informing the user they need to plug the computer into AC power.
notifyPower() {
sendToLog "Warning: Current battery level is at $currentBatteryLEVEL% which is below the minimum required level of $batteryLevelPERCENT%."
sendToStatus "Running: Notification AC power required."
workflowTimeoutSECONDS=$batteryTimeoutSECONDS
setDisplayLanguage

# The initial $ibmNotifierARRAY[] settings for the power required notification.
ibmNotifierARRAY=(-type popup -always_on_top -bar_title "$notifyPowerTITLE" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -accessory_view_type progressbar -accessory_view_payload "/percent indeterminate")

# The initial $jamfHelperARRAY[] settings for the power required notification.
jamfHelperARRAY=(-windowType hud -lockHUD -title "$notifyPowerTITLE" -icon "$cachedICON" -iconSize "$jamfHelperIconSIZE")

# Variations for the main body text of the power required notification.
if [[ "$deadlineDateSTATUS" == "SOFT" ]] || [[ "$deadlineDateSTATUS" == "HARD" ]]; then
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Date deadline power required notification with a $workflowTimeoutSECONDS second timeout."
		ibmNotifierARRAY+=(-subtitle "$notifyPowerBodyDeadlineDateIBM")
	else
		sendToLog "jamfHelper Notification: Date deadline power required notification with a $workflowTimeoutSECONDS second timeout."
		jamfHelperARRAY+=(-description "$notifyPowerBodyDeadlineDateJAMF")
	fi
elif [[ "$deadlineDaysSTATUS" == "SOFT" ]] || [[ "$deadlineDaysSTATUS" == "HARD" ]]; then
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Days deadline power required notification with a $workflowTimeoutSECONDS second timeout."
		ibmNotifierARRAY+=(-subtitle "$notifyPowerBodyDeadlineDaysIBM")
	else
		sendToLog "jamfHelper Notification: Days deadline power required notification with a $workflowTimeoutSECONDS second timeout."
		jamfHelperARRAY+=(-description "$notifyPowerBodyDeadlineDaysJAMF")
	fi
elif [[ "$deadlineCountSTATUS" == "SOFT" ]] || [[ "$deadlineCountSTATUS" == "HARD" ]]; then
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Count deadline power required notification with a $workflowTimeoutSECONDS second timeout."
		ibmNotifierARRAY+=(-subtitle "$notifyPowerBodyDeadlineCountIBM")
	else
		sendToLog "jamfHelper Notification: Count deadline power required notification with a $workflowTimeoutSECONDS second timeout."
		jamfHelperARRAY+=(-description "$notifyPowerBodyDeadlineCountJAMF")
	fi
else # No deadlines, this is the default power required notification.
	if [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Default power required notification with a $workflowTimeoutSECONDS second timeout."
		ibmNotifierARRAY+=(-subtitle "$notifyPowerBodyDefaultIBM")
	else
		sendToLog "jamfHelper: Default power required notification with a $workflowTimeoutSECONDS second timeout."
		jamfHelperARRAY+=(-description "$notifyPowerBodyDefaultJAMF")
	fi
fi

# Open the initial power required notification.
if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	openNotifyIbmNotifier
else
	openNotifyJamfHelper
fi

# This handles waiting for AC power along with the $batteryTimeoutSECONDS and $displayRedrawSECONDS options.
acPOWER="FALSE"
whileTimeoutSECONDS=$workflowTimeoutSECONDS
[[ -n $displayRedrawSECONDS ]] && redrawTimerSECONDS=0
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: powerRecheckSECONDS is: $powerRecheckSECONDS"
while [[ "$whileTimeoutSECONDS" -ge 0 ]]; do
	sleep "$powerRecheckSECONDS"
	[[ $(pmset -g ps | grep -ic 'AC Power') -ne 0 ]] && acPOWER="TRUE"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: acPOWER: $acPOWER"
	if [[ "$acPOWER" == "TRUE" ]]; then
		sendToLog "Status: AC power detected, the macOS update/upgrade workflow can continue."
		kill -9 "$notifyPID" > /dev/null 2>&1
		if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
			killall -9 "IBM Notifier" "IBM Notifier Popup" > /dev/null 2>&1
		else
			killall -9 "jamfHelper" > /dev/null 2>&1
		fi
		break
	fi
	if [[ -n $displayRedrawSECONDS ]]; then
		if [[ $redrawTimerSECONDS -ge $displayRedrawSECONDS ]]; then
			if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
				openNotifyIbmNotifier
			else
				openNotifyJamfHelper
			fi
			redrawTimerSECONDS=0
		else
			redrawTimerSECONDS=$((redrawTimerSECONDS+powerRecheckSECONDS))
		fi
	fi
	whileTimeoutSECONDS=$((whileTimeoutSECONDS-powerRecheckSECONDS))
done

# If there still is no AC power, then exit.
if [[ "$acPOWER" == "FALSE" ]]; then
	if [[ "$installNowOPTION" == "TRUE" ]]; then
		sendToLog "Error: Waiting for user to connect AC power timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
		sendToStatus "Inactive Error: Waiting for user to connect AC power timed out after $workflowTimeoutSECONDS seconds, install now workflow can not continue."
		notifyInstallNowFailure
		errorExit
	else
		deferSECONDS="$errorDeferSECONDS"
		sendToLog "Error: Waiting for user to connect AC power timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
		sendToStatus "Pending: Waiting for user to connect AC power timed out after $workflowTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
		notifyFailure
		makeLaunchDaemonCalendar
	fi
fi
}

# Display a non-interactive notification informing the user that an update/upgrade that requires preparation has started.
notifyPrepare() {
setDisplayLanguage

# The initial $ibmNotifierARRAY[] settings for the preparing update notification.
ibmNotifierARRAY=(-type popup -always_on_top -position top_right -bar_title "$notifyPrepTITLE" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -accessory_view_type progressbar -accessory_view_payload "/percent indeterminate")

# The initial $jamfHelperARRAY[] settings for the preparing update notification.
jamfHelperARRAY=(-windowType hud -windowPosition ur -lockHUD -title "$notifyPrepTITLE" -icon "$cachedICON" -iconSize "$jamfHelperIconSIZE")

# Variations for the main body text of the preparing update notification.
if [[ "$deadlineDateSTATUS" == "SOFT" ]] || [[ "$deadlineDateSTATUS" == "HARD" ]]; then
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Date deadline preparing update notification showing a $prepareTimeEstimateDISPLAY minute estimate."
		ibmNotifierARRAY+=(-subtitle "$notifyPrepBodyDeadlineDateIBM")
	else
		sendToLog "jamfHelper Notification: Date deadline preparing update notification showing a $prepareTimeEstimateDISPLAY minute estimate."
		jamfHelperARRAY+=(-description "$notifyPrepBodyDeadlineDateJAMF")
	fi
elif [[ "$deadlineDaysSTATUS" == "SOFT" ]] || [[ "$deadlineDaysSTATUS" == "HARD" ]]; then
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Days deadline preparing update notification showing a $prepareTimeEstimateDISPLAY minute estimate."
		ibmNotifierARRAY+=(-subtitle "$notifyPrepBodyDeadlineDaysIBM")
	else
		sendToLog "jamfHelper Notification: Days deadline preparing update notification showing a $prepareTimeEstimateDISPLAY minute estimate."
		jamfHelperARRAY+=(-description "$notifyPrepBodyDeadlineDaysJAMF")
	fi
elif [[ "$deadlineCountSTATUS" == "SOFT" ]] || [[ "$deadlineCountSTATUS" == "HARD" ]]; then
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Count deadline preparing update notification showing a $prepareTimeEstimateDISPLAY minute estimate."
		ibmNotifierARRAY+=(-subtitle "$notifyPrepBodyDeadlineCountIBM")
	else
		sendToLog "jamfHelper Notification: Count deadline preparing update notification showing a $prepareTimeEstimateDISPLAY minute estimate."
		jamfHelperARRAY+=(-description "$notifyPrepBodyDeadlineCountJAMF")
	fi
else # No deadlines, this is the default preparing update notification.
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Default preparing update notification showing a $prepareTimeEstimateDISPLAY minute estimate."
		ibmNotifierARRAY+=(-subtitle "$notifyPrepBodyDefaultIBM")
	else
		sendToLog "jamfHelper: Default preparing update notification showing a $prepareTimeEstimateDISPLAY minute estimate."
		jamfHelperARRAY+=(-description "$notifyPrepBodyDefaultJAMF")
	fi
fi

# Open notification in the background allowing super to continue.
if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	openNotifyIbmNotifier
else
	openNotifyJamfHelper
fi
}

# Display a non-interactive notification informing the user that the computer going to restart soon.
notifyRestart() {
setDisplayLanguage

# The initial $ibmNotifierARRAY[] settings for the restart notification.
ibmNotifierARRAY=(-type popup -always_on_top -position top_right -bar_title "$notifyRestartTITLE" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -accessory_view_type progressbar -accessory_view_payload "/percent indeterminate")

# The initial $jamfHelperARRAY[] settings for the restart notification.
jamfHelperARRAY=(-windowType hud -windowPosition ur -lockHUD -title "$notifyRestartTITLE" -icon "$cachedICON" -iconSize "$jamfHelperIconSIZE")

# Variations for the main body text of the restart notification.
if [[ "$deadlineDateSTATUS" == "SOFT" ]] || [[ "$deadlineDateSTATUS" == "HARD" ]]; then
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Date deadline restart soon notification."
		ibmNotifierARRAY+=(-subtitle "$notifyRestartBodyDeadlineDateIBM")
	else
		sendToLog "jamfHelper Notification: Date deadline restart soon notification."
		jamfHelperARRAY+=(-description "$notifyRestartBodyDeadlineDateJAMF")
	fi
elif [[ "$deadlineDaysSTATUS" == "SOFT" ]] || [[ "$deadlineDaysSTATUS" == "HARD" ]]; then
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Days deadline restart soon notification."
		ibmNotifierARRAY+=(-subtitle "$notifyRestartBodyDeadlineDaysIBM")
	else
		sendToLog "jamfHelper Notification: Days deadline restart soon notification."
		jamfHelperARRAY+=(-description "$notifyRestartBodyDeadlineDaysJAMF")
	fi
elif [[ "$deadlineCountSTATUS" == "SOFT" ]] || [[ "$deadlineCountSTATUS" == "HARD" ]]; then
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Count deadline restart soon notification."
		ibmNotifierARRAY+=(-subtitle "$notifyRestartBodyDeadlineCountIBM")
	else
		sendToLog "jamfHelper Notification: Count deadline restart soon notification."
		jamfHelperARRAY+=(-description "$notifyRestartBodyDeadlineCountJAMF")
	fi
else # No deadlines, this is the default restart notification.
	if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
		sendToLog "IBM Notifier: Default restart soon notification."
		ibmNotifierARRAY+=(-subtitle "$notifyRestartBodyDefaultIBM")
	else
		sendToLog "jamfHelper: Default restart soon notification."
		jamfHelperARRAY+=(-description "$notifyRestartBodyDefaultJAMF")
	fi
fi

# Open notification in the background allowing super to continue.
if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	openNotifyIbmNotifier
else
	openNotifyJamfHelper
fi
}

# Display a non-interactive notification informing the user that the install now workflow is installing recommended (non-system) software updates.
notifyRecommended() {
setDisplayLanguage
if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	sendToLog "IBM Notifier: Opening install now installing recommended (non-system) software updates notification..."
	ibmNotifierARRAY=(-type popup -always_on_top -position top_right -bar_title "$notifyRecommendedTITLE" -subtitle "$notifyRecommendedBodyIBM" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -accessory_view_type progressbar -accessory_view_payload "/percent indeterminate")
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: ibmNotifierARRAY[] is:\n${ibmNotifierARRAY[*]}"
	openNotifyIbmNotifier
else
	sendToLog "jamfHelper: Opening install now installing recommended (non-system) software updates notification..."
	jamfHelperARRAY=(-windowType hud -windowPosition ur -lockHUD -title "$notifyRecommendedTITLE" -description "$notifyRecommendedBodyJAMF" -icon "$cachedICON" -iconSize "$jamfHelperIconSIZE")
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfHelperARRAY[] is:\n${jamfHelperARRAY[*]}"
	openNotifyJamfHelper
fi
}

# Display a non-interactive notification informing the user that update process has failed.
notifyFailure() {
setDisplayLanguage
setDeferButton
if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	sendToLog "IBM Notifier: Opening update failure notification..."
	ibmNotifierARRAY=(-type popup -always_on_top -position top_right -bar_title "$notifyFailureTITLE" -subtitle "$notifyFailureBodyIBM" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -main_button_label "$deferButtonDISPLAY")
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: ibmNotifierARRAY[] is:\n${ibmNotifierARRAY[*]}"
	openNotifyIbmNotifier
else
	sendToLog "jamfHelper: Opening update failure notification..."
	jamfHelperARRAY=(-windowType hud -windowPosition ur -lockHUD -title "$notifyFailureTITLE" -description "$notifyFailureBodyJAMF" -icon "$cachedICON" -iconSize "$jamfHelperIconSIZE" -button1 "$deferButtonDISPLAY" -defaultButton 1)
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfHelperARRAY[] is:\n${jamfHelperARRAY[*]}"
	openNotifyJamfHelper
fi
}

# MARK: *** Interactive Dialogs ***
################################################################################

# Display an interactive dialog with restart and deferral options. This sets $choiceINSTALL and if $menuDeferSECONDS then also sets $defaultDeferSECONDS.
dialogRestartOrDefer() {
setDisplayLanguage
sendToStatus "Running: Dialog restart or defer."
[[ -n $deferDialogTimeoutSECONDS ]] && displayTimeoutSECONDS=$deferDialogTimeoutSECONDS

if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	[[ -n $deferDialogTimeoutSECONDS ]] && sendToLog "IBM Notifier: Ask for restart or defer dialog with a $displayTimeoutSECONDS second timeout."
	[[ -z $deferDialogTimeoutSECONDS ]] && sendToLog "IBM Notifier: Ask for restart or defer dialog with no timeout."
	# Create initial $ibmNotifierARRAY[] settings for the dialog.
	ibmNotifierARRAY=(-type popup -always_on_top -bar_title "$dialogRestartOrDeferTITLE" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -secondary_button_label "$restartButtonDISPLAY")
	
	# Body text variations based on deadline options.
	if [[ -n "$deadlineDISPLAY" ]] && [[ -n "$countDISPLAY" ]]; then # Show both date and maximum deferral count deadlines.
		ibmNotifierARRAY+=(-subtitle "$dialogRestartOrDeferBodyDateCountIBM")
	elif [[ -n "$deadlineDISPLAY" ]]; then # Show only date deadline.
		ibmNotifierARRAY+=(-subtitle "$dialogRestartOrDeferBodyDateIBM")
	elif [[ -n "$countDISPLAY" ]]; then # Show only maximum deferral count deadline.
		ibmNotifierARRAY+=(-subtitle "$dialogRestartOrDeferBodyCountIBM")
	else # Show no deadlines.
		ibmNotifierARRAY+=(-subtitle "$dialogRestartOrDeferBodyUnlimitedIBM")
	fi
	displayTimeoutTEXT="$dialogRestartOrDeferTimeoutIBM"
	
	# If needed, handle the $menuDeferSECONDS option and set $menuDisplayTEXT.
	if [[ -n $menuDeferSECONDS ]]; then
		oldIFS="$IFS"; IFS=','
		read -r -a menuDeferSecondsARRAY <<< "$menuDeferSECONDS"
		read -r -a menuDeferDisplayARRAY <<< "$menuDeferSECONDS"
		for i in "${!menuDeferDisplayARRAY[@]}"; do
			if [[ ${menuDeferDisplayARRAY[i]} -lt 3600 ]]; then
				menuDeferDisplayARRAY[i]="$((menuDeferDisplayARRAY[i] / 60)) $dialogRestartOrDeferMinutesDISPLAY"
			elif [[ ${menuDeferDisplayARRAY[i]} -eq 3600 ]]; then
				menuDeferDisplayARRAY[i]="1 $dialogRestartOrDeferHourDISPLAY"
			elif [[ ${menuDeferDisplayARRAY[i]} -gt 3600 ]] && [[ ${menuDeferDisplayARRAY[i]} -lt 7200 ]]; then
				menuDeferDisplayARRAY[i]="1 $dialogRestartOrDeferHourDISPLAY $((menuDeferDisplayARRAY[i] % 3600 / 60)) $dialogRestartOrDeferMinutesDISPLAY"
			elif [[ ${menuDeferDisplayARRAY[i]} -ge 7200 ]] && [[ ${menuDeferDisplayARRAY[i]} -lt 86400 ]] && [[ $((menuDeferDisplayARRAY[i] % 3600)) -eq 0 ]]; then
				menuDeferDisplayARRAY[i]="$((menuDeferDisplayARRAY[i] / 3600)) $dialogRestartOrDeferHoursDISPLAY"
			elif [[ ${menuDeferDisplayARRAY[i]} -gt 7200 ]] && [[ ${menuDeferDisplayARRAY[i]} -lt 86400 ]] && [[ $((menuDeferDisplayARRAY[i] % 3600)) -ne 0 ]]; then
				menuDeferDisplayARRAY[i]="$((menuDeferDisplayARRAY[i] / 3600)) $dialogRestartOrDeferHoursDISPLAY $((menuDeferDisplayARRAY[i] % 3600 / 60)) $dialogRestartOrDeferMinutesDISPLAY"
			elif [[ ${menuDeferDisplayARRAY[i]} -eq 86400 ]]; then
				menuDeferDisplayARRAY[i]="1 $dialogRestartOrDeferDayDISPLAY"
			fi
		done
		IFS=$'\n'
		menuDisplayTEXT="${menuDeferDisplayARRAY[*]}"
		IFS="$oldIFS"
	else # Instead, add a defer button containing the text based off $defaultDeferSECONDS time.
		deferSECONDS="$defaultDeferSECONDS"
		setDeferButton
	fi
	ibmNotifierARRAY+=(-main_button_label "$deferButtonDISPLAY")
	
	# Start the dialog.
	openDialogIbmNotifier

	# The $dialogRETURN contains the IBM Notifier.app return code. If $menuDeferSECONDS was enabled then set $deferSECONDS.
	case "$dialogRETURN" in
		0)
			choiceINSTALL="FALSE"
			if [[ -n $menuDeferSECONDS ]]; then
				deferSECONDS="${menuDeferSecondsARRAY[$dialogRESULT]}"
				sendToLog "Status: User chose to defer update for $deferSECONDS seconds."
				sendToStatus "Pending: User chose to defer update for $deferSECONDS seconds."
			else
				deferSECONDS="$defaultDeferSECONDS"
				sendToLog "Status: User chose to defer update, using the default defer of $deferSECONDS seconds."
				sendToStatus "Pending: User chose to defer update, using the default defer of $deferSECONDS seconds."
			fi
		;;
		4|255)
			choiceINSTALL="FALSE"
			if [[ -n $menuDeferSECONDS ]]; then
				deferSECONDS="${menuDeferSecondsARRAY[$dialogRESULT]}"
				sendToLog "Status: Display timeout automatically chose to defer update for $deferSECONDS seconds."
				sendToStatus "Pending: Display timeout automatically chose to defer update for $deferSECONDS seconds."
			else
				deferSECONDS="$defaultDeferSECONDS"
				sendToLog "Status: Display timeout automatically chose to defer update, using the default defer of $deferSECONDS seconds."
				sendToStatus "Pending: Display timeout automatically chose to defer update, using the default defer of $deferSECONDS seconds."
			fi
		;;
		2)
			sendToLog "Status: User chose to restart now."
			choiceINSTALL="TRUE"
		;;
	esac
else
	[[ -n $deferDialogTimeoutSECONDS ]] && sendToLog "jamfHelper: Ask for restart or defer dialog with a $displayTimeoutSECONDS second timeout."
	[[ -z $deferDialogTimeoutSECONDS ]] && sendToLog "jamfHelper: Ask for restart or defer dialog with no timeout."
	# Create initial $jamfHelperARRAY[] settings for the dialog.
	jamfHelperARRAY=(-windowType utility -title "$dialogRestartOrDeferTITLE" -icon "$cachedICON" -iconSize "$jamfHelperIconSIZE" -button1 "$deferButtonDISPLAY" -button2 "$restartButtonDISPLAY" -defaultButton 1 -cancelButton 2)

	# Body text variations based on deadline options. Note that any invisible characters (tabs and new line) are "shown" in the jamfHelper dialog.
	if [[ -n "$deadlineDISPLAY" ]] && [[ -n "$countDISPLAY" ]]; then # Show both date and maximum deferral count deadlines.
		jamfHelperARRAY+=(-description "$dialogRestartOrDeferBodyDateCountJAMF")
	elif [[ -n "$deadlineDISPLAY" ]]; then # Show only date deadline.
		jamfHelperARRAY+=(-description "$dialogRestartOrDeferBodyDateJAMF")
	elif [[ -n "$countDISPLAY" ]]; then # Show only maximum deferral count deadline.
		jamfHelperARRAY+=(-description "$dialogRestartOrDeferBodyCountJAMF")
	else # Show no deadlines.
		jamfHelperARRAY+=(-description "$dialogRestartOrDeferBodyUnlimitedJAMF")
	fi

	# If needed, add the $menuDeferSECONDS option to the $jamfHelperARRAY[].
	if [[ -n $menuDeferSECONDS ]]; then
		menuDeferSECONDS=$(echo "$menuDeferSECONDS" | sed 's/,/, /g')
		jamfHelperARRAY+=(-showDelayOptions "$menuDeferSECONDS")
	fi

	# Start the dialog.
	openDialogJamfHelper

	# The $dialogRESULT contains the user's selection; "0" or "1" for deferral and "2" for restart. If $menuDeferSECONDS was enabled then set $deferSECONDS.
	case "$dialogRESULT" in
		0 | 1 | *1)
			choiceINSTALL="FALSE"
			if [[ -n $menuDeferSECONDS ]]; then
				deferSECONDS=$(echo "$dialogRESULT" | sed 's/.$//')
				sendToLog "Status: User or display timeout chose to defer update for $deferSECONDS seconds."
				sendToStatus "Pending: User or display timeout chose to defer update for $deferSECONDS seconds."
			else
				deferSECONDS="$defaultDeferSECONDS"
				sendToLog "Status: User or display timeout chose to defer update, using the default defer of $deferSECONDS seconds."
				sendToStatus "Pending: User or display timeout chose to defer update, using the default defer of $deferSECONDS seconds."
			fi
		;;
		*2)
			sendToLog "Status: User chose to restart now."
			choiceINSTALL="TRUE"
		;;
	esac
fi
}

# Display an interactive dialog when a soft deadline has passed, giving the user only one button to continue the workflow.
dialogSoftDeadline() {
setDisplayLanguage
sendToStatus "Running: Dialog soft deadline."
[[ -n $softDialogTimeoutSECONDS ]] && displayTimeoutSECONDS=$softDialogTimeoutSECONDS

if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
	# The initial $ibmNotifierARRAY[] settings for the soft deadline dialog.
	ibmNotifierARRAY=(-type popup -always_on_top -bar_title "$dialogSoftDeadlineTITLE" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -main_button_label "$restartButtonDISPLAY")

	# Variations for the main body text of the soft deadline dialog.
	if [[ "$deadlineDateSTATUS" == "SOFT" ]]; then
		[[ -n $softDialogTimeoutSECONDS ]] && sendToLog "IBM Notifier: soft date deadline dialog with a $displayTimeoutSECONDS second timeout."
		[[ -z $softDialogTimeoutSECONDS ]] && sendToLog "IBM Notifier: soft date deadline dialog with no timeout."
		ibmNotifierARRAY+=(-subtitle "$dialogSoftDeadlineBodyDateIBM")
	elif [[ "$deadlineDaysSTATUS" == "SOFT" ]]; then
		[[ -n $softDialogTimeoutSECONDS ]] && sendToLog "IBM Notifier: soft days deadline dialog with a $displayTimeoutSECONDS second timeout."
		[[ -z $softDialogTimeoutSECONDS ]] && sendToLog "IBM Notifier: soft days deadline dialog with no timeout."
		ibmNotifierARRAY+=(-subtitle "$dialogSoftDeadlineBodyDaysIBM")
	elif [[ "$deadlineCountSTATUS" == "SOFT" ]]; then
		[[ -n $softDialogTimeoutSECONDS ]] && sendToLog "IBM Notifier: soft count deadline dialog with a $displayTimeoutSECONDS second timeout."
		[[ -z $softDialogTimeoutSECONDS ]] && sendToLog "IBM Notifier: soft count deadline dialog with no timeout."
		ibmNotifierARRAY+=(-subtitle "$dialogSoftDeadlineBodyCountIBM")
	fi
	displayTimeoutTEXT="$dialogSoftDeadlineTimeoutIBM"
	
	# Start the dialog.
	unset menuDeferSECONDS
	openDialogIbmNotifier

	# The $dialogRETURN contains the IBM Notifier.app return code.
	case "$dialogRETURN" in
		0)
			sendToLog "Status: User chose to restart."
		;;
		255)
			sendToLog "Status: Display timeout automatically chose to restart."
		;;
	esac
else
	# The initial $jamfHelperARRAY[] settings for the soft deadline dialog.
	jamfHelperARRAY=(-windowType utility -title "$dialogSoftDeadlineTITLE" -icon "$cachedICON" -iconSize "$jamfHelperIconSIZE" -button1 "$restartButtonDISPLAY" -defaultButton 1)

	# Variations for the main body text of the soft deadline dialog
	if [[ "$deadlineDateSTATUS" == "SOFT" ]]; then
		[[ -n $softDialogTimeoutSECONDS ]] && sendToLog "jamfHelper: soft date deadline dialog with a $displayTimeoutSECONDS second timeout."
		[[ -z $softDialogTimeoutSECONDS ]] && sendToLog "jamfHelper: soft date deadline dialog with no timeout."
		jamfHelperARRAY+=(-description "$dialogSoftDeadlineBodyDateJAMF")
	elif [[ "$deadlineDaysSTATUS" == "SOFT" ]]; then
		[[ -n $softDialogTimeoutSECONDS ]] && sendToLog "jamfHelper: soft days deadline dialog with a $displayTimeoutSECONDS second timeout."
		[[ -z $softDialogTimeoutSECONDS ]] && sendToLog "jamfHelper: soft days deadline dialog with no timeout."
		jamfHelperARRAY+=(-description "$dialogSoftDeadlineBodyDaysJAMF")
	elif [[ "$deadlineCountSTATUS" == "SOFT" ]]; then
		[[ -n $softDialogTimeoutSECONDS ]] && sendToLog "jamfHelper: soft count deadline dialog with a $displayTimeoutSECONDS second timeout."
		[[ -z $softDialogTimeoutSECONDS ]] && sendToLog "jamfHelper: soft count deadline dialog with no timeout."
		jamfHelperARRAY+=(-description "$dialogSoftDeadlineBodyCountJAMF")
	fi

	# Start the dialog.
	openDialogJamfHelper
	sendToLog "Status: User or display timeout accepted soft deadline dialog."
fi
}

# Display an interactive IBM Notifier dialog to collect user credentials for macOS update/upgrade workflow.
dialogUserAuth() {
# Check to make sure the current user is a valid volume owner.
if [[ "$currentUserVolumeOWNER" == "FALSE" ]]; then
	if [[ "$installNowOPTION" == "TRUE" ]]; then
		sendToLog "Error: Current user \"$currentUserNAME\" is not a volume owner, install now workflow can not continue."
		sendToStatus "Inactive Error: Current user \"$currentUserNAME\" is not a volume owner, install now workflow can not continue."
		notifyInstallNowFailure
		errorExit
	else
		deferSECONDS="$errorDeferSECONDS"
		sendToLog "Error: Current user \"$currentUserNAME\" is not a volume owner, trying again in $deferSECONDS seconds."
		sendToStatus "Pending: Current user \"$currentUserNAME\" is not a volume owner, trying again in $deferSECONDS seconds."
		kickSoftwareUpdateD
		makeLaunchDaemonCalendar
	fi
fi

# The initial $ibmNotifierARRAY[] and variations for the main body text for the user authentication dialog.
setDisplayLanguage
sendToStatus "Running: Dialog user authentication."
displayTimeoutSECONDS=$userAuthTimeoutSECONDS
ibmNotifierARRAY=(-type popup -always_on_top -bar_title "$dialogUserAuthTITLE" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -main_button_label "$restartButtonDISPLAY")
if [[ "$deadlineDateSTATUS" == "SOFT" ]] || [[ "$deadlineDateSTATUS" == "HARD" ]]; then
	sendToLog "IBM Notifier: Date deadline user authentication dialog with a $displayTimeoutSECONDS second timeout."
	ibmNotifierARRAY+=(-subtitle "$dialogUserAuthDeadlineDateBODY")
elif [[ "$deadlineDaysSTATUS" == "SOFT" ]]; then
	sendToLog "IBM Notifier: Soft days deadline user authentication dialog with a $displayTimeoutSECONDS second timeout."
	ibmNotifierARRAY+=(-subtitle "$dialogUserAuthDeadlineSoftDaysBODY")
elif [[ "$deadlineDaysSTATUS" == "HARD" ]]; then
	sendToLog "IBM Notifier: Hard days deadline user authentication dialog with a $displayTimeoutSECONDS second timeout."
	ibmNotifierARRAY+=(-subtitle "$dialogUserAuthDeadlineHardDaysBODY")
elif [[ "$deadlineCountSTATUS" == "SOFT" ]] || [[ "$deadlineCountSTATUS" == "HARD" ]]; then
	sendToLog "IBM Notifier: Count deadline user authentication dialog with a $displayTimeoutSECONDS second timeout."
	ibmNotifierARRAY+=(-subtitle "$dialogUserAuthDeadlineCountBODY")
else # No deadlines, this is the default user authentication dialog.
	sendToLog "IBM Notifier: Default user authentication dialog with a $displayTimeoutSECONDS second timeout."
	ibmNotifierARRAY+=(-subtitle "$dialogUserAuthDefaultBODY")
fi
secureAccessoryPAYLOAD="/title $dialogUserAuthPassTITLE /placeholder $dialogUserAuthPassPLACEHOLDER /required"

# Open the user authentication dialog including handling of the $userAuthTimeoutSECONDS and user password validation.
if [[ -n $displayAccessoryUserAuthCONTENT ]]; then
	[[ -n $displayAccessoryCONTENT ]] && displayAccessoryBackupCONTENT="$displayAccessoryCONTENT"
	displayAccessoryCONTENT="$displayAccessoryUserAuthCONTENT"
fi
userAuthMODE="TRUE"
userAuthREADY="FALSE"
userAuthATTEMPT=0
while [[ $displayTimeoutSECONDS -ge 0 ]]; do
	if [[ $userAuthATTEMPT -eq 1 ]]; then
		# Re-create $ibmNotifierARRAY[] settings for the user authentication dialog when the user authentication fails.
		ibmNotifierARRAY=(-type popup -always_on_top -bar_title "$dialogUserAuthTITLE" -icon_path "$cachedICON" -icon_width "$ibmNotifierIconSIZE" -icon_height "$ibmNotifierIconSIZE" -main_button_label "$restartButtonDISPLAY")
		if [[ "$deadlineDateSTATUS" == "SOFT" ]] || [[ "$deadlineDateSTATUS" == "HARD" ]]; then
			ibmNotifierARRAY+=(-subtitle "$dialogUserAuthRetryDeadlineDateBODY")
		elif [[ "$deadlineDaysSTATUS" == "SOFT" ]]; then
			ibmNotifierARRAY+=(-subtitle "$dialogUserAuthRetryDeadlineSoftDaysBODY")
		elif [[ "$deadlineDaysSTATUS" == "HARD" ]]; then
			ibmNotifierARRAY+=(-subtitle "$dialogUserAuthRetryDeadlineHardDaysBODY")
		elif [[ "$deadlineCountSTATUS" == "SOFT" ]] || [[ "$deadlineCountSTATUS" == "HARD" ]]; then
			ibmNotifierARRAY+=(-subtitle "$dialogUserAuthRetryDeadlineCountBODY")
		else # No deadlines, this is the default user authentication dialog.
			ibmNotifierARRAY+=(-subtitle "$dialogUserAuthRetryDefaultBODY")
		fi
		secureAccessoryPAYLOAD="/title $dialogUserAuthRetryPassTITLE /placeholder $dialogUserAuthRetryPassPLACEHOLDER /required"
	fi
	openDialogIbmNotifier
	((userAuthATTEMPT++))
	if [[ $dialogRETURN -eq 0 ]]; then
		if [[ "$(dscl /Local/Default -authonly "$currentUserNAME" "$dialogRESULT" 2>&1)" == "" ]]; then
			installACCOUNT="$currentUserNAME"
			installPASSWORD="$dialogRESULT"
			userAuthREADY="TRUE"
			break
		fi
	else
		break
	fi
done
if [[ -n $displayAccessoryBackupCONTENT ]]; then
	displayAccessoryCONTENT="$displayAccessoryBackupCONTENT"
else
	unset displayAccessoryCONTENT
fi
unset userAuthMODE

# If user authentication was successful then evaluate option to fix bootstrap token.
if [[ "$userAuthREADY" == "TRUE" ]]; then
	sendToLog "Status: Current user \"$currentUserNAME\" credentials verified."
	if [[ "$mdmENROLLED" == "TRUE" ]] && [[ "$bootstrapTOKEN" != "TRUE" ]] && { [[ "$userAuthMDMFAILOVER" == "TRUE" ]] || [[ "$userAuthMDMFailoverBOOTSTRAP" == "TRUE" ]]; }; then
		attemptBootstrapFIX="TRUE"
		if [[ "$currentUserADMIN" == "FALSE" ]]; then
			sendToLog "Warning: Local user account \"$currentUserNAME\" can not be used to escrow bootstrap token because they are not a local admin."
			attemptBootstrapFIX="FALSE"
		fi
		if [[ "$currentUserSecureTOKEN" == "FALSE" ]]; then
			sendToLog "Warning: Local user account \"$currentUserNAME\" can not be used to escrow bootstrap token because they do not have a secure token."
			attemptBootstrapFIX="FALSE"
		fi
		if [[ "$mdmSERVICE" == "FALSE" ]]; then
			sendToLog "Warning: Can not escrow bootstrap token because the MDM service is not available."
			attemptBootstrapFIX="FALSE"
		fi
		if [[ "$attemptBootstrapFIX" == "TRUE" ]]; then
			sendToLog "Status: Attempting to use the credentials from user \"$currentUserNAME\" to escrow bootstrap token..."
			commandRESULT=$(profiles install -type bootstraptoken -user "$currentUserNAME" -password "$installPASSWORD" 2>&1)
			[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: commandRESULT is: $commandRESULT"
			checkBootstrapToken
		fi
	fi
else # The user authentication dialog timed out.
	if [[ "$installNowOPTION" == "TRUE" ]]; then
		sendToLog "Error: Waiting for user authentication timed out after $displayTimeoutSECONDS seconds, install now workflow can not continue."
		sendToStatus "Inactive Error: Waiting for user authentication timed out after $displayTimeoutSECONDS seconds, install now workflow can not continue."
		notifyInstallNowFailure
		errorExit
	else
		deferSECONDS="$errorDeferSECONDS"
		sendToLog "Error: Waiting for user authentication timed out after $displayTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
		sendToStatus "Pending: Waiting for user authentication timed out after $displayTimeoutSECONDS seconds, trying again in $deferSECONDS seconds."
		notifyFailure
		makeLaunchDaemonCalendar
	fi
fi
}

# MARK: *** Main Workflow ***
################################################################################

mainWorkflow() {
# Initial super workflow preparations.
checkRoot
setDefaults
superInstallation
getOptions "$@"
superStartup "$@"

# If restarting from a macOS update/upgrade this workflow starts before all others.
if [[ "$restartVALIDATE" == "TRUE" ]]; then 
	sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION RESTART VALIDATION ****"
	sendToStatus "Running: macOS update/upgrade restart validation."
	checkAfterRestart
fi

# If requested then restart counters.
[[ "$restartDAYS" == "TRUE" ]] && restartZeroDay
[[ "$restartCOUNTS" == "TRUE" ]] && restartDeferralCounters

# Prepare for alternate self-service workflow modes.
[[ "$testModeOPTION" == "TRUE" ]] && sendToLog "Startup: Test mode enabled with $testModeTimeoutSECONDS second timeout."
if [[ "$installNowOPTION" == "TRUE" ]]; then
	sendToLog "Startup: Install now mode enabled."
	notifyInstallNowStart
	if [[ "$testModeOPTION" == "TRUE" ]]; then
		sendToLog "Test Mode: Pausing $testModeTimeoutSECONDS seconds for the install now start notification..."
		sleep "$testModeTimeoutSECONDS"
	fi
elif [[ "$onlyDownloadOPTION" == "TRUE" ]]; then
	sendToLog "Startup: Only download mode enabled."
fi
[[ -n $policyTRIGGERS ]] && sendToLog "Startup: Jamf Pro Policy triggers: $policyTRIGGERS"
[[ "$restartWithoutUpdatesOPTION" == "TRUE" ]] && sendToLog "Warning: Restart without updates option is enabled, this computer will restart if there is no macOS update or upgrade available."

# Start the appropriate main workflow based on user options.
if [[ "$skipUpdatesOPTION" == "TRUE" ]]; then # Skip software updates/upgrade mode option.
	sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION SKIP UPDATES/UPGRADE ****"
	softwareUpdateRECOMMENDED="FALSE"
	macOSUpgradeVersionTARGET="FALSE"
	softwareUpdateMACOS="FALSE"
	if [[ "$testModeOPTION" == "TRUE" ]]; then
		sendToLog "Test Mode: Simulating skip updates workflow."
		{ [[ "$restartWithoutUpdatesOPTION" != "TRUE" ]] && [[ -z $policyTRIGGERS ]]; } && sendToLog "Warning: You need to also use --restart-without-updates or --policy-triggers to simulate notification and dialog workflows."
	fi
else # Default software update/upgrade workflows.
	# Check for updates/upgrades.
	if [[ "$testModeOPTION" != "TRUE" ]]; then
		sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION CHECK SOFTWARE UPDATES/UPGRADE ****"
		[[ "$fullCheckREQUIRED" != "TRUE" ]] && checkSoftwareListCache
		checkSoftwareUpdates
		checkMacOSUpgrades
		checkMacOSDownloads
	else # Test mode.
		softwareUpdateRECOMMENDED="FALSE"
		macOSUpgradeVersionTARGET="FALSE"
		softwareUpdateMACOS="FALSE"
		if [[ "$enforceNonSystemUpdatesOPTION" == "TRUE" ]]; then
			softwareUpdateRECOMMENDED="TRUE"
			sendToLog "Test Mode: Simulating enforce all non-system updates workflow."
		elif [[ "$allowUpgradeOPTION" == "TRUE" ]]; then
			macOSUpgradeVersionTARGET="$macOSMAJOR"
			macOSSoftwareUpgradeVersionTARGET="$macOSMAJOR.$macOSMINOR"
			macOSInstallerNameTARGET="$macOSNAME"
			macOSInstallerVersionTARGET="$macOSMAJOR.$macOSMINOR"
			macOSInstallerBuildTARGET="$macOSBUILD"
			macOSSoftwareUpgradeGB=10
			macOSSoftwareUpdateDownloadREQUIRED="TRUE"
			macOSInstallerDownloadREQUIRED="TRUE"
			sendToLog "Test Mode: Simulating macOS $macOSUpgradeVersionTARGET upgrade workflow."
		elif [[ "$restartWithoutUpdatesOPTION" == "TRUE" ]]; then
			sendToLog "Test Mode: Simulating restart without updates workflow."
		else # Simulate a macOS update.
			softwareUpdateMACOS="TRUE"
			macOSSoftwareUpdateLABEL="mac OS Label"
			macOSSoftwareUpdateTITLE="mac OS Title"
			macOSSoftwareUpdateVERSION="$macOSMAJOR.$macOSMINOR"
			macOSSoftwareUpdateGB=5
			macOSSoftwareUpdateDownloadREQUIRED="TRUE"
			sendToLog "Test Mode: Simulating a macOS $macOSSoftwareUpdateVERSION update workflow."
		fi
	fi
	deleteUnneededMacOSInstallers # This function includes internal test mode logic.
	# At this point all available updates/upgrades have been evaluated so report different workflow statuses.
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeVersionTARGET is: $macOSUpgradeVersionTARGET"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: upgradeWORKFLOW is: $upgradeWORKFLOW"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateMACOS is: $softwareUpdateMACOS"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: updateWORKFLOW is: $updateWORKFLOW"
	[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateRECOMMENDED is: $softwareUpdateRECOMMENDED"
	if [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]]; then # A macOS upgrade is available and option to allow upgrade is enabled.
		if [[ $macOSVERSION -ge 1203 ]] && [[ "$upgradeWORKFLOW" != "JAMF" ]]; then # macOS 12.3 or newer can upgrade via softwareupdate, unless using MDM workflow.
			if [[ "$installNowOPTION" == "TRUE" ]]; then
				[[ "$upgradeWORKFLOW" == "LOCAL" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL NOW UPGRADE MACOS $macOSSoftwareUpgradeVersionTARGET SOFTWAREUPDATE ****"
				[[ "$upgradeWORKFLOW" == "USER" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL NOW UPGRADE MACOS $macOSSoftwareUpgradeVersionTARGET USER AUTHENTICATION ****"
			elif [[ "$onlyDownloadOPTION" == "TRUE" ]]; then
				sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION ONLY DOWNLOAD UPGRADE MACOS $macOSSoftwareUpgradeVersionTARGET SOFTWAREUPDATE ****"
			else # Default super workflow.
				[[ "$upgradeWORKFLOW" == "LOCAL" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION UPGRADE MACOS $macOSSoftwareUpgradeVersionTARGET SOFTWAREUPDATE ****"
				[[ "$upgradeWORKFLOW" == "USER" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION UPGRADE MACOS $macOSSoftwareUpgradeVersionTARGET USER AUTHENTICATION ****"
			fi
		else # Systems older than macOS 12.3 or using the MDM workflow upgrade via installer.
			if [[ "$installNowOPTION" == "TRUE" ]]; then
				[[ "$upgradeWORKFLOW" == "LOCAL" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL NOW UPGRADE MACOS $macOSInstallerVersionTARGET INSTALLER ****"
				[[ "$upgradeWORKFLOW" == "JAMF" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL NOW UPGRADE MACOS $macOSInstallerVersionTARGET MDM PUSH ****"
				[[ "$upgradeWORKFLOW" == "USER" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL NOW UPGRADE MACOS $macOSInstallerVersionTARGET USER AUTHENTICATION ****"
			elif [[ "$onlyDownloadOPTION" == "TRUE" ]]; then
				sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION ONLY DOWNLOAD UPGRADE MACOS $macOSInstallerVersionTARGET INSTALLER ****"
			else # Default super workflow.
				[[ "$upgradeWORKFLOW" == "LOCAL" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION UPGRADE MACOS $macOSInstallerVersionTARGET INSTALLER ****"
				[[ "$upgradeWORKFLOW" == "JAMF" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION UPGRADE MACOS $macOSInstallerVersionTARGET MDM PUSH ****"
				[[ "$upgradeWORKFLOW" == "USER" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION UPGRADE MACOS $macOSInstallerVersionTARGET USER AUTHENTICATION ****"
			fi
		fi
		if [[ -n $displayAccessoryUpgradeCONTENT ]]; then
			displayAccessoryCONTENT="$displayAccessoryUpgradeCONTENT"
		elif [[ -n $displayAccessoryDefaultCONTENT ]]; then
			displayAccessoryCONTENT="$displayAccessoryDefaultCONTENT"
		fi
	elif [[ "$softwareUpdateMACOS" == "TRUE" ]]; then # macOS updates are available.
		if [[ "$installNowOPTION" == "TRUE" ]]; then
			[[ "$updateWORKFLOW" == "LOCAL" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL NOW UPDATE MACOS $macOSSoftwareUpdateVERSION SOFTWAREUPDATE ****"
			[[ "$updateWORKFLOW" == "JAMF" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL NOW UPDATE MACOS $macOSSoftwareUpdateVERSION MDM PUSH ****"
			[[ "$updateWORKFLOW" == "USER" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL NOW UPDATE MACOS $macOSSoftwareUpdateVERSION USER AUTHENTICATION ****"
		elif [[ "$onlyDownloadOPTION" == "TRUE" ]]; then
			sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION ONLY DOWNLOAD UPDATE MACOS $macOSSoftwareUpdateVERSION SOFTWAREUPDATE ****"
		else # Default super workflow.
			[[ "$updateWORKFLOW" == "LOCAL" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE MACOS $macOSSoftwareUpdateVERSION SOFTWAREUPDATE ****"
			[[ "$updateWORKFLOW" == "JAMF" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE MACOS $macOSSoftwareUpdateVERSION MDM PUSH ****"
			[[ "$updateWORKFLOW" == "USER" ]] && sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE MACOS $macOSSoftwareUpdateVERSION USER AUTHENTICATION ****"
		fi
		if [[ -n $displayAccessoryUpdateCONTENT ]]; then
			displayAccessoryCONTENT="$displayAccessoryUpdateCONTENT"
		elif [[ -n $displayAccessoryDefaultCONTENT ]]; then
			displayAccessoryCONTENT="$displayAccessoryDefaultCONTENT"
		fi
	elif [[ "$softwareUpdateRECOMMENDED" == "TRUE" ]]; then # Only recommended (non-system) updates are available.
		defaults delete "$superPLIST" ZeroDayAuto 2> /dev/null
		defaults delete "$superPLIST" FocusCounter 2> /dev/null
		defaults delete "$superPLIST" SoftCounter 2> /dev/null
		defaults delete "$superPLIST" HardCounter 2> /dev/null
		if [[ "$enforceNonSystemUpdatesOPTION" == "TRUE" ]]; then # Option to enforce all software updates is enabled.
			if [[ "$installNowOPTION" == "TRUE" ]]; then
				sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION INSTALL NOW UPDATE RECOMMENDED (NON-SYSTEM) SOFTWARE ****"
				installRecommendedWorkflow # This function includes internal install now and test mode logic.
			elif [[ "$onlyDownloadOPTION" == "TRUE" ]]; then
				sendToLog "Warning: The --enforce-non-system-updates option is ignored when used with the --only-download option."
			else # Default super workflow.
				sendToLog "**** S.U.P.E.R.M.A.N. $superVERSION UPDATE RECOMMENDED (NON-SYSTEM) SOFTWARE ****"
				installRecommendedWorkflow # This function includes internal install now and test mode logic.
			fi
		else
			sendToLog "Status: Available recommended (non-system) software updates are not enforced. You must use the --enforce-non-system-updates option for these items to install without a macOS update/upgrade."
		fi
	else # No software updates/upgrade needed so clean up any leftover deferral counters.
		defaults delete "$superPLIST" ZeroDayAuto 2> /dev/null
		defaults delete "$superPLIST" FocusCounter 2> /dev/null
		defaults delete "$superPLIST" SoftCounter 2> /dev/null
		defaults delete "$superPLIST" HardCounter 2> /dev/null
	fi
fi

# This is the main logic for determining what to do in the case of available macOS updates, macOS upgrades, $policyTRIGGERS, or the $restartWithoutUpdatesOPTION.
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: softwareUpdateMACOS is: $softwareUpdateMACOS"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: macOSUpgradeVersionTARGET is: $macOSUpgradeVersionTARGET"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: policyTRIGGERS is: $policyTRIGGERS"
[[ "$verboseModeOPTION" == "TRUE" ]] && sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: restartWithoutUpdatesOPTION is: $restartWithoutUpdatesOPTION"
if [[ "$softwareUpdateMACOS" == "TRUE" ]] || [[ "$macOSUpgradeVersionTARGET" != "FALSE" ]] || [[ -n $policyTRIGGERS ]] || [[ "$restartWithoutUpdatesOPTION" == "TRUE" ]]; then
	# Check for current user and required storage free space before continuing.
	checkCurrentUser
	if [[ "$installNowOPTION" == "TRUE" ]]; then # Install now workflow is only possible if the user is logged in.
		if [[ "$skipUpdatesOPTION" != "TRUE" ]]; then
			[[ "$userAuthMDMFailoverINSTALLNOW" == "TRUE" ]] && userAuthMDMFAILOVER="TRUE"
			{ [[ "$upgradeWORKFLOW" == "USER" ]] || [[ "$updateWORKFLOW" == "USER" ]]; } && dialogUserAuth
			downloadMacOSWorkflow # This function only downloads if needed and includes internal storage checks and test mode logic.
		fi
		installRestartWorkflowActiveUser # This function includes internal power/storage checks and test mode logic.
	elif [[ "$onlyDownloadOPTION" == "TRUE" ]]; then # Only download workflow doesn't matter if the user is logged in.
		[[ -n $policyTRIGGERS ]] && sendToLog "Warning: The --policy-triggers option is ignored when used with the --only-download option."
		downloadMacOSWorkflow # This function only downloads if needed and includes internal storage checks and test mode logic.
	else # Default super workflow, can run with or without logged in user.
		if [[ "$currentUserNAME" == "FALSE" ]]; then # A normal user is not logged in, start all downloads and installations immediately.
			installRestartWorkflowNoUser # This function includes internal power/storage checks and test mode logic.
		else # A normal user is currently logged in.
			# First start by checking deadlines.
			checkZeroDay
			checkDateDeadlines
			checkDaysDeadlines
			# User Focus only needs to be checked if there are no date or day deadlines.
			if [[ "$deadlineDateSTATUS" == "FALSE" ]] && [[ "$deadlineDaysSTATUS" == "FALSE" ]]; then
				checkUserFocus
			else # At this point any date or days deadline would rule out any $focusDEFER option.
				focusDEFER="FALSE"
			fi
			checkCountDeadlines
			# At this point all deferral and deadline options have been evaluated.
			[[ "$skipUpdatesOPTION" != "TRUE" ]] && downloadMacOSWorkflow # This function only downloads if needed and includes internal storage checks and test mode logic.	
			# At this point all deferral and deadline options have been evaluated.
			if [[ "$deadlineDateSTATUS" == "HARD" ]] || [[ "$deadlineDaysSTATUS" == "HARD" ]] || [[ "$deadlineCountSTATUS" == "HARD" ]]; then # A hard deadline has passed, similar to no logged in user but with a notification.
				[[ "$userAuthMDMFailoverHARD" == "TRUE" ]] && userAuthMDMFAILOVER="TRUE"
				installRestartWorkflowActiveUser # This function includes internal power/storage checks and test mode logic.
			elif [[ "$deadlineDateSTATUS" == "SOFT" ]] || [[ "$deadlineDaysSTATUS" == "SOFT" ]] || [[ "$deadlineCountSTATUS" == "SOFT" ]]; then # A soft deadline has passed.
				[[ "$userAuthMDMFailoverSOFT" == "TRUE" ]] && userAuthMDMFAILOVER="TRUE"
				{ [[ "$upgradeWORKFLOW" != "USER" ]] && [[ "$updateWORKFLOW" != "USER" ]]; } && dialogSoftDeadline
				installRestartWorkflowActiveUser # This function includes internal power/storage checks and test mode logic.
			elif [[ "$focusDEFER" == "TRUE" ]]; then # No deadlines have passed but a process has told the display to not sleep or the user has enabled Focus or Do Not Disturb.
				deferSECONDS="$focusDeferSECONDS"
				sendToStatus "Pending: Automatic user focus deferral, trying again in $deferSECONDS seconds."
				makeLaunchDaemonCalendar
			else # Logically, this is the only time the choice dialog is shown.
				dialogRestartOrDefer
				if [[ "$choiceINSTALL" == "TRUE" ]]; then
					installRestartWorkflowActiveUser  # This function includes internal power/storage checks and test mode logic.
				else
					sendToStatus "Pending: User chose to defer, trying again in $deferSECONDS seconds."
					makeLaunchDaemonCalendar
				fi
			fi
		fi
	fi
fi

# At this point super is about to exit, so wrap up for different workflow exit modes.
if [[ "$restartVALIDATE" == "TRUE" ]]; then # An update/upgrade is about to restart the computer.
	sendToLog "Exit: macOS update/upgrade restart is imminent, super is scheduled to run at next startup."
	sendToStatus "Pending: macOS update/upgrade restart is imminent, super is scheduled to run at next startup."
else # The super workflow did not complete a macOS update/upgrade workflow.
	if [[ "$installNowOPTION" == "TRUE" ]]; then
		notifyInstallNowUpToDate
		if [[ "$testModeOPTION" == "TRUE" ]]; then
			sendToLog "Test Mode: Pausing $testModeTimeoutSECONDS seconds for the install now up to date notification..."
			sleep "$testModeTimeoutSECONDS"
			kill -9 "$notifyPID" > /dev/null 2>&1
			if [[ "$ibmNotifierVALID" == "TRUE" ]] && [[ "$preferJamfHelperOPTION" != "TRUE" ]]; then
				killall -9 "IBM Notifier" "IBM Notifier Popup" > /dev/null 2>&1
			else
				killall -9 "jamfHelper" > /dev/null 2>&1
			fi
		fi
	fi
	# A few bits of cleanup for $onlyDownloadOPTION.
	if [[ "$onlyDownloadCOMPLETE" == "TRUE" ]]; then
		if [[ "$jamfVERSION" != "FALSE" ]] && [[ "$jamfSERVER" != "FALSE" ]]; then
			sendToLog "Status: Submitting updated inventory to Jamf Pro. Use --verbose-mode or check /var/log/jamf.log for more detail..."
			if [[ "$verboseModeOPTION" == "TRUE" ]]; then
				jamfRESULT=$("$jamfBINARY" recon -verbose 2>&1)
				jamfRETURN=$?
				sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfRESULT is:\n$jamfRESULT"
				sendToLog "Verbose Mode: Function ${FUNCNAME[0]}: jamfRETURN is: $jamfRETURN"
			else
				"$jamfBINARY" recon > /dev/null 2>&1
			fi
		fi
	fi
	# Logic for $recheckDeferSECONDS.
	if [[ -n "$recheckDeferSECONDS" ]]; then
		deferSECONDS="$recheckDeferSECONDS"
		sendToLog "Recheck deferral should restart super in $deferSECONDS seconds."
		sendToStatus "Pending: Recheck deferral should restart super in $deferSECONDS seconds."
		makeLaunchDaemonCalendar
	else # Recheck deferral is inactive.
		sendToLog "Status: Recheck deferral is inactive."
		sendToStatus "Inactive: Recheck deferral is inactive."
		sendToPending "Inactive."
		removeLaunchDaemon
	fi
fi
}

mainWorkflow "$@"
cleanExit