#!/bin/bash
### HOMEPAGE: http://research-pub.gene.com/gmap/
### Require: zlib bzip2
source FuhaoLab.conf


PackageName="gsnap"
PackageVers="v20210527"
InternetLink="http://research-pub.gene.com/gmap/src/gmap-gsnap-2021-05-27.tar.gz"
NameUncompress="gmap-2021-05-27"


if [ -z "$GMAPDB" ]; then
	if [ -z "$BIODATABASES" ]; then
		PrintError: "Error: GMAPDB would be NOT set as $BIODATABASES not defined"
		exit 100
	fi
	GmapDatabase=$BIODATABASES/gmapdb
else
	GmapDatabase=$GMAPDB
fi
PrintInfo "GMAPDB was set to $GmapDatabase"
if [ ! -d $GmapDatabase ]; then
	mkdir -p $GmapDatabase
fi



NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DeletePath $PROGPATH/$PackageName/$PackageVers/$NameUncompress
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

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
if [ ! -z "$GmapDatabase" ]; then
	ModuleAppend "setenv    GMAPDB    $GmapDatabase"
	PrintInfo "Info: GMAPDB was set to $GmapDatabase"
	AddBashrc "export GMAPDB=$GmapDatabase"
fi

DeletePath $PROGPATH/$PackageName/$PackageVers/$NameUncompress
exit 0
