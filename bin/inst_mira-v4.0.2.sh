#!/bin/bash
source FuhaoLab.conf


PackageName="mira"
PackageVers="v4.0.2"
InternetLink="https://sourceforge.net/projects/mira-assembler/files/MIRA/stable/mira_4.0.2_linux-gnu_x86_64_static.tar.bz2"
#NameUncompress="mira-4.0.2"
NameUncompress="mira_4.0.2_linux-gnu_x86_64_static"
#TestCmd="./mira --help"

NameCompress=$PackageName-$PackageVers.linux-gnu_x86_64_static.tar.bz2
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xvf $NameCompress"
fi



cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"



#cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "./configure --enable-lib --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --with-gmapdb=$BIODATABASES/gmapdb"
#RunCmds "make"
#RunCmds "make check"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "make install"



cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
#$TestCmd
#if [ $? -ne 0 ]; then
if [ ! -x ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/mira ]; then
	echo "Error: Failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
