#!/bin/bash
source FuhaoLab.conf


PackageName="SpliceSeq"
PackageVers="v2.3"
InternetLink="http://projects.insilico.us.com/SpliceSeq_2.3/SpliceSeq.zip"
NameUncompress="SpliceSeq"
TestCmd="java -cp SpliceSeq.jar --help"

if CmdExists "java"; then
	echo "Info: java dextected"
else
	PrintError "Error: java not found"
	exit 100
fi

NameCompress=$PackageName-$PackageVers.zip
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "unzip $NameCompress"
fi



cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export SPLICESEQ_ROOT=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
AddBashrc "export SPLICESEQ_JAR=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/SpliceSeq.jar"
AddBashrc "export CLASSPATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/SpliceSeq.jar:${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/SpliceSeqAnalyze.jar:\$CLASSPATH"
ModuleAppend "setenv    SPLICESEQ_ROOT    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
ModuleAppend "setenv    SPLICESEQ_JAR    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/SpliceSeq.jar"
ModuleAppend "prepend-path    CLASSPATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/SpliceSeq.jar:${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/SpliceSeqAnalyze.jar"


exit 0

#$ mysql -u root -p
#mysql> CREATE DATABASE SpliceGraph CHARACTER SET latin1 COLLATE latin1_general_ci;
#mysql> GRANT SELECT ON SpliceGraph.* TO 'sguser'@'localhost' IDENTIFIED BY 'sgpass';
#mysql> GRANT SELECT ON SpliceGraph.* TO 'sguser'@'%' IDENTIFIED BY 'sgpass';
#mysql>GRANT ALL ON SpliceGraph.* TO 'sgload'@'localhost' IDENTIFIED BY 'sg4ld!';
#mysql>GRANT ALL ON SpliceGraph.* TO 'sgload'@'%' IDENTIFIED BY 'sg4ld!';
#mysql>exit;
