#!/bin/bash
source FuhaoLab.conf


PackageName="picard"
PackageVers="v2.22.4"
InternetLink="https://github.com/broadinstitute/picard/releases/download/2.22.4/picard.jar"
TestCmd="./picard"


NameCompress="picard.jar"
CheckPath $PackageName $PackageVers
if [ -d $PROGPATH/$PackageName/$PackageVers/$MACHTYPE ]; then
	rm -rf $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
fi
mkdir -p $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin
DownloadWget $InternetLink $NameCompress
echo '#!/bin/bash' > picard
echo "java -jar $PROGPATH/$PackageName/$PackageVers/$MACHTYPE/bin \"\$@\"" >> picard
chmod +x picard
bash $TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd $PROGPATH/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable $PROGPATH/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
