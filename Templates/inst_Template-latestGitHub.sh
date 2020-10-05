#!/bin/bash
source FuhaoLab.conf


PackageName="mummer4"
PackageVersTemp="version"
InternetLink='git@github.com:mummer4/mummer.git'
NameUncompress="mummer"
TestCmd="./bowtie --help"
#PackageVers=""

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
PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/configure.ac | sed 's/^AC_INIT.*jellyfish\], \[//;s/\].*$//g')
PrintInfo "Version: $PackageVers"
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
PrintInfo "Version: $PackageVers"
PackageVers=$(git describe --always --tags --dirty)
PrintInfo "Version: $PackageVers"


exit 0
cd ${PROGPATH}/$PackageName
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE


cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "cmake -DCMAKE_INSTALL_PREFIX==${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE .."
RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
RunCmds "make test"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"



exit 0
if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100s
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
