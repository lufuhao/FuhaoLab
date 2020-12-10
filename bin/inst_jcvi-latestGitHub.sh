#!/bin/bash
source FuhaoLab.conf

PackageName="jcvi"
PackageVersTemp="version"
InternetLink='https://github.com/lufuhao/jcvi.git'
InternetLink='https://github.com/tanghaibao/jcvi.git'
NameUncompress="jcvi"
TestCmd="python3 -m jcvi.formats.fasta extract"
#PackageVers="v20200321-7b6f7c80"

CheckPythonModules 'biopython' 'boto3' 'coveralls' 'cython' 'deap' 'ete3' 'gffutils' 'jinja2' 'matplotlib' 'networkx' 'numpy' 'graphviz' 'PyPDF2' 'pytest' 'pytest-cov' 'pytest-benchmark' 'PyYAML' 'scipy' 'seaborn'

CheckPath $PackageName
cd ${PROGPATH}/$PackageName
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone $InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$NameUncompress
PackageVers=$(git tag -l | tail -n 1)"-"$(git branch -vv | cut -f 3 -d' ')
PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --abbrev=7 --always  --long --match v* origin/master)
#PrintInfo "Version: $PackageVers"
#PackageVers=$(git describe --always --tags --dirty)
#PrintInfo "Version: $PackageVers"

cd ${PROGPATH}/$PackageName/$NameUncompress
RunCmds "python3 setup.py build"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "python3 setup.py install --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

FindPythonLib ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib
PythonLibPath=$(ls -d $PythonLibPath/jcvi-*.egg)
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
ModuleInfo "module load emboss kent bedtools"
ModuleAppend "prereq emboss"
ModuleAppend "prereq kent"
ModuleAppend "prereq bedtools"
ModuleAppend "prepend-path    PYTHONPATH    $PythonLibPath"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
