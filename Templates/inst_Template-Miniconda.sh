#!/bin/bash
source FuhaoLab.conf

PackageName="edta"
EnvName="EDTA"
PackageVersTemp="version"
TestCmd="EDTA.pl --help"
#PackageVers=""

getCondaPackVers "$PackageName" "bioconda"
PackageVers=$condaPackVersion
PrintInfo "Package: $PackageName"
PrintInfo "Version: $PackageVers"
DeletePath ${PROGPATH}/$PackageName/$PackageVers

#exit 0

CheckPath $PackageName $PackageVers
CreatePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
conda create -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/$EnvName --yes
if [ $? -ne 0 ]; then
	PrintError "Error: conda failed to create ENV: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/$EnvName"
	exit 100
fi
source activate ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/$EnvName
if [ -z "$CONDA_DEFAULT_ENV" ] || [ -z "$CONDA_PREFIX" ]; then
	PrintError "Error: conda failed to activate ENV: ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/$EnvName"
	exit 100
else
	PrintInfo "Current ENV: $CONDA_DEFAULT_ENV"
	PrintInfo " ENV prefix: $CONDA_PREFIX"
fi

#exit 0

cd ${PROGPATH}/$PackageName
InternetLink='oushujun/EDTA.git'
NameUncompress="EDTA"
DeletePath ${PROGPATH}/$PackageName/$NameUncompress
git clone ${GITHUB_CUSTOM_SITE}/$InternetLink
if [ $? -ne 0 ]; then
	echo "Error: failed to download $PackageName" >&2
	exit 100
fi
cd ${PROGPATH}/$PackageName/$NameUncompress
conda env update --file EDTA.yml -p ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/$EnvName
if [ $? -ne 0 ]; then
	echo "Error: failed to update YML" >&2
	exit 100
fi

#exit 0

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
ModuleInfo "module load $PackageName/$PackageVers"
ModuleInfo "conda activate $EnvName"
ModuleAppend "prepend-path    CONDA_ENVS_PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export CONDA_ENVS_PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\$CONDA_ENVS_PATH"

DeletePath ${PROGPATH}/$PackageName/$NameUncompress
conda deactivate
exit 0
