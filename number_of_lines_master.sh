#!/bin/bash
#this tool get the lines of number in a master branch of git project
# a .txt file with {projectname}.effective_commits.txt shall exist with lines of commits id
# use a tool code_changed_commits.sh to generate the effective commits .txt file first

# Author : Amr Mahrous
#usage : ./number_of_lines_master.sh project_folder_name

commits_FILE=$PWD/$1.effective_commits.txt
commits_project_path="$PWD/$1"
curr_path=$PWD
cd $commits_project_path
git checkout master
COMMIT_num=$(( find $commits_project_path \( -type f \) -print0 | xargs -0 cat ) | wc -l);
echo "curre commits $(($COMMIT_num))"
cd $curr_path