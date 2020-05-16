#!/bin/bash
#https://github.com/primer3-org/primer3
source FuhaoLab.conf


PackageName="primer3"
PackageVersTemp="version"
InternetLink='git@github.com:primer3-org/primer3.git'
NameUncompress="primer3"
TestCmd="./primer3_core --help"
#return 255

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
if [ -d ${PROGPATH}/$PackageName/$NameUncompress ]; then
	RunCmds "rm -rf ${PROGPATH}/$PackageName/$NameUncompress"
fi
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
#release 2.5.0 2019-08-17  ===============================================
PackageVers="v"$(head -n 1 ${PROGPATH}/$PackageName/$NameUncompress/src/release_notes.txt | cut -f 2 -d' ')
PrintInfo "Version: $PackageVers"
cd ${PROGPATH}/$PackageName/$NameUncompress/src
RunCmds "make"
RunCmds "make test"
if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	RunCmds "rm -rf ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
fi
RunCmds "make PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE install"
if [ ! -d $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	echo "Error: failed to make $PackageName-$PackageVers" >&2
	exit 100
fi

cp -R ${PROGPATH}/$PackageName/$NameUncompress/src/primer3_config ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
if [ ! -x $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin/primer3_core ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
PrintInfo "export PRIMER_THERMODYNAMIC_PARAMETERS_PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/primer3_config"
echo "export PRIMER_THERMODYNAMIC_PARAMETERS_PATH=\${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/primer3_config" >> $EnvironFilePath

rm -rf ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress

exit 0
