#!/bin/bash
source FuhaoLab.conf
#https://github.com/wdecoster/nanofilt

PackageName="nanofilt"
PackageVersTemp="version"
InternetLink='wdecoster/nanofilt.git'
NameUncompress="nanofilt"
TestCmd="./NanoFilt --help"
#PackageVers="v2.6.0-0e6b86f"

CheckPythonModules 'pandas' 'biopython' 'pytz' 'python-dateutil' 'numpy'


CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers="v"$(grep ^'version' setup.py | sed "s/^.*\s\+'//; s/'.*$//;")"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "python3 setup.py build"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "python3 setup.py install --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

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

DeletePath ${PROGPATH}/$PackageName/$NameUncompress

exit 0
