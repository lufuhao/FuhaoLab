#!/bin/bash
#https://github.com/pezmaster31/bamtools
source FuhaoLab.conf


PackageName="bamtools"
PackageVersTemp="version"
InternetLink='https://github.com/pezmaster31/bamtools.git'
NameUncompress="bamtools"
TestCmd="./bamtools --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
cd ${PROGPATH}/$PackageName/$NameUncompress
mkdir ${PROGPATH}/$PackageName/$NameUncompress/build
cd ${PROGPATH}/$PackageName/$NameUncompress/build
RunCmds "cmake -DCMAKE_INSTALL_PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE .."
RunCmds "make install"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export BAMTOOLS_ROOT=$PROGPATH/$PackageName/$PackageVers/$MACHTYPE"

rm -rf ${PROGPATH}/$PackageName/$NameUncompress

exit 0
