echo "Dist Root: ${DIST_ROOT:?}"
echo "LFS: ${LFS:?}"

mkdir -p $LFS/sources

mirror=https://mirrors.ustc.edu.cn/lfs/lfs-packages/11.2
echo "Use mirror: ${mirror:?}"

for f in $(cat $DIST_ROOT/build_env/wget-list-sysv)
do
    bn=$(basename $f)
    
    if ! test -f $LFS/sources/$bn ; then
        wget $mirror/$bn -O $LFS/sources/$bn
    fi

done;

mkdir -pv $LFS/{bin,etc,lib,sbin,usr,var,lib64,tools}

if ! test $(id -u distbuild) ; then

groupadd distbuild
useradd -s /bin/bash -g distbuild -m -k /dev/null distbuild
passwd distbuild
chown -v distbuild $LFS/{usr,lib,var,etc,bin,sbin,tools,lib64,sources}

echo "distbuild ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudoers_distbuild

dbhome=$(eval echo "~distbuild")

cat > $dbhome/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > $dbhome/.bashrc << EOF
set +h
umask 022
LFS=$LFS
export DIST_ROOT=$DIST_ROOT
EOF

cat >> $dbhome/.bashrc << "EOF"
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
export MAKEFLAGS="-j$(nproc)"
EOF

fi

