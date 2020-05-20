#!/bin/bash
source FuhaoLab.conf


PackageName="subread"
PackageVers="v2.0.1"
InternetLink="https://sourceforge.net/projects/subread/files/subread-2.0.1/subread-2.0.1-source.tar.gz"
NameUncompress="subread-2.0.1-source"
TestCmd="./subread-align -v"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
DeletePath $PROGPATH/$PackageName/$PackageVers/$NameUncompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$MACHTYPE"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/src
RunCmds "make -f Makefile.Linux"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
