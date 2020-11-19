#!/bin/bash
#https://genomethreader.org/download.html
source FuhaoLab.conf


PackageName="genomethreader"
PackageVers="v1.7.3"
InternetLink="https://genomethreader.org/distributions/gth-1.7.3-Linux_x86_64-64bit.tar.gz"
NameUncompress="gth-1.7.3-Linux_x86_64-64bit"
TestCmd="./gth --help"

#libOpt=""
#if [ -z "$JEMALLOC_ROOT" ]; then
#	LibExist "libjemalloc"
#else
#	libOpt=" --with-jemalloc=$JEMALLOC_ROOT/lib"
#fi

NameCompress=$PackageName-$PackageVers-Linux_x86_64-64bit.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi


cd ${PROGPATH}/$PackageName
CreatePath ${PROGPATH}/$PackageName/bssm
CreatePath ${PROGPATH}/$PackageName/gthdata
cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

#cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
#RunCmds "./configure --enable-lib --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --with-gmapdb=$BIODATABASES/gmapdb"
#RunCmds "make"
#RunCmds "make check"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "make install"

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
AddBashrc "export BSSMDIR=${PROGPATH}/$PackageName/bssm"
AddBashrc "export GTHDATADIR=${PROGPATH}/$PackageName/gthdata"
ModuleAppend "setenv    BSSMDIR    ${PROGPATH}/$PackageName/bssm"
ModuleAppend "setenv    GTHDATADIR    ${PROGPATH}/$PackageName/gthdata"

#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
