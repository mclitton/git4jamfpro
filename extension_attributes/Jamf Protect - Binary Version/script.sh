#!/bin/sh

#Jamf Protect Location
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
    plist=$($jamfProtectBinaryLocation info --plist)
	jamfProtectVersion=$(/usr/libexec/PlistBuddy -c "Print Version" /dev/stdin <<<"$plist")
else
	jamfProtectVersion="Protect binary not found"
fi

echo "<result>$jamfProtectVersion</result>"