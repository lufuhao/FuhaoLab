#!/bin/bash
source FuhaoLab.conf

PackageName="dsk"
PackageVersTemp="version"
InternetLink='https://github.com/GATB/dsk.git'
NameUncompress="dsk"
TestCmd="./dsk -help"
#PackageVers="v2.3.3-68b79e4"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone --recursive $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

#cd ${PROGPATH}/$PackageName
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
#RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
#cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "git submodule init"
RunCmds "git submodule update"
RunCmds "rm -rf ${PROGPATH}/$PackageName/$NameUncompress/build"
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$NameUncompress/build"
cd ${PROGPATH}/$PackageName/$NameUncompress/build
RunCmds "cmake -DCMAKE_INSTALL_PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE .."
RunCmds "make -j4"
cd ${PROGPATH}/$PackageName/$NameUncompress/scripts
RunCmds "./simple_test.sh"
cd ${PROGPATH}/$PackageName/$NameUncompress/build
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"

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

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
