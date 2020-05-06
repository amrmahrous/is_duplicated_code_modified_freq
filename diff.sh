#this script will show differences between commits
#we need to have a copy of the project to compare the 2 folders
#we will checkout the 2 folders to different commitid 
#and compare the commit with the commit+1 to see what will change in the commit

original_path=$PWD
commits_FILE="$PWD/qmailadmin.effective_commits.txt"
commits_project_path="$PWD/qmailadmin"
commits_project_path_copy="$PWD/qmailadmin_copy"
output_path="$PWD/qmailadmin.diff/"

mkdir -p $output_path
#first line is the lastest commit of the project 
CURR_COMMIT=$(read -r CURR_COMMIT < $commits_FILE)
cd $commits_project_path
git checkout $CURR_COMMIT
#here we will loop through all commits to compare current commit with previous ones and see if the
#diff , to see what changes happens for the previous commit
sed 1d $commits_FILE | while read PREV_COMMIT
do
cd $commits_project_path
git checkout $CURR_COMMIT

cd $commits_project_path_copy
git checkout $PREV_COMMIT

diff --exclude=.git --unified --recursive $commits_project_path_copy $commits_project_path  >> $output_path/$PREV_COMMIT.txt
CURR_COMMIT=$PREV_COMMIT
done
cd $original_path