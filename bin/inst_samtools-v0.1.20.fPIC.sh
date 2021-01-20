#!/bin/bash
source FuhaoLab.conf
### For Perl module: Bio::DB::Sam
echo "Info: Compile samtools for Bio::DB::Sam"

PackageName="samtools"
PackageVers="v0.1.20"
InternetLink="https://github.com/samtools/samtools/archive/0.1.20.tar.gz"
NameUncompress="samtools-0.1.20"
TestCmd="./samtools"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
DeletePath $PROGPATH/$PackageName/$PackageVers/$NameUncompress
DeletePath $PROGPATH/$PackageName/$PackageVers/x64fPic
RunCmds "tar xzvf $NameCompress"
mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/x64fPic
cd $PROGPATH/$PackageName/$PackageVers/x64fPic
make CFLAGS=" -g -Wall -O2 -fPIC -m64"
$TestCmd
if [ $? -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

PrintInfo "Info: feed this path to Bio::DB::Sam when you install it"
PrintInfo "$PWD"

exit 0
