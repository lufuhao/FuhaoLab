#!/bin/bash
source FuhaoLab.conf


PackageName="NECAT"
PackageVersTemp="version"
InternetLink='https://github.com/xiaochuanle/NECAT.git'
NameUncompress="NECAT"
TestCmd="./necat.pl --help"
#PackageVers="v0.01-61e779e"

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

cd ${PROGPATH}/$PackageName
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"


cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/src
RunCmds "make"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/$(uname)-$(uname -m | sed 's/x86_64/amd64/')/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/$(uname)-$(uname -m | sed 's/x86_64/amd64/')
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/$(uname)-$(uname -m | sed 's/x86_64/amd64/') "$PackageName-$PackageVers"

exit 0
