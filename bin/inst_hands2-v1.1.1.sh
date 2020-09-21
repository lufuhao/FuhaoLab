#!/bin/bash
source FuhaoLab.conf


PackageName="hands2"
PackageVers="v1.1.1"
InternetLink="https://genomics.lums.edu.pk/software/hands2/hands2v1.1.1.tar.gz"
NameUncompress="hands2"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
DownloadWget 'https://genomics.lums.edu.pk/software/hands2/filter_sam_vcf.tar.gz' 'filter_sam_vcf.tar.gz'
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi
if [ ! -d filter_sam_vcf ]; then
	tar xzvf filter_sam_vcf.tar.gz
fi

cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress
java -jar $PROGPATH/$PackageName/$PackageVers/$NameUncompress/hands2.jar
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/filter_sam_vcf
RunCmds 'make'
mv filter filter_sam_vcf


AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/filter_sam_vcf "$PackageName-filter_sam_vcf"
AddBashrc "export PATH_HANDS2_JAR=$PROGPATH/$PackageName/$PackageVers/$NameUncompress/hands2.jar"
ModuleAppend "setenv    PATH_HANDS2_JAR    $PROGPATH/$PackageName/$PackageVers/$NameUncompress/hands2.jar"

exit 0
