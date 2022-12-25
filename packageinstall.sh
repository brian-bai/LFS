
CHAPTER="$1"
PACKAGE="$2"

cat md5sums | grep -i "$PACKAGE" | grep -i -v "patch" |while read line; do
    bn="`echo $line | cut -d' ' -f2`"
    DIRNAME=$(echo "$bn" | sed 's/\(.*\)\.tar\..*/\1/')

    if [ -d "$DIRNAME" ]; then
        echo "$DIRNAME already exists on your filesystem."
        rm -rf "$DIRNAME"
    fi

    mkdir -pv "$DIRNAME"

    echo "Extracting $bn"
    tar -xf "$bn" -C "$DIRNAME"

    pushd "$DIRNAME"
        if [ "$(ls -1A | wc -l)" == "1" ]; then 
            mv $(ls -1A)/* ./
        fi

        echo "Compiling $PACKAGE"
        sleep 5

        mkdir -pv "../log/chapter$CHAPTER"
        if ! source "../chapter$CHAPTER/$PACKAGE.sh" 2>&1 | tee "../log/chapter$CHAPTER/$PACKAGE.log" ; then
            echo "Compiling $PACKAGE FAILED!"
            popd
            exit 1
        fi

        echo "Done Compiling $PACKAGE"

    popd

done

# deal with cases that package name is not in tar file
if [ "$PACKAGE" == "linux-api-headers" ] || [ "$PACKAGE" == "libstdc++" ];
then
    case $PACKAGE in
            linux-api-headers) bn="linux-5.19.2.tar.xz" ;;
            libstdc++) bn="gcc-12.2.0.tar.xz" ;;
    esac

    DIRNAME=$(echo "$bn" | sed 's/\(.*\)\.tar\..*/\1/')

     mkdir -pv "$DIRNAME"

     echo "Extracting $bn"
     tar -xf "$bn" -C "$DIRNAME"

     pushd "$DIRNAME"
         if [ "$(ls -1A | wc -l)" == "1" ]; then 
             mv $(ls -1A)/* ./
         fi

         echo "Compiling $PACKAGE"
         sleep 5

         mkdir -pv "../log/chapter$CHAPTER"
         if ! source "../chapter$CHAPTER/$PACKAGE.sh" 2>&1 | tee "../log/chapter$CHAPTER/$PACKAGE.log" ; then
             echo "Compiling $PACKAGE FAILED!"
             popd
             exit 1
         fi

         echo "Done Compiling $PACKAGE"

     popd 
fi 


