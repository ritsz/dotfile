 #!/bin/bash
 

 echo "BUILD DATABASE\n"

 LNX_SNAP=$1
 LNX_SNAP_LOCAL_PATH=/Users/gbuilder/Code/$1

 mkdir -p /Users/gbuilder/browse/$LNX_SNAP/

 LNX_PATH_LIST=""

 while read line; do 
    echo $line
	 LNX_PATH_LIST=$LNX_PATH_LIST" "
	 LNX_PATH_LIST=$LNX_PATH_LIST$LNX_SNAP_LOCAL_PATH/$line
 done </Users/gbuilder/.dotfiles/dirList.txt

# No vcxproj files, CVS directories or CVS temp files needed.
find $LNX_PATH_LIST \
    -name "*.cpp" -o -name "*.h" -o -name "*.c" -o -name "*.C" -o -name "*.py" -o -name "*.java" > /Users/gbuilder/browse/$LNX_SNAP/cscope.files

echo $LNX_PATH_LIST

cd /Users/gbuilder/browse/$LNX_SNAP
cscope -b -q -k

clear; 
ctags -R --verbose --c-kinds=+p --c++-kinds=+p --fields=+iamS --extra=+q --exclude=*.vcxproj,*/CVS/*,.#* $LNX_PATH_LIST


