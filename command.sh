#!/bin/bash
#normalize file
#compare
# Author : Amr Mahrous

PROJECT_NAME=flask
GIT_PROJECT_PATH=$PWD/flask
COMMITS_FILE=$PROJECT_NAME.effective_commits.txt
currPath=$PWD

echo 'start application'
start=`date +%s`

#get commits that has .h , .cpp ,.java, .php , .py file changed
sh ./code_changed_commits.sh $GIT_PROJECT_PATH > $COMMITS_FILE
echo 'end commits'
end=`date +%s`
runtime1=$((end-start))
echo "get commits time $runtime1"

stage=1
#checkout to a commit , normalize it , store duplicated code found in each commit
sed 1d $COMMITS_FILE | while read COMMIT_ID
do

echo "start reading $COMMIT_ID "
echo "stage $stage"

start=`date +%s`

echo "checkout $COMMIT_ID "
cd $GIT_PROJECT_PATH
git stash
git checkout $COMMIT_ID

#echo "normalize $COMMIT_ID "
cd $currPath
#sh ./normalize.sh $GIT_PROJECT_PATH
#end=`date +%s`
#runtime2=$((end-start))
#echo "normalize time $runtime2"

start=`date +%s`
mkdir -p $GIT_PROJECT_PATH.duplications
sh ./duplicate_detector.sh $GIT_PROJECT_PATH > $GIT_PROJECT_PATH.duplications/$COMMIT_ID.txt
end=`date +%s`
runtime3=$((end-start))
echo "code detector time $runtime3"

echo "end reading $COMMIT_ID "

stage=$((stage+1))
done
cd $currPath