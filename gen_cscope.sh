 #!/bin/bash
 

 LNX_SNAP=$1
 LNX_SNAP_LOCAL_PATH=/source/$1

 mkdir -p /BROWSE/$LNX_SNAP/

 LNX_PATH_LIST=
 while read p; do
	 LNX_PATH_LIST+=" "
	 LNX_PATH_LIST+=$LNX_SNAP_LOCAL_PATH/$p
 done </home/gbuilder/.dotfiles/dirList.txt

# No vcxproj files, CVS directories or CVS temp files needed.
find $LNX_PATH_LIST \
 ! -path "*.vcxproj" ! -path "*/CVS/*" ! -path ".#*" > /BROWSE/$LNX_SNAP/cscope.files


cd /BROWSE/$LNX_SNAP
cscope -b -q -k

clear; 
ctags -R --verbose --c-kinds=+p --c++-kinds=+p --fields=+iamS --extra=+q $LNX_PATH_LIST


