#!/bin/bash
export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sdb

cp -rf *.sh chapter* "$LFS/sources"
cd "$LFS/sources"
export PATH="$LFS/tools/bin:$PATH"
export MAKEFLAGS='-j4'

# chapter5
for package in binutils gcc linux-api-headers glibc libstdc++; do
    echo "Chapter5 $package already done!"
    #source packageinstall.sh 5 $package
done 

# chapter6
for package in m4 ncurses bash coreutils diffutils file findutils gawk grep gzip make patch sed tar xz binutils gcc; do
    echo -n ""
    #source packageinstall.sh 6 $package
done 

source packageinstall.sh 6 gcc


