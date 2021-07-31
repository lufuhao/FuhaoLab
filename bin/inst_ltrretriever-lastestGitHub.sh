#!/bin/bash
source FuhaoLab.conf


PackageName="ltrretriever"
PackageVersTemp="version"
InternetLink='oushujun/LTR_retriever.git'
NameUncompress="LTR_retriever"
TestCmd="./LTR_retriever --help"
#PackageVers=""

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#AC_INIT([MUMmer], [4.0.0beta2], [gmarcais@umd.edu])
#PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/configure.ac | sed 's/^AC_INIT.*jellyfish\], \[//;s/\].*$//g')
#PrintInfo "Version: $PackageVers"
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
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
#RunCmds "cmake -DCMAKE_INSTALL_PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE .."
#RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
#RunCmds "make"
#RunCmds "make test"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "make install"

if [ -s ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/paths ]; then
	if [ ! -s ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/paths.bak ]; then
		mv ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/paths ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/paths_bak
	fi
fi
PrintInfo "Info: configure path for blast+, repeatmasker, hmmer, cdhit"
mypath=$(CmdPath "makeblastdb")
PrintInfo "BLAST+=$mypath"
echo "BLAST+=$mypath" > ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/paths
mypath=$(CmdPath "RepeatMasker")
PrintInfo "RepeatMasker=$mypath"
echo "RepeatMasker=$mypath" >> ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/paths
mypath=$(CmdPath "hmmsearch")
PrintInfo "HMMER=$mypath"
echo "HMMER=$mypath" >> ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/paths
mypath=$(CmdPath "cd-hit-est")
PrintInfo "CDHIT=$mypath"
echo "CDHIT=$mypath" >> ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/paths

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 255 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\$PATH"
ModuleInfo "blastplus cdhit hmmer repeatmasker"
ModuleAppend "## module load blastplus cdhit hmmer repeatmasker"
ModuleAppend "prereq blastplus"
ModuleAppend "prereq cdhit"
ModuleAppend "prereq hmmer"
ModuleAppend "prereq repeatmasker"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

#DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
