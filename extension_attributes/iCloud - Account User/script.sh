#!/bin/bash
# Getting the logged-in user
loggedInUser=$(stat -f%Su /dev/console)
loggedInUserHome=$("/usr/bin/dscl" . -read "/Users/$loggedInUser" NFSHomeDirectory | "/usr/bin/awk" '{print $NF}')
icloudPlist="$loggedInUserHome/Library/Preferences/MobileMeAccounts.plist"
echo $loggedInUser is logged in, reading iCloud plist
icloudaccount=$( defaults read $icloudPlist Accounts | grep AccountID | cut -d '"' -f 2)
if [ -z "$icloudaccount" ] 
then
	echo "<result>Null</result>"
else
	echo "<result>$icloudaccount</result>"
fi