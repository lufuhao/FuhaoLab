#!/bin/bash
source FuhaoLab.conf


PackageName="bcftools"
PackageVersTemp="version"
InternetLink='https://github.com/samtools/bcftools.git'
NameUncompress="bcftools"
TestCmd="./bcftools --help"
#PackageVers=""


CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
configureOptions=""
#if [ ! -z "$HTSDIR" ]; then
#	configureOptions=" ${configureOptions} --with-htslib $HTSDIR "
#else
	git clone --recursive git://github.com/samtools/htslib.git
	if [ $? -ne 0 ]; then
		echo "Error: failed to download HTSlib" >&2
		exit 100
	fi
#fi



cd ${PROGPATH}/$PackageName/$NameUncompress
#AC_INIT([MUMmer], [4.0.0beta2], [gmarcais@umd.edu])
#PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/configure.ac | sed 's/^AC_INIT.*jellyfish\], \[//;s/\].*$//g')
PackageVers="v"$(bash version.sh)
PrintInfo "Version: $PackageVers"
#PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

#cd ${PROGPATH}/$PackageName
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
#RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
#cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE


cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "autoheader"
RunCmds "autoconf -Wno-syntax"
#RunCmds "autoreconf"
RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE $configureOptions  --enable-libgsl --enable-perl-filters"
RunCmds "make"
RunCmds "make test"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make install"
mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/include
RunCmds "cp *.h ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/include"
RunCmds "cp -a -v -R plugins/ ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/"



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
AddBashrc "export BCFTOOLS_PLUGINS=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/plugins"
ModuleAppend "setenv    BCFTOOLS_PLUGINS    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/plugins"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
DeletePath ${PROGPATH}/$PackageName/htslib

exit 0
