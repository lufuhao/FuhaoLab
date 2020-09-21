#!/bin/bash
source FuhaoLab.conf


PackageName="picard"
PackageVers="v2.22.4"
InternetLink="https://github.com/broadinstitute/picard/releases/download/2.22.4/picard.jar"
TestCmd="./picard"


NameCompress="picard.jar"
CheckPath $PackageName $PackageVers
DeletePath $PROGPATH/$PackageName/$PackageVers/$MACHTYPE

mkdir -p $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
DownloadWget $InternetLink $NameCompress

echo '#!/bin/bash' > picard
echo "java -jar $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin/picard.jar \"\$@\"" >> picard
chmod +x picard
$TestCmd
if [ $? -ne 1 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export PICARD_JAR=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/picard.jar"
ModuleAppend "setenv    PICARD_JAR    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin/picard.jar"

exit 0
