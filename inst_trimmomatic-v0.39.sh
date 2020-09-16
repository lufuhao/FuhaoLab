#!/bin/bash
#http://www.usadellab.org/cms/?page=trimmomatic
source FuhaoLab.conf


PackageName="trimmomatic"
PackageVers="v0.39"
InternetLink="http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip"
NameUncompress="Trimmomatic-0.39"
#TestCmd="java -jar trimmomatic-0.39.jar -version"
TestCmd="java org.usadellab.trimmomatic.TrimmomaticPE"

if CmdExists 'java'; then
	echo "Info: Java detected"
	RunCmds "java -version"
else
	PrintInfo "Error: JAVA are needed to run trimmomatic. please install JAVA/JAVASE first"
	exit 100
fi

NameCompress=$PackageName-$PackageVers.zip
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress

cd ${PROGPATH}/$PackageName/$PackageVers
if [ -d ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE ]; then
	DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
fi
if [ -d ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ]; then
	DeletePath ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress
fi
RunCmds "unzip $NameCompress"
mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
echo "Version: "
java -classpath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/trimmomatic-0.39.jar org.usadellab.trimmomatic.TrimmomaticPE -version
if [ $? -ne 0 ]; then
	PrintInfo "Warnings: failed to run classpath $PackageName-$PackageVers"
	exit 100
fi
echo "#!/bin/bash" >> ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/trimmomatic
echo "java -jar ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/trimmomatic-0.39.jar \$@" >> ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/trimmomatic
chmod +x ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/trimmomatic

if [ -s ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/trimmomatic-0.39.jar ]; then
	AddBashrc "### $PackageName-$PackageVers"
	AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\${PATH}"
	AddBashrc "export TRIMMOMATIC_ROOT=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	AddBashrc "export TRIMMOMATIC_ADAPTERS=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/adapters"
	AddBashrc "export TRIMMOMATIC_JAR=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/trimmomatic-0.39.jar"
	AddBashrc "export CLASSPATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/trimmomatic-0.39.jar:\$CLASSPATH"
	ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	ModuleAppend "setenv    TRIMMOMATIC_ROOT    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
	ModuleAppend "setenv    TRIMMOMATIC_ADAPTERS    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/adapters"
	ModuleAppend "setenv    TRIMMOMATIC_JAR    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/trimmomatic-0.39.jar"
	ModuleAppend "prepend-path    CLASSPATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/trimmomatic-0.39.jar"
fi

exit 0
