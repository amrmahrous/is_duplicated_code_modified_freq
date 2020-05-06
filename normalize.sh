#!/bin/bash
#this tool normalize cpp files in a folder
# it has 3 steps , remove comments , delete empty lines 
#and move open or close { in single line to prvious line

# Author : Amr Mahrous
#require gcc compiler installed to remove comments
#usage : ./normalize.sh /folername

folder=$1
currPath=$PWD

for f in $(find $folder -name '*.cpp' -or -name '*.h' );
do 
#delete comments
$currPath/comment_remover.sed < $f > tmp/zyzcc.c; /bin/cp -f tmp/zyzcc.c $f;

#Delete empty lines
sed -i '/^$/d' $f
#move up the single open or close { , if its the only character in the line
sed -i 'N;/\n{/s// {/;P;D' $f
sed -i 'N;/\n}/s// }/;P;D' $f
done
cd $currPath