#!/bin/sh
#################################################################
# A script to determine the installed version of Dialog.app.    #
# If the binary is not found, "Not Installed" will be returned. #
#################################################################

RESULT="Not Installed"

if [ -f "/usr/local/bin/dialog" ] ; then
	RESULT=$( /usr/local/bin/dialog --version )
fi

/bin/echo "<result>${RESULT}</result>"

exit 0