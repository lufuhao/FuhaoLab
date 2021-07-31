#!/bin/bash
source FuhaoLab.conf


PackageName="ldc2"
PackageVers="v1.22.0"
InternetLink="${GITHUB_CUSTOM_SITE}/ldc-developers/ldc/releases/download/v1.22.0/ldc2-1.22.0-linux-x86_64.tar.xz"
NameUncompress="ldc2-1.22.0-linux-x86_64"
#TestCmd="./ldc2 --help"

NameCompress=$PackageName-$PackageVers.tar.xz
CheckLibPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xvJf $NameCompress"
fi
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress  ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"


RunCmds "cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
if [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ]; then
	echo "Error: lib not exists: $PackageName-$PackageVers" >&2
	exit 100
fi
RunCmds "cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/bin"
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to run $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
