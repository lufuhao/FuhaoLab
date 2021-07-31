#!/bin/bash
source FuhaoLab.conf

PackageName="eggnogmapper"
PackageVersTemp="version"
InternetLink='eggnogdb/eggnog-mapper.git'
NameUncompress="eggnog-mapper"
TestCmd="./emapper.py --help"
PackageVers="v1.0-bf97058"

CheckPythonModules 'biopython'

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone -b refactor ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
### VERSION = '1.0'
PackageVers="v"$(grep ^'VERSION' setup.py | sed "s/^.*\s\+'//; s/'.*$//;")"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
CreatePath ${PROGPATH}/$PackageName/$PackageVers
RunCmds "mv ${PROGPATH}/$PackageName/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
### find ./ -type f -print -exec grep -in 'python' {} \;
#sed -i '1s/python$/python2/' download_eggnog_data.py
#sed -i '1s/python$/python2/' emapper.py
#sed -i '1s/python$/python2/' eggnogmapper/search.py
#sed -i '1s/python$/python2/' setup.py
chmod -x release.py
#chmod -x test.py

#cd ${PROGPATH}/$PackageName/$NameUncompress
#RunCmds "python2 setup.py build"
#DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
#RunCmds "python2 setup.py install --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

#FindPythonLib ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib
#PrintInfo "export PYTHONPATH=$PythonLibPath:\$PYTHONPATH"
#export PYTHONPATH=$PythonLibPath:$PYTHONPATH
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
#AddBashrc "export PYTHONPATH=$PythonLibPath:\$PYTHONPATH"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\$PATH"
#ModuleAppend "prepend-path    PYTHONPATH    $PythonLibPath"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
