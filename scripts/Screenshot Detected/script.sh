#!/bin/bash 

# Jamf Helper Script for Jamf Protect  
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"  

#Header for Pop Up  
heading="IT Security Notification"  

#Description for Pop Up  
description="Screenshots are not allowed. This issue has been reported"  

#Button Text  
button1="Sorry. Wont do again"  

#Path for Icon Displayed  
icon="/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns"  
userChoice=$("$jamfHelper" -windowType utility -heading "$heading" -description "$description" -button1 "$button1" -icon "$icon")  

#Remove Jamf Protect Extension Attribute  
rm /Library/Application\ Support/JamfProtect/groups/*  

#Update Jamf Inventroy  
jamf recon