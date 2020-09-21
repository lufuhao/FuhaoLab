#!/bin/bash
source FuhaoLab.conf


PackageName="mcscanx"
PackageVers="v20130328"
#InternetLink="http://chibba.pgml.uga.edu/mcscan2/MCScanX.zip"
#NameUncompress="MCScanX"
InternetLink="https://github.com/lufuhao/MCScanX/archive/v20130328.tar.gz"
NameUncompress="MCScanX-20130328"
TestCmd="./MCScanX -h"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi


DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
if [[ "$MACHTYPE" =~ 64 ]]; then
	TestFile=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/msa.cc
	RtnStr=$(sed -n '4,4p' $TestFile)
	if [[ "$RtnStr" =~ unistd\.h ]]; then
		echo ""
	else
		echo "Modifying $TestFile"
		cp $TestFile $TestFile.bak
		sed -i '4i #include <unistd.h>' $TestFile
	fi
	TestFile=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/dissect_multiple_alignment.cc
	RtnStr=$(sed -n '2,2p' $TestFile)
	if [[ "$RtnStr" =~ getopt\.h ]]; then
		echo ""
	else
		echo "Modifying $TestFile"
		cp $TestFile $TestFile.bak
		sed -i '2i #include <getopt.h>' $TestFile
	fi
	TestFile=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/detect_collinear_tandem_arrays.cc
	RtnStr=$(sed -n '2,2p' $TestFile)
	if [[ "$RtnStr" =~ getopt.h ]]; then
		echo ""
	else
		echo "Modifying $TestFile"
		cp $TestFile $TestFile.bak
		sed -i '2i #include <getopt.h>' $TestFile
	fi
fi
RunCmds "make"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export CLASSPATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/downstream_analyses:\$CLASSPATH"
ModuleAppend "prepend-path    CLASSPATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/downstream_analyses"

exit 0
