libreoffice-portable-downloader.bash
====================================
This program downloads and extracts the latest version of LibreOffice
in the folder where the program is located.

Ce programme télécharge et extrait la dernière version de LibreOffice
dans le dossier où le programme est situé.

Fell free to fork or contribute!

#Version 1.0.0

###How does it works?
Using some black magic* it gets the latest version of LibreOffice, downloads the RPM package, extract it and makes a symbolic link to easily launch the office suite.

>*It parses [this page](https://download.documentfoundation.org/libreoffice/stable/) with grep, tail and sed to get the latest version number.

###Typical use case
You study computer science at the university and hopefully they have linux machines but only OpenOffice 3.2 or some other oldish version. With this script you can use the latest version of LibreOffice and benefit from the latest features, performances and interoperability improvements. You can even compress it into an archive to keep it in your USB drive (7z/LZMA is one of the fastest formats for decompressing)

###TODO:
	-python version
	-check CPIO and RPM dependencies
	-limit verbosity of CPIO extraction
	-choose to use parameters with functions or global variables -> be consistent
