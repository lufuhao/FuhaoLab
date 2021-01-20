#!/bin/bash
source FuhaoLab.conf


PackageName="samtools"
PackageVers="v0.1.20"
InternetLink="https://github.com/samtools/samtools/archive/0.1.20.tar.gz"
NameUncompress="samtools-0.1.20"
TestCmd="./samtools"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
DeletePath $PROGPATH/$PackageName/$PackageVers/$NameUncompress
RunCmds "tar xzvf $NameCompress"

cd $PROGPATH/$PackageName/$PackageVers/$NameUncompress
RunCmds "make"
DeletePath $PROGPATH/$PackageName/$PackageVers/x86_64
mkdir -p $PROGPATH/$PackageName/$PackageVers/x86_64/bin $PROGPATH/$PackageName/$PackageVers/x86_64/lib $PROGPATH/$PackageName/$PackageVers/x86_64/include/bam $PROGPATH/$PackageName/$PackageVers/x86_64/share/man/man1
find misc/ -perm /+x -type f | xargs -i cp {} $PROGPATH/$PackageName/$PackageVers/x86_64/bin/
cp samtools bcftools/bcftools bcftools/vcfutils.pl $PROGPATH/$PackageName/$PackageVers/x86_64/bin/
cp *.a bcftools/libbcf.a $PROGPATH/$PackageName/$PackageVers/x86_64/lib/
cp *.h bcftools/*.h $PROGPATH/$PackageName/$PackageVers/x86_64/include/bam/
cp *.1 $PROGPATH/$PackageName/$PackageVers/x86_64/share/man/man1/

cd $PROGPATH/$PackageName/$PackageVers/x86_64/bin
$TestCmd
if [ $? -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/x86_64
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/x86_64 "$PackageName-$PackageVers"
AddBashrc "export SAMTOOLS_ROOT=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
ModuleAppend "setenv    SAMTOOLS_ROOT    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

DeletePath $PROGPATH/$PackageName/$PackageVers/$NameUncompress
exit 0
