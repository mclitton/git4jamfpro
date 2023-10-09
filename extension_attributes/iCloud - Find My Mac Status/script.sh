#!/bin/bash
# Jamf Extension Attribute to determine if Find My Mac is enabled
fmmStatus=$(defaults read /Library/Preferences/com.apple.FindMyMac.plist FMMEnabled)
if [[ "$fmmStatus" == 0 ]]; then
echo "<result>Disabled</result>"
else
echo "<result>Enabled</result>"
fi