#!/bin/bash
source FuhaoLab.conf


PackageName="genometools"
PackageVers="v1.6.2"
InternetLink="http://genometools.org/pub/genometools-1.6.2.tar.gz"
NameUncompress="genometools-1.6.2"
TestCmd="./gt ltrharvest -help"

#libOpt=""
#if [ -z "$JEMALLOC_ROOT" ]; then
#	LibExist "libjemalloc"
#else
#	libOpt=" --with-jemalloc=$JEMALLOC_ROOT/lib"
#fi

NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

#cd ${PROGPATH}/$PackageName/$PackageVers
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
#cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress

#RunCmds "./configure --enable-lib --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --with-gmapdb=$BIODATABASES/gmapdb"
RunCmds "make threads=yes 64bit=yes"
#RunCmds "make test"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE install"

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100
fi
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
