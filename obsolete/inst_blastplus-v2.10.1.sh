#!/bin/bash
source FuhaoLab.conf
### https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/

PackageName="blastplus"
PackageVers="v2.10.1"
InternetLink="https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.10.1/ncbi-blast-2.10.1+-x64-linux.tar.gz"
NameUncompress="ncbi-blast-2.10.1+"
TestCmd="./blastn -help"
MACHTYPE="x64"

NameCompress=$PackageName-$PackageVers.x64.linux.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress
RunCmds "mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$MACHTYPE"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

exit 0
