#!/bin/bash
source FuhaoLab.conf


PackageName="taxonkit"
PackageVers="v0.6.2"
InternetLink="${GITHUB_CUSTOM_SITE}/shenwei356/taxonkit/releases/download/v0.6.2/taxonkit_linux_amd64.tar.gz"
NameUncompress="taxonkit_linux_amd64"
TestCmd="./taxonkit --help"

NameCompress=$PackageName-$PackageVers.amd64.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"
RunCmds "mv taxonkit ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"
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
