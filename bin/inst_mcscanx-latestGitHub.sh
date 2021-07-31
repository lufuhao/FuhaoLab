#!/bin/bash
source FuhaoLab.conf
#https://github.com/lufuhao/MCScanX.git
#http://chibba.pgml.uga.edu/mcscan2
#https://github.com/wyp1125/MCScanx



PackageName="mcscanx"
PackageVersTemp="version"
InternetLink='lufuhao/MCScanX.git'
NameUncompress="MCScanX"
TestCmd="./MCScanX -h"

:<<EOH
CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
EOH

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"

DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
if [ ! -d $PROGPATH/$PackageName/$PackageVers ]; then
	mkdir -p $PROGPATH/$PackageName/$PackageVers
fi
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress $PROGPATH/$PackageName/$PackageVers/$MACHTYPE"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
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

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export CLASSPATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/downstream_analyses:\$CLASSPATH"
ModuleAppend "prepend-path    CLASSPATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/downstream_analyses"

exit 0
