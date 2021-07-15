#!/bin/bash
source FuhaoLab.conf


PackageName="repeatscout"
PackageVers="v1.0.6"
InternetLink="http://www.repeatmasker.org/RepeatScout-1.0.6.tar.gz"
NameUncompress="RepeatScout-1.0.6"
TestCmd="./RepeatScout --help"

NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
mkdir ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/include
#RunCmds "./configure --enable-lib --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --with-gmapdb=$BIODATABASES/gmapdb"
sed -i '14s/1.0.5$/1.0.6/' ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/Makefile
RunCmds "make"
#RunCmds "make check"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "make install"
find -perm /+x -type f | xargs -i cp {} ./bin
cp *.h include

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
ModuleInfo "Requirements: nseg trf repeatmasker"
ModuleAppend "###module load nseg trf repeatmasker"
ModuleAppend "prereq nseg"
ModuleAppend "prereq trf"
ModuleAppend "prereq repeatmasker"
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
