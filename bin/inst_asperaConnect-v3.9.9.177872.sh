#!/bin/bash


### https://www.ibm.com/aspera/connect/
### Requirements: IBM account to download

source FuhaoLab.conf


PackageName="aspera-connect"
PackageVers="v3.9.9.177872"
InternetLink="https://ak-delivery04-mul.dhe.ibm.com/sar/CMA/OSA/08sq3/0/ibm-aspera-connect-3.9.9.177872-linux-g2.12-64.tar.gz"
#InternetLink="https://sourceforge.net/projects/old-software-collection/files/ibm-aspera-connect-3.9.9.177872-linux-g2.12-64.tar.gz“
NameUncompress="ibm-aspera-connect-3.9.9.177872-linux-g2.12-64.sh"
TestCmd="./ascp --help"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi


RunCmds "bash $NameUncompress"
cd $HOME/.aspera/connect/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $HOME/.aspera/connect/bin
AddEnvironVariable $HOME/.aspera/connect "$PackageName-$PackageVers"

#DeletePath $PROGPATH/$PackageName/$PackageVers
exit 0
