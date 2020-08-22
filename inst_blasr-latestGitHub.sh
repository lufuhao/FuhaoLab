#!/bin/bash
source FuhaoLab.conf
#https://github.com/mchaisso/blasr
#https://github.com/PacificBiosciences/blasr

PackageName="blasr"
PackageVersTemp="version"
InternetLink='https://github.com/mchaisso/blasr.git'
NameUncompress="blasr"
TestCmd="./blasr -h"

if [ -z "$HDF5INCLUDEDIR" ] || [ -z "$HDF5LIBDIR" ]; then
	PrintError "Error: HDF5INCLUDEDIR HDF5LIBDIR are needed"
	exit 100
fi

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers="v"$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "make"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make  PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE install"
if [ -d $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
	if [ -x blasrmc ]; then
		ln -sf $PWD/blasrmc blasr
	fi
	if [ -x sawritermc ]; then
		ln -sf $PWD/sawritermc sawriter
	fi
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress

exit 0
