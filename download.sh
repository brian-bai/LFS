mirror=https://mirrors.ustc.edu.cn/lfs/lfs-packages/11.2
echo "Use mirror: ${mirror:?}"
echo "LFS: ${LFS:?}"

extraArray=("md5sums" "check.sh" "extra.sh") 
for str in ${extraArray[@]}; do
    if ! test -f $LFS/sources/$str ; then
        echo "Downloading $str"
        wget $mirror/$str -O $LFS/sources/$str
     fi
done

pushd $LFS/sources

    cat md5sums | while read line; do
        MD5SUM="`echo $line | cut -d' ' -f1`"
        bn="`echo $line | cut -d' ' -f2`"

        if ! test -f $LFS/sources/$bn ; then
            echo "Downloading $bn"
            wget $mirror/$bn -O $LFS/sources/$bn

            if ! echo "$MD5SUM $bn" | md5sum -c >/dev/null; then
                rm -f "$bn"
                echo "Verificaiton of $bn failed! md5sum mismatch!."
                popd
                exit 1
            fi
        fi
    done
popd
