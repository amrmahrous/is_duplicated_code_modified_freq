#author Amr Mahrous
#you will need to change --language params in TOOL_COMMAND to be java or cpp when needed
#https://pmd.github.io/latest/pmd_userdocs_cpd.html
# pmd-bin-6.23.0/bin/run.sh cpd --files /home/amr/code/filezilla --ignore-identifiers -language cpp

PROJECT_PATH=$1
TOOL_PATH="pmd-bin-6.23.0/bin"
TOOL_COMMAND="$TOOL_PATH/run.sh cpd --files $1 --exclude .git \
--ignore-identifiers --ignore-annotations --language py --minimum-tokens 100"
$TOOL_COMMAND
