#!/bin/bash
### HOMEPAGE: http://research-pub.gene.com/gmap/
### Require: zlib bzip2
source FuhaoLab.conf


PackageName="gsnap"
PackageVers="v20200408"
InternetLink="http://research-pub.gene.com/gmap/src/gmap-gsnap-2020-04-08.tar.gz"
NameUncompress="gmap-2020-04-08"



NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi
cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress
if [ ! -d $BIODATABASES/gmapdb ]; then
	mkdir -p $BIODATABASES/gmapdb
fi
#RunCmds "./configure --enable-lib --prefix=$PROGPATH/$PackageName/$PackageVers/x86_64 --with-gmapdb=$BIODATABASES/gmapdb"
#RunCmds "make"
#RunCmds "make check"
#RunCmds "make install"
cd $PROGPATH/$PackageName/$PackageVers/x86_64/bin
./gsnap -h
if [ $? -ne 0 ]; then
	cd ../
	AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/x86_64 "$PackageName-$PackageVers"
	echo "Info: GMAPDB was set to $BIODATABASES/gmapdb"
else
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
