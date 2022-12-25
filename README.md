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
./lfs.sh
```

