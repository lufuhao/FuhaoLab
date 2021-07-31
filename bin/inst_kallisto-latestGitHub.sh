#!/bin/bash
#https://github.com/pachterlab/kallisto
source FuhaoLab.conf


PackageName="kallisto"
PackageVersTemp="version"
InternetLink='pachterlab/kallisto.git'
NameUncompress="kallisto"
TestCmd="./kallisto index"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
cd ${PROGPATH}/$PackageName/$NameUncompress

DeletePath ${PROGPATH}/$PackageName/$NameUncompress/build
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$NameUncompress/build"
cd ${PROGPATH}/$PackageName/$NameUncompress/build
unset C_INCLUDE_PATH; unset CPLUS_INCLUDE_PATH
RunCmds "cmake -DCMAKE_INSTALL_PREFIX:PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE .."
RunCmds "make"
DeletePath $PROGPATH/$PackageName/$PackageVers
RunCmds "make install"
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
