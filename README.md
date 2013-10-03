libreoffice-portable-downloader.bash
====================================
This script downloads the latest version of LibreOffice in the folder where the script is located and extracts it to make a portable version.

Ce script télécharge la dernière version de LibreOffice dans le dossier où le script est situé et l'extrait pour en faire une version portable.

#####Fell free to fork or contribute!

#Version 1.0.0

###Typical use case
You study computer science at the university and hopefully they have linux machines but only OpenOffice 3.2 or some other oldish version. With this script you can use the latest version of LibreOffice and benefit from the latest features, performances and interoperability improvements. 

###What is a portable version?
A portable application (also called standalone) can be runned without installing it in the system, from a USB drive for example. This means you should be able to use the lastest version of LibreOffice on any (GNU/Linux x86) computer, without root permissions. You can even compress it into an archive to save space in your USB drive and accelerate the transfer to the computer (7z/LZMA is one of the fastest formats for decompressing)

###How does it works?
Using some black magic* it gets the latest version of LibreOffice, downloads the RPM package, extract it and makes a symbolic link to easily launch the office suite.

>*It parses [this page](https://download.documentfoundation.org/libreoffice/stable/) with grep, tail and sed to get the latest version number.

###TODO:
	-python version
	-replace symbolic link because it does not stay after compressing in LZMA and therefore the launcher is broken
	-check CPIO and RPM dependencies
	-limit verbosity of CPIO extraction
	-choose to use parameters with functions or global variables -> be consistent
