#!/bin/bash

####################################################################################################
#
#    Nudge Post-install
#
#    Purpose: Configures Nudge to company standards post-install
#    https://github.com/dan-snelson/Nudge-Post-install/wiki
#
####################################################################################################
#
# Version 0.0.17, 03-Jan-2023, Dan K. Snelson (@dan-snelson)
#  - Updates for Nudge [`1.1.10`](https://github.com/macadmins/nudge/pull/435)
#
####################################################################################################



####################################################################################################
#
# Variables
#
####################################################################################################

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Global Variables
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

scriptVersion="0.0.17"
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin/
loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }' )
plistDomain="${4:-"org.churchofjesuschrist"}"                       # Reverse Domain Name Notation (i.e., "org.churchofjesuschrist")
resetConfiguration="${5:-"All"}"                                    # Configuration Files to Reset (i.e., None (blank) | All | JSON | LaunchAgent | LaunchDaemon)
requiredBigSurMinimumOSVersion="${6}"                   # Required macOS Big Sur Minimum Version (i.e., 11.7.1)
requiredBigSurInstallationDate="${7}"       			# Required macOS Big SurInstallation Date & Time (i.e., 2023-01-17T10:00:00Z)
requiredMontereyMinimumOSVersion="${8}"                 # Required macOS Monterey Minimum Version (i.e., 12.6.1)
requiredMontereyInstallationDate="${9}"     			# Required macOS Monterey Installation Date & Time (i.e., 2023-01-17T10:00:00Z)
requiredVenturaMinimumOSVersion="${10}"                 # Required macOS Ventura Minimum Version (i.e., 13.1)
requiredVenturaInstallationDate="${11}"   				# Required macOS Ventura Installation Date & Time (i.e., 2023-01-17T10:00:00Z)
scriptLog="/var/log/${plistDomain}.log"
jsonPath="/Library/Preferences/${plistDomain}.Nudge.json"
launchAgentPath="/Library/LaunchAgents/${plistDomain}.Nudge.plist"
launchDaemonPath="/Library/LaunchDaemons/${plistDomain}.Nudge.logger.plist"



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Set deadline variable based on OS version
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

osProductVersion=$( sw_vers -productVersion )
case "${osProductVersion}" in
    11* ) deadline="${requiredBigSurInstallationDate}"    ;;
    12* ) deadline="${requiredMontereyInstallationDate}"  ;;
    13* ) deadline="${requiredVenturaInstallationDate}"   ;;
esac



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Validate logged-in user
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

if [[ -z "${loggedInUser}" || "${loggedInUser}" == "loginwindow" ]]; then
    echo "No user logged-in; exiting."
    exit #1
else
    loggedInUserID=$(id -u "${loggedInUser}")
fi



