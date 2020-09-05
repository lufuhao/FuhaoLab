#!/bin/bash
source FuhaoLab.conf
#https://github.com/marbl/canu

PackageName="canu"
PackageVers="v2.1"
InternetLink="https://github.com/marbl/canu/releases/download/v2.1/canu-2.1.Linux-amd64.tar.xz"
NameUncompress="canu-2.1"
TestCmd="./canu --help"

NameCompress="$PackageName-$PackageVers.Linux-amd64.tar.xz"
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xvf $NameCompress"
fi

cd ${PROGPATH}/$PackageName/$PackageVers/
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
#cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/src
#RunCmds "make -j 4"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
