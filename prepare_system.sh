#!/bin/bash
echo " use this script to pass version check scripts"
echo " in linux from scratch version 11.2 chapter 2.2 Host System Requirement"
echo " Test on ubuntu22.04, adapt this script as your step0 version check result required"

if [ "$EUID" -ne 0 ]
  then echo "------ Need to run as root with sudo"
  exit
fi
rm /bin/sh
ln -s /bin/bash /bin/sh
apt install gawk
apt install bison
apt install make
apt install texinfo
apt-get install build-essential
