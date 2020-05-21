#!/bin/bash
#https://github.com/alexdobin/STAR
source FuhaoLab.conf


PackageName="star"
PackageVersTemp="version"
InternetLink='https://github.com/alexdobin/STAR.git'
NameUncompress="STAR"
TestCmd="./STAR --help"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers="v"$(head -n 1 ${PROGPATH}/$PackageName/$NameUncompress/RELEASEnotes.md | cut -f 2 -d' ')
PackageVers=$PackageVers"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress/source
#RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
#RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
unset LIBRARY_PATH; unset LD_LIBRARY_PATH; unset unset C_INCLUDE_PATH; unset CPLUS_INCLUDE_PATH;
RunCmds "make"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"
RunCmds "cp STAR ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"

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
