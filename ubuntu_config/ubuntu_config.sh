#!/bin/bash

### mkcd
echo "function mkcd(){" >> ~/.bashrc
echo "    mkdir -p \$1" >> ~/.bashrc
echo "    cd \$1" >> ~/.bashrc
echo "}" >> ~/.bashrc


### setup normal folders
mkdir -p $HOME/Programs/bin $HOME/Temp $HOME/Test $HOME/Databases $HOME/Programs/perl5lib
echo "export PROGPATH=\$HOME/Programs"
echo "export PATH=\$HOME/Programs/bin"
echo "export PERL5LIB=\$HOME/Programs/perl5lib:\${PERL5LIB}"


