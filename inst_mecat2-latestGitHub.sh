#!/bin/bash
source FuhaoLab.conf


PackageName="MECAT2"
PackageVersTemp="version"
InternetLink='https://github.com/xiaochuanle/MECAT2.git'
NameUncompress="MECAT2"
TestCmd="./mecat.pl --help"

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


#PackageVers="v20190314-f54c542"
cd ${PROGPATH}/$PackageName
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"


cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make"

#PackageVers="v20190314-f54c542"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/$(uname)-$(uname -m | sed 's/x86_64/amd64/')/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/$(uname)-$(uname -m | sed 's/x86_64/amd64/')
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/$(uname)-$(uname -m | sed 's/x86_64/amd64/') "$PackageName-$PackageVers"

exit 0
