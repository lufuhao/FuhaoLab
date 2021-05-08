#!/bin/bash
source FuhaoLab.conf
#https://github.com/aristocratos/bpytop

PackageName="bpytop"
PackageVersTemp="version"
InternetLink='https://github.com/aristocratos/bpytop.git'
NameUncompress="bpytop"
TestCmd="./bpytop --help"
#PackageVers="v1.0.63-a2cdebd"

CheckPythonModules 'psutil'

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
#PackageVers="v"$(grep ^'version' setup.py | sed "s/^.*\s\+'//; s/'.*$//;")"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master | perl -lne 's/-\d+-g/-/;print;')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE install"

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
