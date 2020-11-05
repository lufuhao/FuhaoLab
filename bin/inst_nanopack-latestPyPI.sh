#!/bin/bash
source FuhaoLab.conf

PackageName="nanopack"
TestCmd="./NanoPlot --help"

CheckPythonModules 'joypy' 'matplotlib' 'numpy' 'pandas' 'plotly' 'pyarrow' 'seaborn' 'biopython' 'mappy' 'kaleido' 'pauvre' 'pysam' 'python-dateutil' 'scipy' 'bokeh' 'Python-Deprecated' 'pillow' 'cycler' 'pyparsing' 'certifi' 'kiwisolver' 'pytz' 'six' 'retrying' 'scikit_learn' 'Jinja2' 'PyYAML' 'packaging' 'tornado' 'typing_extensions' 'threadpoolctl' 'joblib' 'psutil' 'MarkupSafe'

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
