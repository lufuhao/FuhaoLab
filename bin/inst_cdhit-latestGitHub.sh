#!/bin/bash
source FuhaoLab.conf


PackageName="cdhit"
PackageVersTemp="version"
InternetLink='https://github.com/weizhongli/cdhit.git'
NameUncompress="cdhit"
TestCmd="./cd-hit-est -h"
#PackageVers="v4.8.1-4d4d169"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#AC_INIT([MUMmer], [4.0.0beta2], [gmarcais@umd.edu])
#PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/configure.ac | sed 's/^AC_INIT.*jellyfish\], \[//;s/\].*$//g')
#PrintInfo "Version: $PackageVers"
PackageVers=$(git tag -l | tail -n 1 | sed 's/V/v/g;')"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"


cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "make"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE install"
cd ${PROGPATH}/$PackageName/$NameUncompress/cd-hit-auxtools
RunCmds "make"
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/cd-hit-auxtools"
for f in `find ${PROGPATH}/$PackageName/$NameUncompress/cd-hit-auxtools/ -maxdepth 1 -type f -perm /+x`; do RunCmds "cp -da $f ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/cd-hit-auxtools/"; done
RunCmds "cp -Rda ${PROGPATH}/$PackageName/$NameUncompress/psi-cd-hit ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

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

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
