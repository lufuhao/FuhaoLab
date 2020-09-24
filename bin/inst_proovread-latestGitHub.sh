#!/bin/bash
source FuhaoLab.conf


PackageName="proovread"
PackageVersTemp="version"
InternetLink='https://github.com/BioInf-Wuerzburg/proovread.git'
NameUncompress="proovread"
TestCmd="./proovread -V"
#-h return 1
#PackageVers="v2.14.1-6f5a6b4"

perlModExist "Cwd" "Data::Dumper" "File::Basename" "File::Copy" "File::Path" "File::Spec" "File::Temp" "File::Which" "FindBin" "Getopt::Long" "List::Util" "Log::Log4perl" "Storable" "Thread::Queue" "threads" "Time::HiRes"

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone --recursive $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1 | sed 's/proovread-/v/')"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "make"
RunCmds "make sample"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make PREFIX=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE install"

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
ModuleAppend "prereq    samtools"
ModuleAppend "prereq    blastplus"
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"


DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
