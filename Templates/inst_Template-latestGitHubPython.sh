#!/bin/bash
source FuhaoLab.conf


PackageName="cutadapt"
PackageVersTemp="version"
InternetLink='marcelm/cutadapt.git'
NameUncompress="cutadapt"
TestCmd="./cutadapt --help"
#PackageVers=""

CheckPythonModules 'dnaio' 'xopen'

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
PackageVers="v"$(grep 'AC_INIT' ${PROGPATH}/$PackageName/$NameUncompress/configure.ac | sed 's/^AC_INIT.*jellyfish\], \[//;s/\].*$//g')
PrintInfo "Version: $PackageVers"
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
PrintInfo "Version: $PackageVers"
PackageVers=$(git describe --always --tags --dirty)
PrintInfo "Version: $PackageVers"


exit 0
cd ${PROGPATH}/$PackageName
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers"
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE


cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "python3 setup.py build"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "python3 setup.py install --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"



exit 0
FindPythonLib ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib
PrintInfo "export PYTHONPATH=$PythonLibPath:\$PYTHONPATH"
export PYTHONPATH=$PythonLibPath:$PYTHONPATH
if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
	$TestCmd
	if [ $? -ne 0 ]; then
		echo "Error: failed to install $PackageName-$PackageVers" >&2
		exit 100
	fi
fi



AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PYTHONPATH=$PythonLibPath:\$PYTHONPATH"
if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"
fi
ModuleAppend "prepend-path    PYTHONPATH    $PythonLibPath"
if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"
fi

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
