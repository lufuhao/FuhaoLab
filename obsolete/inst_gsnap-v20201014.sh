#!/bin/bash
### HOMEPAGE: http://research-pub.gene.com/gmap/
### Require: zlib bzip2
source FuhaoLab.conf


PackageName="gsnap"
PackageVers="v20201014"
InternetLink="http://research-pub.gene.com/gmap/src/gmap-gsnap-2020-10-14.tar.gz"
NameUncompress="gmap-2020-10-14"



if [ -z "$BIODATABASES" ]; then
	PrintError: "Error: GMAPDB would be NOT set as $BIODATABASES not defined"
	exit 100
fi

NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress
if [ -z "$GMAPDB" ]; then
	GmapDatabase=$BIODATABASES/gmapdb
else
	GmapDatabase=$GMAPDB
fi
if [ ! -d $GmapDatabase ]; then
	mkdir -p $GmapDatabase
fi
cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress/src
for file in `ls *.h *.c`; do echo $file; sed -i 's/^#include <config.h>/#include "config.h"/' $file; done
cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress
RunCmds "./configure --enable-lib --prefix=$PROGPATH/$PackageName/$PackageVers/x86_64 --with-gmapdb=$BIODATABASES/gmapdb --enable-zlib --enable-bzlib"
RunCmds "make"
RunCmds "make check"
RunCmds "make install"
cd $PROGPATH/$PackageName/$PackageVers/x86_64/bin
./gsnap --help
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/$PackageName/$PackageVers/x86_64
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/x86_64 "$PackageName-$PackageVers"
if [ -z "$GMAPDB" ]; then
	PrintInfo "Info: GMAPDB was set to $GmapDatabase"
	AddBashrc "export GMAPDB=$GmapDatabase"
	ModuleAppend "setenv    GMAPDB    $GmapDatabase"
fi

DeletePath $PROGPATH/$PackageName/$PackageVers/$NameUncompress
exit 0
