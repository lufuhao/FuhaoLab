#!/bin/bash
source FuhaoLab.conf


PackageName="bambam"
PackageVers="v1.4"
InternetLink="https://sourceforge.net/projects/bambam/files/bambam-1.4.tgz"
NameUncompress="bambam"
TestCmd="./polyCat --help"

if [ -z "$BAMTOOLS_ROOT" ] || [ ! -d "$BAMTOOLS_ROOT/include" ] || [ ! -d "$BAMTOOLS_ROOT/lib" ]; then
	PrintError "Error: please set BAMTOOLS_ROOT"
	exit 100
fi
if [ -z "$SAMTOOLS_ROOT" ] || [ ! -d "$SAMTOOLS_ROOT/include" ] || [ ! -d "$SAMTOOLS_ROOT/lib" ]; then
	PrintError "Error: please set SAMTOOLS_ROOT"
	exit 100
fi
if [ -z "$HTSDIR" ] || [ ! -d "$HTSDIR/include" ] || [ ! -d "$HTSDIR/lib" ]; then
	PrintError "Error: please set HTSDIR"
	exit 100
fi
export LIBRARY_PATH=$BAMTOOLS_ROOT/lib:$SAMTOOLS_ROOT/lib:$HTSDIR/lib:$LIBRARY_PATH
### need libbam.a, libhts.a, libbamtools.a, libbamtools-utils.a, libz.a


NameCompress=$PackageName-$PackageVers.tgz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xvf $NameCompress"
fi
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv $PROGPATH/$PackageName/$PackageVers/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$MACHTYPE"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
### src/gardener.cpp Line Line168:
###    fprintf (OUT, "%d\n", titles.size());
### to 
###    fprintf (OUT, "%ld\n", titles.size());
sed -i 's/fprintf (OUT, "%d\\n", titles.size());/fprintf (OUT, "%ld\\n", titles.size());/' $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/src/gardener.cpp
mkdir $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/inc/old
mv $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/inc/bamtools $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/inc/htslib $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/inc/samtools $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/inc/old
ln -sf $SAMTOOLS_ROOT/include $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/inc/samtools
make INC="-Iinc -I$BAMTOOLS_ROOT/include/bamtools -I$HTSDIR/include" all
#RunCmds "make all"

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=$PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin:$PROGPATH/$PackageName/$PackageVers/$MACHTYPE/scripts:\$PATH"
ModuleInfo "bamtools zlib samtools-v1+ htslib"
ModuleAppend "prereq bamtools"
ModuleAppend "prereq samtools"
ModuleAppend "prereq htslib"
ModuleAppend "prepend-path    PATH    $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin"
ModuleAppend "prepend-path    PATH    $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/scripts"

exit 0
