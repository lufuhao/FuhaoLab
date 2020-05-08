#!/bin/bash
source FuhaoLab.conf


PackageName="fastqc"
PackageVers="v0.11.9"
InternetLink="https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip"
NameUncompress="FastQC"
TestCmd="./fastqc --help"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "unzip $NameCompress"
fi
mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

sed -i '1c #!/usr/bin/env perl' fastqc
chmod +x fastqc
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
