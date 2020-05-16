#!/bin/bash
source FuhaoLab.conf


PythonModules2install="macs2"

if CheckPythonModules $PythonModules2install; then
	echo "Info: PythonModules2install installed, now checking upgrades"
	pip3 install --user -U MACS2
else
	pip3 install --user MACS2
fi

exit 0
