#!/bin/bash
source FuhaoLab.conf


PackageName="bamaddrg"
PackageVers="version"
InternetLink='https://github.com/lufuhao/bamaddrg.git'
NameUncompress="bamaddrg"
TestCmd="./bamaddrg --help"

CheckPath $PackageName $PackageVers
cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
#git clone --recursive $InternetLink
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
PackageVersTemp="v"$(head -n 1 ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress/VERSION | sed 's/^version \+//;')
PrintInfo "Version: $PackageVersTemp"
cd ${PROGPATH}/$PackageName
DeletePath ${PROGPATH}/$PackageName/$PackageVersTemp
mv ${PROGPATH}/$PackageName/$PackageVers ${PROGPATH}/$PackageName/$PackageVersTemp
PackageVers=$PackageVersTemp
cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bamtools
git clone https://github.com/pezmaster31/bamtools.git
if [ $? -ne 0 ]; then
	echo "Error: failed to download BamTools" >&2
	exit 100
fi
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bamtools_Src
mv ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bamtools ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bamtools_Src
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bamtools_Src
mkdir ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bamtools_Src/build
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bamtools_Src/build
RunCmds "cmake -DCMAKE_INSTALL_PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bamtools .."
RunCmds "make"
RunCmds "make install"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bamtools_Src
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make BAMTOOLS_ROOT=$PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bamtools"
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bamtools

exit 0
