#!/bin/bash
source FuhaoLab.conf


PackageName="htslib"
PackageVersTemp="version"
InternetLink='https://github.com/samtools/htslib.git'
NameUncompress="htslib"


CheckLibPath $PackageName
cd ${PROGPATH}/libraries/$PackageName/
DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress
git clone --recursive $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/libraries/$PackageName/$NameUncompress
PackageVers="v"$(git describe origin/master)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"

RunCmds "autoheader"
RunCmds "autoconf"
RunCmds "./configure --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "make"
RunCmds "make test"
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"

if [ ! -d $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE

AddEnvironVariable $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export HTSDIR=$PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE"
ModuleAppend "setenv    HTSDIR    $PROGPATH/libraries/$PackageName/$PackageVers/$MACHTYPE"

DeletePath ${PROGPATH}/libraries/$PackageName/$NameUncompress

exit 0
