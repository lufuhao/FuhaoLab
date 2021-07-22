#!/bin/bash
### Require: tbb
source FuhaoLab.conf


PackageName="bowtie"
PackageVers="v1.3.0"
InternetLink="https://github.com/BenLangmead/bowtie/archive/v1.3.0.tar.gz"
NameUncompress="bowtie-1.3.0"
TestCmd="./bowtie --help"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xvf $NameCompress"
fi

cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress
RunCmds "make"
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make prefix=$PROGPATH/$PackageName/$PackageVers/$MACHTYPE install"

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath $PROGPATH/$PackageName/$PackageVers/$NameUncompress
exit 0
