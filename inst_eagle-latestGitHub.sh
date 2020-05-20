#!/bin/bash
#https://github.com/tony-kuo/eagle/
source FuhaoLab.conf


PackageName="eagle"
PackageVersTemp="version"
InternetLink='https://github.com/tony-kuo/eagle.git'
NameUncompress="eagle"
TestCmd="./eagle --version"

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
git clone https://github.com/samtools/htslib.git
if [ $? -ne 0 ] || [ ! -d ${PROGPATH}/$PackageName/$NameUncompress/htslib ]; then
	echo "Error: failed to download HTSLIB" >&2
	exit 100
fi

RunCmds "make"
DeletePath $PROGPATH/$PackageName/$PackageVers/
RunCmds "mkdir -p $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin"
RunCmds "make PREFIX=$PROGPATH/$PackageName/$PackageVers/$MACHTYPE install"

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

RunCmds "rm -rf ${PROGPATH}/$PackageName/$NameUncompress"

exit 0
