#!/bin/bash
source FuhaoLab.conf


PackageName="recon"
PackageVers="v1.08"
InternetLink="http://www.repeatmasker.org/RepeatModeler/RECON-1.08.tar.gz"
NameUncompress="RECON-1.08"
TestCmd="./bowtie --help"

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
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/src
#RunCmds "./configure --enable-lib --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE --with-gmapdb=$BIODATABASES/gmapdb"
RunCmds "make CC=gcc"
#RunCmds "make test"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/scripts
sed -i '1s|/perl$|/env perl|' ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/scripts/recon.pl
sed -i "3s|\"\";$|\"${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin\";|" ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/scripts/recon.pl
sed -i '1s|/perl$|/env perl|' ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/scripts/MSPCollect.pl


cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
if [ ! -x ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/scripts/recon.pl ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/scripts:\$PATH"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/scripts"

#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
