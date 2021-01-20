#!/bin/bash
source FuhaoLab.conf


PackageName="genetribe"
PackageVersTemp="version"
InternetLink='https://github.com/chenym1/genetribe.git'
NameUncompress="genetribe"
TestCmd="./genetribe --help"
#PackageVers=""

CmdExit 'blastp'
CmdExit 'bedtools'
python -m jcvi.compara >/dev/null 2>&1
if [ $? -ne 1 ]; then
	PrintError "Error: command not found: python -m jcvi.compara"
    exit 127
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
#def PrintVersion() :
#	print ("Version: 1.0.0")
#PackageVers="v"$(grep 'Version:' ${PROGPATH}/$PackageName/$NameUncompress/genetribe | sed 's/^.*Version:\s\+//; s/")$//')
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
#RunCmds "cmake -DCMAKE_INSTALL_PREFIX=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE .."
#RunCmds "./configure --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
#RunCmds "make"
#RunCmds "make test"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "make install"
if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	rm -rf ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
fi
mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
for ph in ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/src/*py ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/src/*sh;do
	pc=`basename $ph | cut -d"." -f1`
	echo "bulding "`basename $ph`
	ln -s $ph $pc
	chmod +x $pc
done

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
chmod -x install.sh
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\$PATH"
ModuleInfo "module load blastplus bedtools jcvi genetribe"
ModuleAppend "prereq blastplus"
ModuleAppend "prereq bedtools"
ModuleAppend "prereq jcvi"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

#DeletePath ${PROGPATH}/$PackageName/$NameUncompress

exit 0
