#!/bin/bash
source FuhaoLab.conf


PackageName="hylite"
PackageVers="v2.0.2"
InternetLink="https://sourceforge.net/projects/hylite/files/HyLiTE-2.0.2-py3-none-any.whl"
NameUncompress="hylite-v2.0.2"
TestCmd="./HyLiTE --help"

CheckPythonModules "scipy"

NameCompress=$PackageName-$PackageVers-py3-none-any.whl
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
RunCmds "mkdir -p ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress"
RunCmds "unzip -d ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress $NameCompress"

#easy_install --prefix=/path/to/my/preferred/directory/ /path/to/egg/HyLiTE-2.0.2-py3-none-any.whl
cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
RunCmds "python3 setup.py build"
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "python3 setup.py install --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

FindPythonLib ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/lib
PrintInfo "export PYTHONPATH=$PythonLibPath/HyLiTE-2.0.2-py3.8.egg:\$PYTHONPATH"
export PYTHONPATH=$PythonLibPath/HyLiTE-2.0.2-py3.8.egg:$PYTHONPATH
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PYTHONPATH=$PythonLibPath/HyLiTE-2.0.2-py3.8.egg:\$PYTHONPATH"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"
ModuleAppend "prepend-path    PYTHONPATH    $PythonLibPath/HyLiTE-2.0.2-py3.8.egg"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
exit 0
