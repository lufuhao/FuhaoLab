#!/bin/bash
source FuhaoLab.conf


PackageName="repeatmodeler"
PackageVers="v2.0.2a"
InternetLink="http://www.repeatmasker.org/RepeatModeler/RepeatModeler-2.0.2a.tar.gz"
NameUncompress="RepeatModeler-2.0.2a"
TestCmd="./RepeatModeler --help"

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
#RunCmds "./configure --enable-lib --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --with-gmapdb=$BIODATABASES/gmapdb"
#RunCmds "make"
#RunCmds "make check"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "make install"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#$TestCmd
if [ ! -x ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/RepeatModeler ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

echo -e "\n\n\n"
PrintInfo "Info: please run following CMDs to configure RepeatModeler"
PrintInfo "perl ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/configure"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
