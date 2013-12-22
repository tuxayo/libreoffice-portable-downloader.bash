#!/bin/bash
#	This script downloads the latest version of LibreOffice in the folder 
#	where the script is located and extracts it to make a portable version.
#	Ce script télécharge la dernière version de LibreOffice dans le dossier 
#	où le script est situé et l'extrait pour en faire une version portable.
#	
#	Copyright 2013 Victor Grousset <victor@tuxayo.net>
#	Copyright 2013 Alain Drillon <alaindrillon@myopera.com>
#	Copyright 2013 Julien Papasian	
#
#	This program is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with this program.  If not, see <http://www.gnu.org/licenses/>.

function main() {
	setCurrentDirectoryAndDisplayScriptVersion
	version=$(getLatestLibreOfficeVersion)
	url=$(getLinkLatestLibreOfficeDEB $version)
	
	wget "$url" --no-check-certificate -O "libreOffice"$version".tar.gz"
		#nocheck to avoid some https errors(for this, full https security 
		#is not essential but you can remove the option is you want)
	echo "Extracting from .tar.gz"
	tar -xzf "libreOffice"$version".tar.gz" #&> /dev/null
	extractDEB
	echo "Extraction complete!"
	cleaning
	createLauncher
	echo -e "To launch LibreOffice, go to the libreOffice"$version" directory and you will find \nthe launcher."
	echo -e "Pour lancer LibreOffice, allez dans le dossier libreOffice"$version" et vous y \ntrouverez le launcher"
	echo "Version: "$scriptVersion", by Victor Grousset (victor@tuxayo.net) under GPLv3 Licence"
	echo "With the help of Alain Drillon and Julien Papasian"
	read	#press any key to continue
}

function setCurrentDirectoryAndDisplayScriptVersion() {
	scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	cd "$scriptDir"			#Go to the script directory
	scriptVersion="1.1.1"
	echo "Script version: "$scriptVersion
}

function getLatestLibreOfficeVersion() {
	#we download a page on the document foundation server were we can
	#always find the latest version number of LibreOffice
	wget "https://download.documentfoundation.org/libreoffice/stable/" --no-check-certificate -O ftpLibreOffice.temp &> /dev/null
		#nocheck to avoid some https errors
	#now we isolate the line containing the version number and extract it with sed and a regexp
	lastVersionLibO=$(cat ftpLibreOffice.temp | grep '<tr><td valign="top">&nbsp;</td><td><a href="' | tail -n 1 | sed 's/.*\([0-9]\.[0-9]\.[0-9]\).*/\1/')
	rm ftpLibreOffice.temp
	echo $lastVersionLibO
}

function getLinkLatestLibreOfficeDEB() {
	lastVersionLibO=$1
	getProcessorArchitecture
	url="https://download.documentfoundation.org/libreoffice/stable/"$lastVersionLibO"/deb/"$archFolderName"/LibreOffice_"$lastVersionLibO"_Linux_"$archInFileName"_deb.tar.gz"
	echo $url
}

function getProcessorArchitecture() {
	arch=$(uname -m)
	if [ $arch == "x86_64" ]
	then
		archFolderName="x86_64"
		archInFileName="x86-64"
	else
		archFolderName="x86"
		archInFileName="x86"
	fi
}

function extractDEB() {
	#first we go to the folder were the DEB files are
	cd "LibreOffice_"?"."?"."?"."?"_Linux_"*"_deb"/DEBS
	echo "Extracting from .deb"
	
	for b in *.deb; do  ## loop for all .DEB files found
		ar p $b data.tar.gz | tar zx
	done;
	#now move LibreOffice folder to script folder
	mv "opt/libreoffice"?"."* "$scriptDir""/libreOffice"$version
	cd "$scriptDir"
}

function cleaning() {
	rm -r "LibreOffice_"?"."?"."?"."?"_Linux_"*"_deb"
	#rm "libreOffice"?"."?"."?".tar.gz"
}

function createLauncher() {
	local launcher="./libreOffice"$version"/LibreOffice Launcher"
	echo '#!/bin/bash' >> "$launcher"
	#the 2 following lines make sure that the relative path used by
	#the launcher will work if you launch it directory
	echo 'scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"' >>	"$launcher" 
	echo 'cd "$scriptDir"' >> "$launcher"
	echo './program/soffice' >> "$launcher"
	chmod +x "$launcher"
}

main
