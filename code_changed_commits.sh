#!/bin/bash
#this tool output commits id that has .h or .cpp file modified compared to its previous commit
# Author : Amr Mahrous

#usage : code_changed_commits.sh ./folerpath > file_store_output.txt

folder=$1
currPath=$PWD
allcommits=$currPath/tmp/allcommits.txt

#change current directoty to the git project directory
cd $folder

#write all commits id to tmp file 
git rev-list HEAD > $allcommits

#first line is the lastest commit of the project , we use this commit and
#compare it with the previous commit , to see what files has changed in it
FIRST_LINE=$(read -r FIRSTLINE < $allcommits)

#here we will loop through all commits to compare current commit with previous ones and see if the
#file changed is a code file then consider current commit as output
sed 1d $allcommits | while read NEXT_LINE
do
CODE_FILES_FOUND=false
    for COMMIT_FILE in $(git diff --name-only --diff-filter=AM $FIRST_LINE $NEXT_LINE);
    do
	case $COMMIT_FILE in
		*.cpp)
			CODE_FILES_FOUND=true;;
		*.h)
			CODE_FILES_FOUND=true;;
        *.java)
			CODE_FILES_FOUND=true;;
        *.py)
			CODE_FILES_FOUND=true;;
        *.php)
			CODE_FILES_FOUND=true;;
	esac
    done
    if [ $CODE_FILES_FOUND==true ]
    then
	echo $FIRST_LINE
    fi
    FIRST_LINE=$NEXT_LINE
done
cd $currPath
