#!/bin/bash
source FuhaoLab.conf


PackageName="miniconda3"
PackageVers="version"
InternetLink="https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh"
#NameUncompress="htslib-1.10.2"

CreatePath ${PROGPATH}/libraries/$PackageName
cd ${PROGPATH}/libraries/$PackageName
NameCompress="Miniconda3-latest-Linux-x86_64.sh"
DownloadWget $InternetLink $NameCompress
PackageVers="v"$(bash ${PROGPATH}/libraries/$PackageName/Miniconda3-latest-Linux-x86_64.sh  -h | grep ^'Installs Miniconda3' | sed 's/^.*\s\+//g;s/py[0-9]\+_//g;')
PrintInfo "Version: $PackageVers"
CheckLibPath $PackageName $PackageVers
CreatePath ${PROGPATH}/libraries/$PackageName/$PackageVers
RunCmds "mv ${PROGPATH}/libraries/$PackageName/Miniconda3-latest-Linux-x86_64.sh ${PROGPATH}/libraries/$PackageName/$PackageVers/"


cd ${PROGPATH}/libraries/$PackageName/$PackageVers/
DeletePath ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
RunCmds "bash Miniconda3-latest-Linux-x86_64.sh  -b -f -p ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/bin
./conda --version
#if [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/lib ] || [ ! -d ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/include ]; then
if [ $? -ne 0 ]; then
	PrintError "Error: failed to install $PackageName-$PackageVers"
	exit 100
fi
#./conda init

condaRC_file="${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/.condarc"
if [ -e $condaRC_file ]; then
	rm -rf $condaRC_file > /dev/null 2>&1
fi
condaConfRc $condaRC_file

cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE
#AddEnvironVariable ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export CONDA_ROOT=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
ModuleAppend "setenv    CONDA_ROOT    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
#if [ -s ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/etc/profile.d/conda.sh ]; then
#	AddBashrc "source ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/etc/profile.d/conda.sh"
#	ModuleAppend "source-sh    bash    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/etc/profile.d/conda.sh"
#else
	AddBashrc "export PATH=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/bin:\$PATH"
	ModuleAppend "prepend-path    PATH    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/bin"
#fi
AddBashrc "export CONDARC=$condaRC_file:\$CONDARC"
ModuleAppend "prepend-path    CONDARC    $condaRC_file"
#AddBashrc "export CONDA_ENVS_PATH=${PROGPATH}/libraries/$PackageName/envs:${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/envs:\$CONDA_ENVS_PATH"
#ModuleAppend "prepend-path    CONDA_ENVS_PATH    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/envs"
#ModuleAppend "prepend-path    CONDA_ENVS_PATH    ${PROGPATH}/libraries/$PackageName/envs"
#AddBashrc "export CONDA_PKGS_DIRS=${PROGPATH}/libraries/$PackageName/pkgs:${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/pkgs:\$CONDA_PKGS_DIRS"
#ModuleAppend "prepend-path    CONDA_PKGS_DIRS    ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/pkgs"
#ModuleAppend "prepend-path    CONDA_PKGS_DIRS    ${PROGPATH}/libraries/$PackageName/pkgs"

if [ -e ${PROGPATH}/libraries/$PackageName/$NameCompress ]; then
	rm ${PROGPATH}/libraries/$PackageName/$NameCompress > /dev/null 2>&1
fi
exit 0
