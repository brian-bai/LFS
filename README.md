# LFS
Linux from scratch on Ubuntu 22.04
The step by step procedure on a virtual box guest.

## Step 0 Virtual box setup
- Create a Ubuntu 22.04 VM
- add a second disk /dev/sdb

## Step 1: set up lfs user
**After setup lfs user, login with lfs**
```
./Step1_setup_lfs_user.sh
su - lfs

# set git
ssh-keygen -t ed25519 -C "your@email.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

## Step 2: set up host toolchain
- version check
```
./version_check.sh
sudo bash prepare_system.sh
```

## Step 3: setup disk and download
```
./lfs_setup.sh
```

## Step 4: setup user profile
```
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
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
```

## Step 5: Compiling a Cross-Toolchain
```
./lfs_install.sh
```

## Step 6: Cross Compiling Temporary Tools


