libreoffice-portable-downloader.bash
====================================
This script downloads the latest version of LibreOffice in the folder where the script is located and extracts it to make a portable version.

Ce script télécharge la dernière version de LibreOffice dans le dossier où le script est situé et l'extrait pour en faire une version portable.

#Version: 1.0.2

###Typical use case
You study computer science at the university and hopefully they have linux machines but only OpenOffice 3.2 or some other oldish version. With this script you can use the latest version of LibreOffice and benefit from the latest features, performances and interoperability improvements. 

##Frequently asked questions

###What is a portable version?
A portable application (also called standalone) can be runned without installing it in the system. This means you should be able to use the latest version of LibreOffice on any (GNU/Linux x86) computer, without root permissions.

###How does it works?
Just launch it in a terminal.

###I don't want to download LibreOffice every time I need it on a different computer
You should compress it into an archive to store it in an USB drive, launching directly from the computer is recommended as FAT32 USB drives does not support symbolic links and will prevent LibreOffice from launching correctly (7z/LZMA is one of the fastest formats for decompressing).

###How does it really works?
Using some black magic* it gets the latest version of LibreOffice, downloads the RPM package, extracts it and makes a simple launcher for the office suite.

>*It parses [this page](https://download.documentfoundation.org/libreoffice/stable/) with grep, tail and sed to get the latest version number.

###I have Windows what do I do?
Change your operating system. If you can't, go [here](https://www.libreoffice.org/download/portable/) to download a Windows portable version.


##Fell free to fork or contribute!
It's GPLv3 so go ahead, the only thing to pay attention for is the name as LibreOffice is a mark owned by The Document Foundation. The name I gave to this program required me to contact The Document Foundation and request a trademark license. You can see the trademark license I got in the file named TRADEMARK_LICENCE.

You can find more informations [here](https://wiki.documentfoundation.org/TradeMark_Policy) on The Document Foundation's wiki. Contact [legal@documentfoundation.org](mailto:legal@documentfoundation.org) if necessary.



##TODO:
	-extract without CPIO
	-python version
	-choose to use parameters with functions or global variables -> be consistent
