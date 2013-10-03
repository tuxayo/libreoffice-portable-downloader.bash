libreoffice-portable-downloader.bash
====================================
This script downloads the latest version of LibreOffice in the folder where the script is located and extracts it to make a portable version.

Ce script télécharge la dernière version de LibreOffice dans le dossier où le script est situé et l'extrait pour en faire une version portable.

#####Fell free to fork or contribute!

#Version: 1.0.1

###Typical use case
You study computer science at the university and hopefully they have linux machines but only OpenOffice 3.2 or some other oldish version. With this script you can use the latest version of LibreOffice and benefit from the latest features, performances and interoperability improvements. 

##Frequently asked questions

###What is a portable version?
A portable application (also called standalone) can be runned without installing it in the system. This means you should be able to use the latest version of LibreOffice on any (GNU/Linux x86) computer, without root permissions.

###I don't want to download LibreOffice every time I need it on a different computer
You should compress it into an archive to store it in an USB drive, launching directly from the computer is recommended as FAT32 USB drives does not support symbolic links and will prevent LibreOffice from launching correctly (7z/LZMA is one of the fastest formats for decompressing).

###How does it works?
Just launch it.


###How does it really works?
Using some black magic* it gets the latest version of LibreOffice, downloads the RPM package, extracts it and makes a simple launcher for the office suite.

>*It parses [this page](https://download.documentfoundation.org/libreoffice/stable/) with grep, tail and sed to get the latest version number.

###I have Windows what do I do?
Change you operating system. If you can't, go [here](https://www.libreoffice.org/download/portable/) to download a Windows portable version.

##TODO:
	-python version
	-check CPIO and RPM dependencies
	-limit verbosity of CPIO extraction
	-choose to use parameters with functions or global variables -> be consistent
