#!/bin/bash
#https://github.com/lufuhao/FuhaoPerl5Lib

source FuhaoLab.conf

if [ ! -d $PROGPATH/perl5lib ]; then
	mkdir -p $PROGPATH/perl5lib
fi
cd $PROGPATH/perl5lib
DeletePath $PROGPATH/perl5lib/FuhaoPerl5Lib

cd $PROGPATH/perl5lib
git clone https://github.com/lufuhao/FuhaoPerl5Lib.git
if [ $? -eq 0 ] && [ -d $PROGPATH/perl5lib/FuhaoPerl5Lib ]; then
	cd $PROGPATH/perl5lib
	AddBashrc "export PERL5LIB=${PROGPATH}/perl5lib:\$PERL5LIB"
	ModuleAppend "prepend-path    PERL5LIB    ${PROGPATH}/perl5lib"
else
	echo "Error: failed to install FuhaoPerl5Lib" >&2
	exit 100
fi

echo -e "\n\n"
PrintInfo "Visit https://github.com/lufuhao/FuhaoPerl5Lib to install required Perl5 modules"

exit 0