####################################################################################################
#
# Functions
#
####################################################################################################

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Client-side Script Logging
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function updateScriptLog() {
    echo -e "$( date +%Y-%m-%d\ %H:%M:%S ) - ${1}" | tee -a "${scriptLog}"
}



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Run command as logged-in user (thanks, @scriptingosx!)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function runAsUser() {

    updateScriptLog "Run \"$@\" as \"$loggedInUserID\" … "
    launchctl asuser "$loggedInUserID" sudo -u "$loggedInUser" "$@"

}



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Reset Configuration
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function resetConfiguration() {

    updateScriptLog "Reset Configuration: ${1}"

    case ${1} in

        "All" )
            # Reset JSON, LaunchAgent, LaunchDaemon, Hide Nudge
            updateScriptLog "Reset All Configuration Files … "

            # Reset User Preferences
            # For testing only; see:
            # * https://github.com/macadmins/nudge/wiki/User-Deferrals#resetting-values-when-a-new-nudge-event-is-detected
            # * https://github.com/macadmins/nudge/wiki/User-Deferrals#testing-and-resetting-nudge

            # echo "Reset User Preferences"
            # rm -f /Users/"${loggedInUser}"/Library/Preferences/com.github.macadmins.Nudge.plist
            # pkill -l -U "${loggedInUser}" cfprefsd
            # updateScriptLog "Removed User Preferences"

            # Reset JSON
            updateScriptLog "Remove ${jsonPath} … "
            rm -f "${jsonPath}" 2>&1
            updateScriptLog "Removed ${jsonPath}"

            # Reset LaunchAgent
            updateScriptLog "Unload ${launchAgentPath} … "
            runAsUser launchctl unload -w "${launchAgentPath}" 2>&1
            updateScriptLog "Remove ${launchAgentPath} … "
            rm -f "${launchAgentPath}" 2>&1
            updateScriptLog "Removed ${launchAgentPath}"

            # Reset LaunchDaemon
            updateScriptLog "Unload ${launchDaemonPath} … "
            /bin/launchctl unload -w "${launchDaemonPath}" 2>&1
            updateScriptLog "Remove ${launchDaemonPath} … "
            rm -f "${launchDaemonPath}" 2>&1
            updateScriptLog "Removed ${launchDaemonPath}"

            # Hide Nudge in Finder
            updateScriptLog "Hide Nudge in Finder … "
            chflags hidden "/Applications/Utilities/Nudge.app" 
            updateScriptLog "Hid Nudge in Finder"

            # Hide Nudge in Launchpad
            updateScriptLog "Hide Nudge in Launchpad … "
            if [[ -z "$loggedInUser" ]]; then
                updateScriptLog "Did not detect logged-in user"
            else
                sqlite3 $(sudo find /private/var/folders \( -name com.apple.dock.launchpad -a -user ${loggedInUser} \) 2> /dev/null)/db/db "DELETE FROM apps WHERE title='Nudge';"
                killall Dock
                updateScriptLog "Hid Nudge in Launchpad for ${loggedInUser}"
            fi

            updateScriptLog "Reset All Configuration Files"
            ;;

        "Uninstall" )
           # Uninstall Nudge Post-install
            updateScriptLog "Uninstalling Nudge Post-install … "

            # Uninstall JSON
            rm -f "${jsonPath}"
            updateScriptLog "Uninstalled ${jsonPath}"

            # Uninstall LaunchAgent
            updateScriptLog "Unload ${launchAgentPath} … "
            runAsUser launchctl unload -w "${launchAgentPath}"
            rm -f "${launchAgentPath}"
            updateScriptLog "Uninstalled ${launchAgentPath}"

            # Uninstall LaunchDaemon
            updateScriptLog "Unload ${launchDaemonPath} … "
            /bin/launchctl unload -w "${launchDaemonPath}" 2>&1
            rm -f "${launchDaemonPath}"
            updateScriptLog "Uninstalled ${launchDaemonPath}"

            # Exit
            updateScriptLog "Uninstalled all Nudge Post-install configuration files"
            updateScriptLog "Thanks for using Nudge Post-install!"
            exit 0
            ;;

        "JSON" )
            # Reset JSON
            updateScriptLog "Remove ${jsonPath} … "
            rm -f "${jsonPath}"
            updateScriptLog "Removed ${jsonPath}"
            ;;

        "LaunchAgent" )
            # Reset LaunchAgent
            updateScriptLog "Unload ${launchAgentPath} … "
            runAsUser launchctl unload -w "${launchAgentPath}"
            updateScriptLog "Remove ${launchAgentPath} … "
            rm -f "${launchAgentPath}"
            updateScriptLog "Removed ${launchAgentPath}"
            ;;

        "LaunchDaemon" )
            # Reset LaunchDaemon
            updateScriptLog "Unload ${launchDaemonPath} … "
            /bin/launchctl unload -w "${launchDaemonPath}" 2>&1
            updateScriptLog "Remove ${launchDaemonPath} … "
            rm -f "${launchDaemonPath}"
            updateScriptLog "Removed ${launchDaemonPath}"
            ;;

        * )
            # None of the expected options was entered; don't reset anything
            updateScriptLog "None of the expected reset options was entered; don't reset anything"
            ;;

    esac

}



####################################################################################################
#
# Program
#
####################################################################################################

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Client-side Logging
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

if [[ ! -f "${scriptLog}" ]]; then
    touch "${scriptLog}"
    updateScriptLog "*** Created log file ***"
fi



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Logging preamble
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

updateScriptLog "Nudge Post-install (${scriptVersion})"



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Reset Configuration
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

resetConfiguration "${resetConfiguration}"



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Nudge Logger LaunchDaemon
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

