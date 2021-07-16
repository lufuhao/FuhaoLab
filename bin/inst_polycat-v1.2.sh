#!/bin/bash
source FuhaoLab.conf


PackageName="polycat"
PackageVers="v1.2"
InternetLink="http://128.192.141.98/ftproot/CottonFiber/polyCat_12.zip"
NameUncompress="polyCat_12"
TestCmd="./polyCat --help"

#libOpt=""
if [ -z "$BAMTOOLS_ROOT" ]; then
	PrintError "Error: please set BAMTOOLS_ROOT"
	exit100
elif [ ! -L $BAMTOOLS_ROOT/lib/libbamtools.so ]; then
	PrintError "Error: compile BAMtools with -DBUILD_SHARED_LIBS=ON"
	exit 100
elif [ ! -d $BAMTOOLS_ROOT/include/bamtools ]; then
	PrintError "Error: BAMtools include NOT found"
	exit 100
fi

NameCompress=$PackageName-$PackageVers.zip
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "unzip $NameCompress"
fi



cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

#cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
RunCmds "g++ -o polyCat -I $BAMTOOLS_ROOT/include/bamtools polyCat-1.2.cpp $BAMTOOLS_ROOT/lib/libbamtools.so -O3"
RunCmds "g++ -o polyCat-methyl -I $BAMTOOLS_ROOT/include/bamtools polyCat-1.2.cpp $BAMTOOLS_ROOT/lib/libbamtools.so -O3 -D_MODE_BS"

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100
fi
#$TestCmd
#if [ $? -ne 0 ]; then
if [ ! -x ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/polyCat ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\$PATH"
ModuleInfo "bamtools zlib samtools-v1+ htslib"
ModuleAppend "prereq bamtools"
ModuleAppend "prereq samtools"
ModuleAppend "prereq htslib"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"


#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
