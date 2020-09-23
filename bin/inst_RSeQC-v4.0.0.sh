#!/bin/bash
source FuhaoLab.conf
#https://multiqc.info/
#https://sourceforge.net/projects/rseqc/

PackageName="RSeQC"
PackageVers="v4.0.0"
InternetLink='https://sourceforge.net/projects/rseqc/files/RSeQC-4.0.0.tar.gz'
NameUncompress="RSeQC-4.0.0"
TestCmd="./FPKM_count.py --help"
#PackageVers="v1.10dev-9760f756"

CheckPythonModules 'cython' 'pysam' 'bx-python' 'numpy' 'pyBigWig'


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
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

DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
exit 0
