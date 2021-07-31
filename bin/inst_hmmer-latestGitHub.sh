#!/bin/bash
source FuhaoLab.conf
### https://github.com/EddyRivasLab/hmmer

PackageName="hmmer"
PackageVersTemp="version"
InternetLink='EddyRivasLab/hmmer.git'
NameUncompress="hmmer"
TestCmd="./hmmscan -h"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#AC_INIT(HMMER, 3.3.1, sean@eddylab.org, hmmer)
PackageVers="v"$(grep ^'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/configure.ac | cut -f 2 -d',' | sed 's/ //g')"-"$(git describe --abbrev=7 --always  --long --match v* origin/master)
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
git clone ${GITHUB_CUSTOM_SITE}/EddyRivasLab/easel.git
if [ $? -ne 0 ]; then
	echo "Error: failed to download easel" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "autoconf"
RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --enable-mpi --enable-threads"
RunCmds "make"
RunCmds "make check"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"
RunCmds "cd easel"
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
