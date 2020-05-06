The purpose of these tools is to replication the study 
"Is Duplicate Code More Frequently Modified than Non-duplicate Code in Software Evolution?: An Empirical Study on Open Source Software"

the study assest if a duplicated code changes more than non duplicated code , it uses the software revisions to get an anser.

1.the first step , we get the commits that has only changed .h/.cpp/.java/.php/.py and write these commits id to a file
2. second step , we checkout these commits and extract the duplicated code for each of them
 in this step:
  first we store the duplicated code for each commit in a file with the commit Normalize
  second we loop through these files and store the information into .csv file , ready to be imported into the database using this command line

LOAD DATA LOCAL INFILE  
'/home/amr/code/eclipse_duplication.csv'
INTO TABLE pmd_cpd  
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(project,commit , file, start_line, end_line);

3.no we have the duplicated code for all software revisions in the database 
, then we need to get the code that will be modified in each commit
we use the created bash script , diff which loop through all commits 
and find the different between each commit (commit1) and the commit that will come next commit2
storing what code will be changed in a file with the commit id , 
then we use the created python script modification_detection.py to store each modification into this format
into appname , commitid , filename , line deleted , ...

4. now we have each modification that will happen to a commit , we need to know if this modification will happen to a duplicated code to to a none duplicated code
we need to write a php/python script , to loop through all modifications in the csv file
and check if this modification happens in duplicated code that exist in database
the modification has start line deleted and numer of lines deleted , start line added , ( and number of line added 'not important')
we check :
    if the modified lines are all duplicated code , then we ++ duplicate iterator
    if the modified lines are all none duplicated code , then we ++ none duplicate iterator
    if modified lines are in dulpicated and none duplicated , then we ++ both




About PMD , the used tool for code deuplcaion detecror 

PMD is a source code analyzer. It finds common programming flaws like unused variables, empty catch blocks, unnecessary object creation, and so forth. It supports Java, JavaScript, Salesforce.com Apex and Visualforce, PLSQL, Apache Velocity, XML, XSL.

Additionally it includes CPD, the copy-paste-detector. 

CPD finds duplicated code in Java, C, C++, C#, Groovy, PHP, Ruby, Fortran, JavaScript, PLSQL, Apache Velocity, Scala, Objective C, Matlab, Python, Go, Swift and Salesforce.com Apex and Visualforce.
https://github.com/pmd/pmd/releases/tag/pmd_releases/6.23.0



used projects 

https://github.com/qmail/qmailadmin.git 

https://github.com/OpenYMSG/openymsg 

https://github.com/jacoco/eclemma

https://github.com/eclipse/eclipse 

https://github.com/basvodde/filezilla

https://github.com/pallets/flask

https://github.com/PHPMailer/PHPMailer



