#!/bin/bash
source FuhaoLab.conf


PackageName="muscle"
PackageVers="v3.8.31"
InternetLink="http://www.drive5.com/muscle/downloads3.8.31/muscle3.8.31_src.tar.gz"
NameUncompress="muscle3.8.31"
TestCmd="./muscle -version"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$MACHTYPE"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/src
RunCmds "make"
RunCmds "mkdir -p $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin"
RunCmds "mv $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/src/muscle $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
