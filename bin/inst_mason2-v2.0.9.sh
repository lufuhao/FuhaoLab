#!/bin/bash
source FuhaoLab.conf


PackageName="mason2"
PackageVers="v2.0.9"
InternetLink="http://packages.seqan.de/mason2/mason2-2.0.9-Linux-x86_64_sse4.tar.xz"
NameUncompress="mason2-2.0.9-Linux-x86_64_sse4"
TestCmd="./mason_simulator --help"

NameCompress=$PackageName-$PackageVers-Linux-x86_64_sse4.tar.xz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
DownloadWget http://packages.seqan.de/mason2/mason2-2.0.9-Linux-x86_64.tar.xz "$PackageName-$PackageVers-Linux-x86_64.tar.xz"
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xvf $NameCompress"
fi

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
	exit 100
fi
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