if [[ ! -f ${launchDaemonPath} ]]; then

    updateScriptLog "Create ${launchDaemonPath} … "

    cat <<EOF > "${launchDaemonPath}"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>${plistDomain}.Nudge.Logger</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/log</string>
        <string>stream</string>
        <string>--predicate</string>
        <string>subsystem == 'com.github.macadmins.Nudge'</string>
        <string>--style</string>
        <string>syslog</string>
        <string>--color</string>
        <string>none</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/var/log/${plistDomain}.log</string>
</dict>
</plist>
EOF

    /bin/launchctl load -w "${launchDaemonPath}" 2>&1

else

    updateScriptLog "${launchDaemonPath} exists"

fi



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Nudge JSON client-side
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

if [[ ! -f ${jsonPath} ]]; then

    updateScriptLog "Create ${jsonPath} … "
    touch "${jsonPath}"
    updateScriptLog "Created ${jsonPath}"

    updateScriptLog "Write ${jsonPath} … "

    cat <<EOF > "${jsonPath}"
{
    "optionalFeatures": {
        "acceptableApplicationBundleIDs": [
            "us.zoom.xos",
            "com.cisco.webexmeetingsapp"
        ],
        "acceptableAssertionUsage": false,
        "acceptableAssertionApplicationNames": [
            "zoom.us",
            "Meeting Center"
        ],
        "acceptableCameraUsage": false,
        "acceptableScreenSharingUsage": false,
        "aggressiveUserExperience": true,
        "aggressiveUserFullScreenExperience": true,
        "asynchronousSoftwareUpdate": true,
        "attemptToFetchMajorUpgrade": true,
        "attemptToBlockApplicationLaunches": true,
        "blockedApplicationBundleIDs": [
            "com.apple.ColorSyncUtility",
            "com.apple.DigitalColorMeter"
            ],
        "disableSoftwareUpdateWorkflow": false,
        "enforceMinorUpdates": true,
        "terminateApplicationsOnLaunch": true
    },
    "osVersionRequirements": [
        {
        "aboutUpdateURLs": [
            {
            "_language": "en",
            "aboutUpdateURL": "https://support.apple.com/en-us/HT211896#macos116"
            }
        ],
        "majorUpgradeAppPath": "/Applications/Install macOS Big Sur.app",
        "requiredInstallationDate": "${requiredBigSurInstallationDate}",
        "requiredMinimumOSVersion": "${requiredBigSurMinimumOSVersion}",
        "targetedOSVersionsRule": "11"
        },
        {
        "aboutUpdateURLs": [
            {
            "_language": "en",
            "aboutUpdateURL": "https://www.apple.com/macos/monterey/"
            }
        ],
        "majorUpgradeAppPath": "/Applications/Install macOS Monterey.app",
        "requiredInstallationDate": "${requiredMontereyInstallationDate}",
        "requiredMinimumOSVersion": "${requiredMontereyMinimumOSVersion}",
        "targetedOSVersionsRule": "12"
        },
        {
        "aboutUpdateURLs": [
            {
            "_language": "en",
            "aboutUpdateURL": "https://www.apple.com/macos/ventura/"
            }
        ],
        "majorUpgradeAppPath": "/Applications/Install macOS Ventura.app",
        "requiredInstallationDate": "${requiredVenturaInstallationDate}",
        "requiredMinimumOSVersion": "${requiredVenturaMinimumOSVersion}",
        "targetedOSVersionsRule": "13"
        }
    ],
    "userExperience": {
        "allowGracePeriods": false,
        "allowLaterDeferralButton": false,
        "allowUserQuitDeferrals": false,
        "allowedDeferrals": 1000000,
        "allowedDeferralsUntilForcedSecondaryQuitButton": 14,
        "approachingRefreshCycle": 6000,
        "approachingWindowTime": 72,
        "elapsedRefreshCycle": 300,
        "gracePeriodInstallDelay": 23,
        "gracePeriodLaunchDelay": 1,
        "gracePeriodPath": "/private/var/db/.AppleSetupDone",
        "imminentRefreshCycle": 600,
        "imminentWindowTime": 24,
        "initialRefreshCycle": 18000,
        "maxRandomDelayInSeconds": 1200,
        "noTimers": false,
        "nudgeRefreshCycle": 60,
        "randomDelay": false
    },
    "userInterface": {
        "actionButtonPath": "/System/Library/CoreServices/Software Update.app",
        "fallbackLanguage": "en",
        "forceFallbackLanguage": false,
        "forceScreenShotIcon": false,
        "iconDarkPath": "/somewhere/logoDark.png",
        "iconLightPath": "/somewhere/logoLight.png",
        "screenShotDarkPath": "/somewhere/screenShotDark.png",
        "screenShotLightPath": "/somewhere/screenShotLight.png",
        "showDeferralCount": true,
        "simpleMode": true,
        "singleQuitButton": true,
        "updateElements": [
        {
            "_language": "en",
            "actionButtonText": "Update",
            "customDeferralButtonText": "",
            "customDeferralDropdownText": "",
            "informationButtonText": "More info",
            "mainContentHeader": "mainContentHeader",
            "mainContentNote": "mainContentNote",
            "mainContentSubHeader": "mainContentSubHeader",
            "mainContentText": "mainContentText \n\nTo perform the update now, click \"actionButtonText,\" review the on-screen instructions by clicking \"More Info…\" then click \"Update Now.\" (Click screenshot below.)\n\nIf you are unable to perform this update now, click \"primaryQuitButtonText\" (which will no longer be visible once the ${deadline} deadline has passed).",
            "mainHeader": "Computer Upgrades Required",
            "oneDayDeferralButtonText": "oneDayDeferralButtonText",
            "oneHourDeferralButtonText": "oneHourDeferralButtonText",
            "primaryQuitButtonText": "Later",
            "secondaryQuitButtonText": "I understand",
            "subHeader": "subHeader"
        }
        ]
    }
}
EOF

    updateScriptLog "Wrote Nudge JSON file to ${jsonPath}"

