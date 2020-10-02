#!/bin/bash
source FuhaoLab.conf


PackageName="sickle"
PackageVersTemp="version"
InternetLink='https://github.com/najoshi/sickle.git'
NameUncompress="sickle"
TestCmd="./sickle --help"
#PackageVers=""

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#Makefile: VERSION = 1.33
#PackageVers="v"$(grep ^'VERSION' ${PROGPATH}/$PackageName/$NameUncompress/Makefile | sed 's/^VERSION.*=\s\+//;s/\s\+.*$//g')"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#cd ${PROGPATH}/$PackageName/$NameUncompress
#RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
#RunCmds "make test"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "make install"


if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100s
fi
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

#DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
