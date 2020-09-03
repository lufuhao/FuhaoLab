#!/bin/bash
### HOMEPAGE: http://research-pub.gene.com/gmap/
### Require: zlib bzip2
source FuhaoLab.conf


PackageName="gsnap"
PackageVers="v20200408"
InternetLink="http://research-pub.gene.com/gmap/src/gmap-gsnap-2020-04-08.tar.gz"
NameUncompress="gmap-2020-04-08"



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
if [ ! -d $BIODATABASES/gmapdb ]; then
	mkdir -p $BIODATABASES/gmapdb
fi
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
PrintInfo "Info: GMAPDB was set to $BIODATABASES/gmapdb"
AddBashrc "export GMAPDB=$BIODATABASES/gmapdb"

exit 0
