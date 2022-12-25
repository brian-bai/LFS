#!/bin/bash
export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sdb

cp -rf *.sh chapter* "$LFS/sources"
cd "$LFS/sources"
export PATH="$LFS/tools/bin:$PATH"
export MAKEFLAGS='-j4'

#source packageinstall.sh 5 binutils

#for package in binutils gcc linux-api-headers glibc libstdc++; do
for package in glibc libstdc++; do
    source packageinstall.sh 5 $package
done 