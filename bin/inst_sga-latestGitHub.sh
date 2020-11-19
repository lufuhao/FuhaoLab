#!/bin/bash
source FuhaoLab.conf
#https://github.com/jts/sga


PackageName="sga"
PackageVersTemp="version"
#InternetLink='https://github.com/jts/sga.git'
InternetLink='https://github.com/lufuhao/sga.git'
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
else
	PrintError "Error: please set BAMTOOLS_ROOT or module load bamtools"
	exit 100
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
#PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/src/configure.ac | sed 's/^AC_INIT.*sga, //;s/, .*$//g')"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

#cd ${PROGPATH}/$PackageName
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
#RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

#cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/src
cd ${PROGPATH}/$PackageName/$NameUncompress/src
#sed -i '95s/c++98/c++11/' configure.ac
#sed -i '70s/getline/static_cast<bool>(getline/; 70s/;$/);/;' Util/ClusterReader.cpp
#sed -i '235s/getline/static_cast<bool>(getline/; 235s/;$/);/;' SGA/rmdup.cpp
#sed -i '122s/parser/static_cast<bool>(parser/; 122s/;$/);/;' Util/StdAlnTools.cpp
RunCmds "./autogen.sh"
RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE $ConfigureOptions"
RunCmds "make"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"
for indExc in `find ${PROGPATH}/$PackageName/$NameUncompress/src/bin -perm /+x -type f`; do
	RunCmds "cp $indExc ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/"
done

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100
fi
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"
ModuleInfo "### requirements: bwa"
ModuleInfo "### module load bwa sga"
ModuleAppend "prereq    bwa"
ModuleAppend "prepenf-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
