 #!/bin/bash
 

echo "BUILD DATABASE"

LNX_SNAP=$1
LNX_SNAP_LOCAL_PATH=$DBC/ritesh/work/$1
LNX_DATABASE_FOLDER=$DBC/browse/db_$LNX_SNAP

mkdir -p $LNX_DATABASE_FOLDER 

LNX_PATH_LIST=""

while read line; do 
    echo $line
    LNX_PATH_LIST=$LNX_PATH_LIST" "
    LNX_PATH_LIST=$LNX_PATH_LIST$LNX_SNAP_LOCAL_PATH/$line
done <~/.dotfiles/dirList.txt

# No vcxproj files, CVS directories or CVS temp files needed.
find $LNX_PATH_LIST \
-name "*.cpp" -o -name "*.h" -o -name "*.c" -o -name "*.C" \
-o -name "*.py" -o -name "*.java" -o -name "*.vmodl" \
-o -name "*.make" -o -name "*.mk" -o -name "*.bazel" -o -name "*.bzl" > $LNX_DATABASE_FOLDER/cscope.files

echo $LNX_PATH_LIST

cd $LNX_DATABASE_FOLDER
cscope -b -q -k

clear; 
ctags -R --verbose --c-kinds=+p --c++-kinds=+p --fields=+iamS --extra=+q --exclude=*.vcxproj,*/CVS/*,.#* $LNX_PATH_LIST
