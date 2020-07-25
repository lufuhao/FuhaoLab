#!/bin/bash
source FuhaoLab.conf
### http://meme-suite.org

PackageName="meme"
PackageVers="v5.1.1"
InternetLink="http://meme-suite.org/meme-software/5.1.1/meme-5.1.1.tar.gz"
NameUncompress="meme-5.1.1"
TestCmd="./meme -version"

NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress
RunCmds "./configure --prefix=$PROGPATH/$PackageName/$PackageVers/$MACHTYPE --enable-build-libxml2 --enable-build-libxslt"
RunCmds "make"
RunCmds "make test"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export PATH=$PROGPATH/$PackageName/$PackageVers/$MACHTYPE/libexec/meme-5.1.1:\$PATH"

DeletePath $PROGPATH/$PackageName/$PackageVers/$NameUncompress

### download databases
echo ""
echo ""
echo ""
PrintInfo "cd \$BIODATABASES"
PrintInfo "### Motif Databases (updated 28 Oct 2019)"
PrintInfo "wget http://meme-suite.org/meme-software/Databases/motifs/motif_databases.12.19.tgz"
PrintInfo "### GOMo Databases (updated 17 Feb 2015)"
PrintInfo "wget http://meme-suite.org/meme-software/Databases/gomo/gomo_databases.3.2.tgz"
PrintInfo "### T-Gene Databases (updated 12 Oct 2019)"
PrintInfo "wget http://meme-suite.org/meme-software/Databases/tgene/tgene_databases.1.0.tgz"

exit 0
