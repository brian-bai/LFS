mirror=https://mirrors.ustc.edu.cn/lfs/lfs-packages/11.2
echo "Use mirror: ${mirror:?}"
echo "LFS: ${LFS:?}"

for f in $(cat wget-list-sysv)
do
    bn=$(basename $f)
    
    if ! test -f $LFS/sources/$bn ; then
        echo "Downloading $bn"
        wget $mirror/$bn -O $LFS/sources/$bn
    fi

done

extraArray=("md5sums" "check.sh" "extra.sh") 
for str in ${extraArray[@]}; do
    if ! test -f $LFS/sources/$str ; then
        echo "Downloading $str"
        wget $mirror/$str -O $LFS/sources/$str
     fi
done

pushd $LFS/sources
  md5sum -c md5sums
popd