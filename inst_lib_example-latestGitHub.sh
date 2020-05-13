#!/bin/bash
source FuhaoLab.conf


PackageName="htslib"
PackageVersTemp="version"
InternetLink='git@github.com:samtools/htslib.git'
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
PackageVers="v"$(bash ${PROGPATH}/libraries/$PackageName/$NameUncompress/version.sh)
cd ${PROGPATH}/libraries/$PackageName/$NameUncompress
RunCmds "autoheader"
RunCmds "autoconf"
RunCmds "./configure --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
RunCmds "make test"
RunCmds "make install"
if [ ! -d $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE

AddEnvironVariable $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

rm -rf ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
exit 0
