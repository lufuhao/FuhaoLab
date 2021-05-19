#!/bin/bash
source FuhaoLab.conf


PackageName="trf"
PackageVers="v4.09"
InternetLink="https://tandem.bu.edu/trf/downloads/trf409.linux64"
NameUncompress="trf409.linux64"
TestCmd="./trf --help"

NameCompress="trf"
CheckPath $PackageName $PackageVers
cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
CreatePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
CreatePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
DownloadWget $InternetLink $NameCompress
if [ ! -s ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/$NameCompress ]; then
	PrintError "Error: can not find file: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/$NameCompress"
	exit 100
fi
chmod +x ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/$NameCompress


if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100
fi
$TestCmd
if [ $? -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
