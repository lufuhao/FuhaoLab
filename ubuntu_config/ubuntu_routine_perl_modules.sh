#!/bin/bash

#Term::Readline
sudo apt-get install libterm-readline-gnu-perl libxml-dom-perl libxml-dom-perl-xpath-perl libxml-dom-xpath-perl libxml-perl libxml-regexp-perl 


###Perl
Cpan_install_Options=" -M http://mirrors.ustc.edu.cn/CPAN/ "
sudo cpan $Cpan_install_Options -i Module::Build

#sudo cpan
#o conf prefer_installer MB
#o conf commit
#o conf makepl_arg INSTALL_BASE=/mydir/perl
#o conf commit

sudo cpan $Cpan_install_Options -i Bundle::CPAN
#sudo apt-get install libnet-dns-zonefile-fast-perl 
sudo cpan $Cpan_install_Options -i Net::DNS
sudo cpan $Cpan_install_Options -i GD
sudo cpan $Cpan_install_Options -i Text::CSV_XS
sudo cpan $Cpan_install_Options -i Module::Find
sudo cpan $Cpan_install_Options -i Scalar::Util
sudo cpan $Cpan_install_Options -i Cwd
sudo cpan $Cpan_install_Options -i Getopt::Long
sudo cpan $Cpan_install_Options -i FindBin
sudo cpan $Cpan_install_Options -i Data::Dumper
sudo cpan $Cpan_install_Options -i File::Basename
sudo cpan $Cpan_install_Options -fi BioPerl



### compile samtools with make CFLAGS=" -g -Wall -O2 -fPIC -m64"
#install Bio::DB::Sam

