#you may need "pip install mysql.connector"
#author:Amr Mahrous

#import mysql.connector
import re
import os
import csv


appname = "qmailadmin"
diff_folder = "qmailadmin.diff/"
save_to = "qmailadmin_modifications.csv"

pattern1 = "recursive\s/home/amr/code/(.*?)\s/home/amr/code/(.*?)\n"
pattern2 = "@@\s-(.*?),(.*?)\s\+(.*?),(.*?)\s@@"

#open diff folder to iterate commits modifications
files = os.listdir(diff_folder)
commits_count = len(files)
with open(save_to,"w") as f:
    cr = csv.writer(f,delimiter=";",lineterminator="\n")
    for file in files:
            # Opening file 
            file1 = open(diff_folder+file, 'r') 
            # Using for loop 
            for line in file1: 
                if( "diff '--exclude=.git' --unified --recursive " in line ):
                    if(re.search(pattern1, line)):
                        file_name = re.search(pattern1, line).group(2) 
                if('@@ ' in line):
                    if (re.search(pattern2, line)):
                        start_line_deleted = re.search(pattern2, line).group(1)
                        num_lines_deleted = re.search(pattern2, line).group(2)
                        start_line_added = re.search(pattern2, line).group(3)
                        num_lines_added = re.search(pattern2, line).group(4)
                        commitid = os.path.splitext(file)[0]
                        cr.writerow([appname,commitid,start_line_deleted,num_lines_deleted,start_line_added,num_lines_added]) 
            # Closing files 
            file1.close() 

