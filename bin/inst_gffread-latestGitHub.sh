#!/bin/bash
source FuhaoLab.conf


PackageName="gffread"
PackageVersTemp="version"
InternetLink='https://github.com/gpertea/gffread.git'
NameUncompress="gffread"
TestCmd="./gffread --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers="v"$(grep '#define VERSION ' ${PROGPATH}/$PackageName/$NameUncompress/gffread.cpp | sed 's/^.*VERSION "//;s/"$//;')"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/"

cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
RunCmds "make release"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cp LICENSE README.md gffread ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/
$TestCmd
if [ $? -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
