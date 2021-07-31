#!/bin/bash
source FuhaoLab.conf


PackageName="seqkit"
PackageVers="v0.13.2"
InternetLink="${GITHUB_CUSTOM_SITE}/shenwei356/seqkit/releases/download/v0.13.2/seqkit_linux_amd64.tar.gz"
#NameUncompress="bowtie-1.2.3"
TestCmd="./seqkit --help"

NameCompress=$PackageName-$PackageVers.linux_amd64.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress

cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "tar xzvf ${PROGPATH}/$PackageName/$PackageVers/$NameCompress"

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100
fi
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
