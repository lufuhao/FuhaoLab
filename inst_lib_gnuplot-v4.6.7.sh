#!/bin/bash

source FuhaoLab.conf

#require texlive-extra-utils x11


PackageName="gnuplot"
PackageVers="v4.6.7"
InternetLink="https://sourceforge.net/projects/gnuplot/files/gnuplot/4.6.7/gnuplot-4.6.7.tar.gz"
NameUncompress="gnuplot-4.6.7"
TestCmd='./gnuplot --help'

NameCompress=$PackageName-$PackageVers.tar.gz
CheckLibPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi
cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
RunCmds "./configure --prefix=${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE --enable-backwards-compatibility --enable-stats --with-gd --with-cwdrc --with-tutorial"
RunCmds "make"
RunCmds "make install"
cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi
cd ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE

AddEnvironVariable ${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
PrintInfo "export GNUPLOT=\${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE"
echo "export GNUPLOT=\${PROGPATH}/libraries/$PackageName/$PackageVers/$MACHTYPE" >> $EnvironFilePath
PrintInfo "export GNUPLOT_PS_DIR=\${GNUPLOT}share/gnuplot/4.6/PostScript"
echo "export GNUPLOT_PS_DIR=\${GNUPLOT}/share/gnuplot/4.6/PostScript" >> $EnvironFilePath

rm -rf ${PROGPATH}/libraries/$PackageName/$PackageVers/$NameUncompress
exit 0
