#!/bin/bash
source FuhaoLab.conf


PackageName="htslib"
PackageVersTemp="version"
InternetLink='https://github.com/samtools/htslib.git'
NameUncompress="htslib"

CheckLibPath $PackageName
cd ${PROGPATH}/libraries/$PackageName/
if [ -d ${PROGPATH}/libraries/$PackageName/$NameUncompress ]; then
	RunCmds "rm -rf ${PROGPATH}/libraries/$PackageName/$NameUncompress"
fi
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/libraries/$PackageName/$NameUncompress

PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
RunCmds "autoheader"
RunCmds "autoconf"
RunCmds "./configure --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
RunCmds "make test"
RunCmds "make install"
if [ ! -d $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

RunCmds "rm -rf ${PROGPATH}/$PackageName/$NameUncompress"

exit 0
