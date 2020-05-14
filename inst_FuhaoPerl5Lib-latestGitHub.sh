#!/bin/bash
#https://github.com/lufuhao/FuhaoPerl5Lib

source FuhaoLab.conf

if [ ! -d $PROGPATH/perl5lib ]; then
	mkdir -p $PROGPATH/perl5lib
fi
cd $PROGPATH/perl5lib
if [ -d $PROGPATH/perl5lib/FuhaoPerl5Lib ]; then
	rm -rf $PROGPATH/perl5lib/FuhaoPerl5Lib
fi
git clone https://github.com/lufuhao/FuhaoPerl5Lib.git
if [ $? -eq 0 ] && [ -d $PROGPATH/perl5lib/FuhaoPerl5Lib ]; then
	cd $PROGPATH/perl5lib
	echo "export PERL5LIB=$PWD:\$PERL5LIB" >> $EnvironFilePath
	PrintInfo "Execuate following to config PERL5LIB"
	PrintInfo "export PERL5LIB=$PWD:\$PERL5LIB"
else
	echo "Error: failed to install FuhaoPerl5Lib" >&2
	exit 100
fi

echo -e "\n\n"
PrintInfo "Visit https://github.com/lufuhao/FuhaoPerl5Lib to install required Perl5 modules"

exit 0
