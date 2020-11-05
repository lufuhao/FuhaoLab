#!/bin/bash
source FuhaoLab.conf

PackageName="deepTools"
TestCmd="./deeptools --help"

CheckPythonModules 'matplotlib' 'numpy' 'numpydoc' 'plotly' 'py2bit' 'pyBigWig' 'pysam' 'scipy' 'cycler' 'pillow' 'certifi' 'kiwisolver' 'python-dateutil' 'pyparsing' 'sphinx' 'Jinja2' 'six' 'alabaster' 'sphinxcontrib-htmlhelp' 'sphinxcontrib-applehelp' 'sphinxcontrib-jsmath' 'snowballstemmer' 'Pygments' 'sphinxcontrib-serializinghtml' 'sphinxcontrib-qthelp' 'docutils' 'babel' 'requests' 'packaging' 'sphinxcontrib-devhelp' 'imagesize' 'setuptools' 'MarkupSafe' 'pytz'

getPipModVersion "$PackageName"
PackageVers=$pipModuleVersion
PrintInfo "Version: $PackageVers"
DeletePath ${PROGPATH}/$PackageName/$PackageVers
CheckPath $PackageName/$PackageVers

cd ${PROGPATH}/$PackageName/$PackageVers
RunCmds "pip3 install --prefix=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE $PackageName"

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

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PYTHONPATH=$PythonLibPath:\$PYTHONPATH"
if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"
fi
ModuleAppend "prepend-path    PYTHONPATH    $PythonLibPath"
if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin ]; then
	ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin"
fi

exit 0
