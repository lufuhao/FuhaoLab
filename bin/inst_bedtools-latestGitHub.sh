#!/bin/bash
source FuhaoLab.conf


PackageName="bedtools"
PackageVersTemp="version"
InternetLink='arq5x/bedtools2.git'
NameUncompress="bedtools2"
TestCmd="./bedtools --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $GITHUB_CUSTOM_SITE/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#VERSION_FILE=./src/utils/version/version_git.h
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
unset C_INCLUDE_PATH
unset CPATH
RunCmds "make"
RunCmds "make test"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make prefix=$PROGPATH/$PackageName/$PackageVers/$MACHTYPE install"

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