else

    updateScriptLog "${jsonPath} exists"

fi



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Nudge LaunchAgent
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

if [[ ! -f ${launchAgentPath} ]]; then

    updateScriptLog "Create ${launchAgentPath} … "

    cat <<EOF > "${launchAgentPath}"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>${plistDomain}.Nudge.plist</string>
    <key>LimitLoadToSessionType</key>
    <array>
        <string>Aqua</string>
    </array>
    <key>ProgramArguments</key>
    <array>
        <string>/Applications/Utilities/Nudge.app/Contents/MacOS/Nudge</string>
        <string>-json-url</string>
        <string>file://${jsonPath}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StartCalendarInterval</key>
    <array>
        <dict>
            <key>Minute</key>
            <integer>0</integer>
        </dict>
        <dict>
            <key>Minute</key>
            <integer>30</integer>
        </dict>
    </array>
</dict>
</plist>
EOF

    updateScriptLog "Created ${launchAgentPath}"

    updateScriptLog "Set ${launchAgentPath} file permissions ..."
    chown root:wheel "${launchAgentPath}"
    chmod 644 "${launchAgentPath}"
    chmod +x "${launchAgentPath}"
    updateScriptLog "Set ${launchAgentPath} file permissions"

else

    updateScriptLog "${launchAgentPath} exists"

fi



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Load Nudge LaunchAgent
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# https://github.com/macadmins/nudge/blob/main/build_assets/postinstall-launchagent
# Only enable the LaunchAgent if there is a user logged in, otherwise rely on built in LaunchAgent behavior
if [[ -z "$loggedInUser" ]]; then
    updateScriptLog "Did not detect user"
elif [[ "$loggedInUser" == "loginwindow" ]]; then
    updateScriptLog "Detected Loginwindow Environment"
elif [[ "$loggedInUser" == "_mbsetupuser" ]]; then
    updateScriptLog "Detect SetupAssistant Environment"
elif [[ "$loggedInUser" == "root" ]]; then
    updateScriptLog "Detect root as currently logged-in user"
else
    # Unload the LaunchAgent so it can be triggered on re-install
    runAsUser launchctl unload -w "${launchAgentPath}"
    # Kill Nudge just in case (say someone manually opens it and not launched via LaunchAgent
    killall Nudge
    # Load the LaunchAgent
    runAsUser launchctl load -w "${launchAgentPath}"
fi



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Exit
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

updateScriptLog "Goodbye!"

exit 0