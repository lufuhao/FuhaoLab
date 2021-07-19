#!/bin/bash


### https://www.ibm.com/aspera/connect/
### Requirements: IBM account to download

source FuhaoLab.conf


PackageName="aspera-connect"
PackageVers="v3.11.2.63"
InternetLink="https://d3gcli72yxqn2z.cloudfront.net/connect_latest/v4/bin/ibm-aspera-connect-3.11.2.63-linux-g2.12-64.tar.gz"
#InternetLink="https://sourceforge.net/projects/old-software-collection/files/ibm-aspera-connect-3.9.9.177872-linux-g2.12-64.tar.gz“
NameUncompress="ibm-aspera-connect-3.11.2.63-linux-g2.12-64.sh"
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
