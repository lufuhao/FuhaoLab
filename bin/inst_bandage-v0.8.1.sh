#!/bin/bash
source FuhaoLab.conf


PackageName="bandage"
PackageVers="v0.8.1"
InternetLink="${GITHUB_CUSTOM_SITE}/rrwick/Bandage/releases/download/v0.8.1/Bandage_Ubuntu_static_v0_8_1.zip"
#NameUncompress="bowtie-1.2.3"
TestCmd="./Bandage --help"

NameCompress=$PackageName-$PackageVers.Ubuntu.static.zip
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
if [ ! -x ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/Bandage ]; then
	RunCmds "unzip -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE $NameCompress"
fi


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
