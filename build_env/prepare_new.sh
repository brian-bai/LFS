echo "Dist Root: ${DIST_ROOT:?}"
echo "LFS: ${LFS:?}"

#mkdir -p $LFS/sources

mirror=https://mirrors.ustc.edu.cn/lfs/lfs-packages/11.2
echo "Use mirror: ${mirror:?}"

for f in $(cat $DIST_ROOT/build_env/wget-list-sysv)
do
    bn=$(basename $f)
    
    if ! test -f $LFS/sources/$bn ; then
        wget $mirror/$bn -O $LFS/sources/$bn
    fi

done;