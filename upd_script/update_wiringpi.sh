#!/bin/bash

feedback() {
  # first parameter is text to be displayed
  echo -e "$(tput setaf 3)$1$(tput sgr0)"
}

# Check if WiringPi Installed and has the latest version.  If it does, skip the step.
# Gets the version of wiringPi installed
version=`gpio -v`       

# Parses the version to get the number
set -- $version         

# Gets the third word parsed out of the first line of gpio -v returned.
# Should be 2.36
WIRINGVERSIONDEC=$3     

# Store to temp file
echo $WIRINGVERSIONDEC >> tmpversion    

# Remove decimals
VERSION=$(sed 's/\.//g' tmpversion)     

# Remove the temp file
rm tmpversion                           

feedback "wiringPi VERSION is $VERSION"
if [ $VERSION -eq '236' ]; then

	feedback "FOUND WiringPi Version 2.36 No installation needed."
else
	feedback "Did NOT find WiringPi Version 2.36"
	# Check if the Dexter directory exists.
	DIRECTORY='/home/pi/Dexter'
	if [ -d "$DIRECTORY" ]; then
		# Will enter here if $DIRECTORY exists, even if it contains spaces
		echo "Dexter Directory Found!"
	else
		mkdir $DIRECTORY
	fi
	# Install wiringPi

	# Change directories to Dexter
	cd $DIRECTORY/lib 	
	git clone https://github.com/DexterInd/wiringPi/  # Clone directories to Dexter.
	cd wiringPi
	sudo chmod +x ./build
	sudo ./build
	feedback "wiringPi Installed"
fi
# End check if WiringPi installed