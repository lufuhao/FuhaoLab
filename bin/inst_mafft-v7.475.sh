#!/bin/bash
source FuhaoLab.conf


PackageName="mafft"
PackageVers="v7.475"
InternetLink="https://mafft.cbrc.jp/alignment/software/mafft-7.475-with-extensions-src.tgz"
NameUncompress="mafft-7.475-with-extensions"
TestCmd="./mafft --help"

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
sed -i "s/^PREFIX.*/PREFIX = ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE" ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/core/Makefile
sed -i "s/^PREFIX.*/PREFIX = ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE" ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/extensions/Makefile
cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/core
#RunCmds "./configure --enable-lib --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --with-gmapdb=$BIODATABASES/gmapdb"
RunCmds "make clean"
RunCmds "make"
#RunCmds "make check"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE install"

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100
fi
$TestCmd
if [ $? -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
