# follow the LFS 11.2 chapter 4.3 Add the LFS user
echo "LFS: ${LFS:?}"

if ! test $(id -u lfs) ; then
sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs
sudo passwd lfs
sudo chown -v lfs $LFS/{usr,lib,var,etc,bin,sbin,tools,sources,boot}
case $(uname -m) in
  x86_64) sudo chown -v lfs $LFS/lib64 ;;
esac

lfshome=$(eval echo "~lfs")

temp=$(mktemp)

cat > $temp << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

sudo cp $temp $lfshome/.bash_profile 
sudo chown -v lfs $lfshome/.bash_profile

temp2=$(mktemp)
cat > $temp2 << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF

sudo cp $temp2 $lfshome/.bashrc
sudo chown -v lfs $lfshome/.bashrc

fi

