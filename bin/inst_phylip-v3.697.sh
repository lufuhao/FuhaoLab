#!/bin/bash
source FuhaoLab.conf


PackageName="phylip"
PackageVers="v3.697"
InternetLink="http://evolution.gs.washington.edu/phylip/download/phylip-3.697.tar.gz"
NameUncompress="phylip-3.697"
TestCmd="./phylip --help"

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

cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/src
cp Makefile.unx Makefile
#sed -i "s/^EXEDIR.*/EXEDIR = ${PROGPATH}\/$PackageName\/$PackageVers\/$MACHTYPE\/bin/g" ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/src/Makefile
#RunCmds "./configure --enable-lib --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --with-gmapdb=$BIODATABASES/gmapdb"
RunCmds "make all"
#RunCmds "make check"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make EXEDIR=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin install"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib
mv ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/libdrawgram.so ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib
mv ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/libdrawtree.so ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100
fi
#$TestCmd
#if [ $? -ne 0 ]; then
if [ ! -x dnaml ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
