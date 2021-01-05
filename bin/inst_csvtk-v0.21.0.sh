#!/bin/bash
source FuhaoLab.conf


PackageName="csvtk"
PackageVers="v0.21.0"
InternetLink="https://github.com/shenwei356/csvtk/releases/download/v0.21.0/csvtk_linux_amd64.tar.gz"
NameUncompress="csvtk_linux_amd64"
TestCmd="./csvtk --help"

NameCompress=$PackageName-$PackageVers.amd64.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"
RunCmds "mv csvtk ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
