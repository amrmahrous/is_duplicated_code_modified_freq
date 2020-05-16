#!/bin/bash
#this tool get the total lines of number in a all branch of git project
# a .txt file with {projectname}.effective_commits.txt shall exist with lines of commits id
# use a tool code_changed_commits.sh to generate the effective commits .txt file first

# Author : Amr Mahrous
#usage : ./number_of_lines.sh project_folder_name

commits_FILE=$PWD/$1.effective_commits.txt
commits_project_path="$PWD/$1"
curr_path=$PWD
cd $commits_project_path
prev_num=0
sed 1d $commits_FILE | while read PREV_COMMIT
do
git checkout $PREV_COMMIT
COMMIT_num=$(( find $commits_project_path \( -type f \) -print0 | xargs -0 cat ) | wc -l);
COMMIT_num=$(($COMMIT_num+$prev_num))
echo "curre commits $(($COMMIT_num))"
prev_num=$COMMIT_num
done
cd $curr_path