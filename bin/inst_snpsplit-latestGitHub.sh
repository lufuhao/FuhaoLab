#!/bin/bash
source FuhaoLab.conf


PackageName="snpsplit"
PackageVersTemp="version"
InternetLink='https://github.com/FelixKrueger/SNPsplit.git'
NameUncompress="SNPsplit"
TestCmd="./SNPsplit --help"
PackageVers="v0.4.0-36fd82a"


CmdExit 'perl'

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#AC_INIT([MUMmer], [4.0.0beta2], [gmarcais@umd.edu])
#PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/configure.ac | sed 's/^AC_INIT.*jellyfish\], \[//;s/\].*$//g')
#PrintInfo "Version: $PackageVers"
PackageVers="v"$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#cd ${PROGPATH}/$PackageName/$NameUncompress
#RunCmds "cmake -DCMAKE_INSTALL_PREFIX=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE .."
#RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
#RunCmds "make"
#RunCmds "make test"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "make install"
mkdir ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
for indBin in `find $PWD/ -maxdepth 1 -perm /+x -type f`; do
	mv $indBin ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
done
mkdir ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/docs
for indDoc in `find $PWD/ -maxdepth 1 -name "*.pdf" -type f`; do
	mv $indDoc ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/docs
done

if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
elif [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
else
	PrintError "Error: install path not found: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	exit 100s
fi
$TestCmd
if [ $? -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"
ModuleInfo "module load samtools snpsplit"
ModuleAppend "prereq samtools"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"

#DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
