#!/bin/bash
#https://github.com/COMBINE-lab/salmon
source FuhaoLab.conf


PackageName="salmon"
PackageVersTemp="version"
InternetLink='https://github.com/COMBINE-lab/salmon.git'
NameUncompress="salmon"
TestCmd="./salmon --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
cd ${PROGPATH}/$PackageName/$NameUncompress

#PackageVersTemp1=$(grep 'VERSION_MAJOR' ${PROGPATH}/$PackageName/$NameUncompress/current_version.txt | cut -f 2 -d' ')
#PackageVersTemp2=$(grep 'VERSION_MINOR' ${PROGPATH}/$PackageName/$NameUncompress/current_version.txt | cut -f 2 -d' ')
#PackageVersTemp3=$(grep 'VERSION_PATCH' ${PROGPATH}/$PackageName/$NameUncompress/current_version.txt | cut -f 2 -d' ')
#PackageVers="v"${PackageVersTemp1}.${PackageVersTemp2}.${PackageVersTemp3}"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
cd ${PROGPATH}/$PackageName/$NameUncompress

DeletePath ${PROGPATH}/$PackageName/$NameUncompress/build
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$NameUncompress/build"
cd ${PROGPATH}/$PackageName/$NameUncompress/build
RunCmds "cmake -DCMAKE_INSTALL_PREFIX:PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE .."
RunCmds "make"
RunCmds "make test"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"
exit 0
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress

exit 0
