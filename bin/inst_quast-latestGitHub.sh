#!/bin/bash
source FuhaoLab.conf
#https://github.com/ablab/quast

PackageName="quast"
PackageVersTemp="version"
InternetLink='https://github.com/ablab/quast.git'
NameUncompress="quast"
TestCmd="./quast.py -help"
#PackageVers="v1.10dev-9760f756"

#CheckPythonModules 'numpy' 'scipy' 'sympy' 'requests'


CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

CreatePath ${PROGPATH}/$PackageName/$NameUncompress/quast_libs/augustus3.2.3/
cd ${PROGPATH}/$PackageName/$NameUncompress/quast_libs/augustus3.2.3/
RunCmds "wget http://bioinf.uni-greifswald.de/augustus/binaries/old/augustus-3.2.3.tar.gz"
cd ${PROGPATH}/$PackageName/$NameUncompress

#PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
#PackageVers="v"$(grep ^'version' setup.py | sed "s/^.*\s\+'//; s/'.*$//;")"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"

#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
if [ -f ${PROGPATH}/$PackageName/$NameUncompress/VERSION.txt ]; then
	PackageVers="v"$(head -n 1 VERSION.txt)"-"$(git describe --abbrev=7 --always  --long --match v* origin/master)
	PrintInfo "Version: $PackageVers"
else
	PackageVers="v"$(git describe --always --tags --dirty | sed 's/^quast_//;s/\-[0-9]\+\-g/-/;s/[0-9a-zA-Z]\{1,1\}$//;')
	PrintInfo "Version: $PackageVers"
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "python3 setup.py build"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
### Basic installation (120M)
#RunCmds "python3 setup.py install --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
### Full installation (about 540 MB)
RunCmds "python3 setup.py install_full --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

FindPythonLib ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib
PrintInfo "export PYTHONPATH=$PythonLibPath:\$PYTHONPATH"
export PYTHONPATH=$PythonLibPath:$PYTHONPATH
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PYTHONPATH=$PythonLibPath:\$PYTHONPATH"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"
ModuleAppend "prepend-path    PYTHONPATH    $PythonLibPath"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"

#DeletePath ${PROGPATH}/$PackageName/$NameUncompress

exit 0
