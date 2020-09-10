#!/bin/bash
source FuhaoLab.conf


PackageName="SOAPdenovo2"
PackageVersTemp="version"
InternetLink='https://github.com/aquaskyline/SOAPdenovo2.git'
NameUncompress="SOAPdenovo2"
TestCmd="./bowtie --help"
:<<EOH
CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
EOH
cd ${PROGPATH}/$PackageName/$NameUncompress
#PackageVers="v"$(head -n 1 ${PROGPATH}/$PackageName/$NameUncompress/VERSION | sed 's/^\s\+//;s/\s\+.*$//g')"-"$(git describe --abbrev=7 --always  --long --match v* origin/master)
PackageVers="v2.04-r241-477bd86"
PrintInfo "Version: $PackageVers"

exit 0
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make"

exit 0
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress

exit 0
