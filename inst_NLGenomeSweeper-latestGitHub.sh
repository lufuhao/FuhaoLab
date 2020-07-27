#!/bin/bash
source FuhaoLab.conf
### Websites: https://github.com/ntoda03/NLGenomeSweeper
### doi:10.3390/genes11030333

PackageName="NLGenomeSweeper"
PackageVersTemp="version"
InternetLink='https://github.com/ntoda03/NLGenomeSweeper.git'
NameUncompress="NLGenomeSweeper"
TestCmd="./NLGenomeSweeper --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
if [ -x LICENSE ]; then
	chmod -x LICENSE
fi
if [ -x "README.md" ]; then
	chmod -x "README.md"
fi
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
cd ${PROGPATH}/$PackageName/
if [ -d ${PROGPATH}/$PackageName/$PackageVers ]; then
	DeletePath ${PROGPATH}/$PackageName/$PackageVers
else
	mkdir -p ${PROGPATH}/$PackageName/$PackageVers
fi
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress

exit 0
