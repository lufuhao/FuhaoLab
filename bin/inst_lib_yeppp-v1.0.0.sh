#!/bin/bash
source FuhaoLab.conf


PackageName="yeppp"
PackageVers="v1.0.0"
InternetLink="https://sourceforge.net/projects/old-software-collection/files/yeppp-v1.0.0.tar.bz2"
NameUncompress="yeppp-1.0.0"


NameCompress="$PackageName-$PackageVers.tar.bz2"
CheckLibPath $PackageName $PackageVers

#:<<EOM

DownloadWget $InternetLink $NameCompress
#if [ ! -d $NameUncompress ]; then
#	RunCmds "tar xvf $NameCompress"
#fi

#EOM

cd ${PROGPATH}/libraries/$PackageName/$PackageVers
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
#RunCmds "mv ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
tar xvf ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameCompress

#cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
#RunCmds "cmake -DCMAKE_INSTALL_PREFIX==${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE .."
#RunCmds "autoheader"
#RunCmds "autoconf"
#RunCmds "./configure --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
#RunCmds "make"
#RunCmds "make test"
#if [ -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE ]; then
#	DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
#fi
#RunCmds "make install"

#EOM

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
if [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
	PrintError "Error: failed to install $PackageName-$PackageVers"
	exit 100
fi

#EOM

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
ModuleAppend "setenv    YEPPPLIBDIR    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib"
ModuleAppend "setenv    YEPPPINCLUDEDIR    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include"
AddEnvironVariable ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export YEPPPLIBDIR=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib"
AddBashrc "export YEPPPINCLUDEDIR=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include"

#DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
exit 0
