#!/bin/bash
source FuhaoLab.conf
#https://github.com/Kinggerm/GetOrganelle

PackageName="GetOrganelle"
PackageVersTemp="version"
InternetLink='Kinggerm/GetOrganelle.git'
NameUncompress="GetOrganelle"
TestCmd="./get_organelle_from_reads.py --help"
#PackageVers="v1.7.1-820880a"

CheckPythonModules 'numpy' 'scipy' 'sympy' 'requests'

CheckPath $PackageName
cd ${PROGPATH}/$PackageName/
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
#PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
#PackageVers="v"$(grep ^'version' setup.py | sed "s/^.*\s\+'//; s/'.*$//;")"-"$(git branch -vv | cut -f 3 -d' ')
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
PackageVers="v"$(git describe --always --tags --dirty | sed 's/-[0-9]\+-g/-/')
PrintInfo "Version: $PackageVers"

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
#curl -L https://github.com/Kinggerm/GetOrganelleDep/releases/download/v0.0.0/v0.0.0.tar.gz | tar zx
#get_organelle_config.py -a embplant_pt,embplant_mt --use-local ./0.0.0
#OR
svn co ${GITHUB_CUSTOM_SITE}/Kinggerm/GetOrganelleDB/trunk/0.0.0
get_organelle_config.py -a embplant_pt,embplant_mt --use-local ./0.0.0
#OR
#git clone ${GITHUB_CUSTOM_SITE}/Kinggerm/GetOrganelleDB
#get_organelle_config.py -a embplant_pt,embplant_mt --use-local ./GetOrganelleDB/0.0.0

### Database in ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib/python3.8/site-packages/GetOrganelle-1.7.1a0-py3.8.egg/GetOrganelleLib/SeedDatabase

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PYTHONPATH=$PythonLibPath:\$PYTHONPATH"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"
ModuleAppend "prereq    spades"
ModuleAppend "prereq    bowtie2"
ModuleAppend "prereq    blastp"
ModuleAppend "prereq    bandage"
ModuleAppend "prepend-path    PYTHONPATH    $PythonLibPath"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
