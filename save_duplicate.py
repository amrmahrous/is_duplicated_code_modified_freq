# this file , open the duplication detected from the tool 
#and save it in csv format to import later to a database
#author : Amr Mahrous

import re
import os
import csv

appname = "PHPMailer"
duplication_folder = "PHPMailer.duplications/"
save_to = "PHPMailer_duplication.csv"
pattern1 = "Found\sa\s(.*?)\sline"
pattern2 = "Starting\sat\sline\s(.*?)\sof\s(.*?)\n"

arr = os.listdir(duplication_folder)
with open(save_to,"w") as f:
    cr = csv.writer(f,delimiter=";",lineterminator="\n")
    for file in arr:
        # Opening file 
        file1 = open(duplication_folder+file, 'r') 
        # Using for loop 
        for line in file1: 
            if( 'duplication in the following files' in line ):
                start_duplication = 1
                number_of_lines = int( re.search(pattern1, line).group(1) )
                commitid = os.path.splitext(file)[0]
            if('Starting at line' in line):
                filename = re.search(pattern2, line).group(2)
                start_line = int( re.search(pattern2, line).group(1) )
                end_line = start_line + number_of_lines
                cr.writerow([appname,commitid,filename,start_line,end_line])
            if not line.strip() and start_duplication:
                start_duplication = 0
                continue

        # Closing files 
        file1.close() 