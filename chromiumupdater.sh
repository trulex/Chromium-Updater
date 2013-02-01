#!/bin/bash

#################################################################################
## Bash script for automated update of Chromium browser                        ##
## Author: Darko Jankovic; fb.me/dark0jankovic; darko.jankovic2@gmail.com      ##
#################################################################################

OLDV=$(chromium-browser --version | cut -d \  -f 2)
echo -n "Current Chromium version: "
echo $OLDV
#get architecture
ARCH=$(uname -i)

#set URLs
if [ $ARCH == "x86_64" ]
    then URL="http://download-chromium.appspot.com/dl/Linux_x64"
else
    URL="http://download-chromium.appspot.com/dl/Linux"
fi

#get latest version
echo "Downloading latest Chromium"
mkdir /tmp/chromium/
wget "$URL" -O /tmp/chromium/chrome-linux.zip

#unzip archive
cd /tmp/chromium/
unzip "chrome-linux.zip"
cd "chrome-linux/"

#rename some files
mv "chrome" "chromium-browser"
mv "chrome_sandbox" "chromium-browser-sandbox"

#copy to installation directory and orewrite old files 
echo "Updating Chromium"
sudo cp -R * /usr/lib/chromium-browser

echo -n "Chromium successfully updated from version "$OLDV" to version "
echo $(chromium-browser --version) | cut -d \  -f 2