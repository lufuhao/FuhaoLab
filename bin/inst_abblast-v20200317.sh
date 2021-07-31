#!/bin/bash
source FuhaoLab.conf


PackageName="abblast"
PackageVers="v20200317"
#InternetLink="${GITHUB_CUSTOM_SITE}/BenLangmead/bowtie/archive/v1.2.3.tar.gz"
NameUncompress="ab-blast-20200317-linux-x64"
TestCmd="./ab-blastn"
MACHTYPE="x64"
licenseDir="$HOME/.config/ab-blast"

NameCompress="$NameUncompress.tar.gz"
CheckPath $PackageName $PackageVers
cd ${PROGPATH}/$PackageName/$PackageVers
if [ ! -s $NameCompress ] || [ ! -s "license.xml" ]; then
	PrintError "Error: please put two files in ${PROGPATH}/$PackageName/$PackageVers folder: $NameCompress and license.xml"
	exit 100
else
	tar xvf $NameCompress
	if [ ! -d $licenseDir ]; then
		mkdir -p $licenseDir
	fi
	cp license.xml $licenseDir
	chmod 600 $licenseDir/license.xml
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

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 5 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
#ABBLASTDB, ABBLASTFILTER and ABBLASTMAT
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
