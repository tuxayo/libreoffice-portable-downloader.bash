#!/bin/bash
#	This program downloads and extracts the latest version of LibreOffice
#	in the folder where the program is located.
#	Ce programme télécharge et extrait la dernière version de LibreOffice
#	dans le dossier où le programme est situé.
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

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$scriptDir"				#Go to the script directory

function main() {
	version=$(getLatestLibreOfficeVersion)
	url=$(getLinkLatestLibreOfficeRPM $version)
	
	wget "$url" --no-check-certificate -O "libreOffice"$version".tar.gz"
		#nocheck to avoid some https errors(for this, full https security 
		#is not essential but you can remove the option is you want)
	echo "Extracting from .tar.gz"
	tar -xzf "libreOffice"$version".tar.gz" #&> /dev/null
	extractRPM
	echo "Extraction terminée"
	cleaning
	createShortcut
	echo -e "Pour lancer LibreOffice, allez dans le dossier libreOffice"$version" et\nvous y trouverez le launcher"
	echo "Version 1.0.0 by Victor Grousset (victor@tuxayo.net) under GPLv3 Licence"
	echo "With the help of Alain Drillon and Julien Papasian"
	read	#press any key to continue
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

function getLinkLatestLibreOfficeRPM() {
	lastVersionLibO=$1
	getProcessorArchitecture
	url="https://download.documentfoundation.org/libreoffice/stable/"$lastVersionLibO"/rpm/"$archFolderName"/LibreOffice_"$lastVersionLibO"_Linux_"$archInFileName"_rpm.tar.gz"
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

function extractRPM() {
	#first we go to the folder were the RPM files are
	cd "LibreOffice_"?"."?"."?"."?"_Linux_"*"_rpm"/RPMS
	echo "Extracting from .rpm"
	formatOfRpm2cpioOutput=$(getFormatOfRpm2cpioOutput)
	case $formatOfRpm2cpioOutput in
		"gzip compressed data, from Unix")
			extractGzipAndCpio
			;;
		"ASCII cpio archive (SVR4 with no CRC)")
			extractCpio
			;;
		*)
			echo $formatOfRpm2cpioOutput" n'est pas un format reconnu, veuillez m'envoyer le nom du format par email à victor@tuxayo.net si vous voulez aider à ce que ce script marche bien"
			echo "On va faire avec la méthode d'extraction qui a le plus de chances de marcher ^^\""
			echo $formatOfRpm2cpioOutput" is not a recognized format, please send me the format name by email to victor@tuxayo.net if you want this script to works well"
			echo "We will try the extraction method which should works most of the time ^^\""
			extractCpio
			;;
	esac
	#now move LibreOffice folder to script folder
	mv "opt/libreoffice"?"."* "$scriptDir""/libreOffice"$version
	cd "$scriptDir"
}

function getFormatOfRpm2cpioOutput() {
	#we check the format of one file to choose the good extraction method
	firstRpmInFolder=$(ls *.rpm | head -1)
	rpm2cpio $firstRpmInFolder> $firstRpmInFolder".cpio"
	local formatOfRpm2cpioOutput=$(file -b $firstRpmInFolder".cpio")
	rm $firstRpmInFolder".cpio"
	echo $formatOfRpm2cpioOutput
}

function extractGzipAndCpio() {
	for file in *.rpm
	do 
		rpm2cpio $file | gzip -d | cpio -idm
	done
}

function extractCpio() {
	for file in *.rpm
	do
		rpm2cpio $file | cpio -idm
	done
}

function cleaning() {
	rm -r "LibreOffice_"?"."?"."?"."?"_Linux_"*"_rpm"
	rm "libreOffice"?"."?"."?".tar.gz"
}

function createShortcut() {
	ln -s ./program/soffice ./libreOffice"$version"/"LibreOffice "$version" Launcher"
}

main
