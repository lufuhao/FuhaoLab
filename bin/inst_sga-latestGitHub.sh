#!/bin/bash
source FuhaoLab.conf
#https://github.com/jts/sga


PackageName="sga"
PackageVersTemp="version"
InternetLink='https://github.com/jts/sga.git'
NameUncompress="sga"
TestCmd="./sga --help"
#PackageVers=""

ConfigureOptions=""
if [ ! -z "$SPARSEHASH_ROOT" ]; then
	ConfigureOptions="  --with-sparsehash=$SPARSEHASH_ROOT "
fi
if [ ! -z "$JEMALLOC_ROOT" ]; then
	ConfigureOptions=" $ConfigureOptions --with-jemalloc=$JEMALLOC_ROOT "
fi
if [ ! -z "$BAMTOOLS_ROOT" ]; then
	ConfigureOptions=" $ConfigureOptions --with-bamtools=$BAMTOOLS_ROOT "
fi

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#AC_INIT(sga, 0.10.15, js18@sanger.ac.uk)
PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/src/configure.ac | sed 's/^AC_INIT.*sga, //;s/, .*$//g')"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress/src
sed -i '95s/c++98/c++11/' ${PROGPATH}/$PackageName/$NameUncompress/src/configure.ac
sed -i '70s/getline/static_cast<bool>(getline/; 70s/;$/);/;' ${PROGPATH}/$PackageName/$NameUncompress/src/Util/ClusterReader.cpp
sed -i '235s/getline/static_cast<bool>(getline/; 235s/;$/);/;' ${PROGPATH}/$PackageName/$NameUncompress/src/SGA/rmdup.cpp
sed -i '122s/parser/static_cast<bool>(parser/; 122s/;$/);/;' ${PROGPATH}/$PackageName/$NameUncompress/src/Util/StdAlnTools.cpp
RunCmds "./autogen.sh"
RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE $ConfigureOptions"
RunCmds "make"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100s
fi
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
