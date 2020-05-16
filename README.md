The purpose of these tools is to replication the study 
&nbsp;
"Is Duplicate Code More Frequently Modified than Non-duplicate Code in Software Evolution?: An Empirical Study on Open Source Software"
&nbsp;

&nbsp;
the study assest if a duplicated code changes more than non duplicated code , it uses the software revisions to get an anser.
&nbsp;

&nbsp;
1.the first step , we get the commits that has only changed .h/.cpp/.java/.php/.py and write these commits id to a file
&nbsp;
2. second step , we checkout these commits and extract the duplicated code for each of them
&nbsp;
 in this step:
&nbsp;
  first we store the duplicated code for each commit in a file with the commit Normalize
&nbsp;
  second we loop through these files and store the information into .csv file , ready to be imported into the database using this command line
&nbsp;

&nbsp;
LOAD DATA LOCAL INFILE  
&nbsp;
'/home/amr/code/eclipse_duplication.csv'
&nbsp;
INTO TABLE pmd_cpd  
&nbsp;
FIELDS TERMINATED BY ';' 
&nbsp;
ENCLOSED BY '"'
&nbsp;
LINES TERMINATED BY '\n'
&nbsp;
(project,commit , file, start_line, end_line);
&nbsp;

&nbsp;
3.no we have the duplicated code for all software revisions in the database 
&nbsp;
, then we need to get the code that will be modified in each commit
&nbsp;
we use the created bash script , diff which loop through all commits 
&nbsp;
and find the different between each commit (commit1) and the commit that will come next commit2
&nbsp;
storing what code will be changed in a file with the commit id , 
&nbsp;
then we use the created python script modification_detection.py to store each modification into this format
&nbsp;
into appname , commitid , filename , line deleted , ...
&nbsp;

&nbsp;
4. now we have each modification that will happen to a commit , we need to know if this modification will happen to a duplicated code to to a none duplicated code
&nbsp;
we need to write a php/python script , to loop through all modifications in the csv file
&nbsp;
and check if this modification happens in duplicated code that exist in database
&nbsp;
the modification has start line deleted and numer of lines deleted , start line added , ( and number of line added 'not important')
&nbsp;
we check :
&nbsp;
    if the modified lines are all duplicated code , then we ++ duplicate iterator
&nbsp;
    if the modified lines are all none duplicated code , then we ++ none duplicate iterator
&nbsp;
    if modified lines are in dulpicated and none duplicated , then we ++ both
&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;
About PMD , the used tool for code deuplcaion detecror 
&nbsp;

&nbsp;
PMD is a source code analyzer. It finds common programming flaws like unused variables, empty catch blocks, unnecessary object creation, and so forth. It supports Java, JavaScript, Salesforce.com Apex and Visualforce, PLSQL, Apache Velocity, XML, XSL.
&nbsp;

&nbsp;
Additionally it includes CPD, the copy-paste-detector. 
&nbsp;

&nbsp;
CPD finds duplicated code in Java, C, C++, C#, Groovy, PHP, Ruby, Fortran, JavaScript, PLSQL, Apache Velocity, Scala, Objective C, Matlab, Python, Go, Swift and Salesforce.com Apex and Visualforce.
&nbsp;
https://github.com/pmd/pmd/releases/tag/pmd_releases/6.23.0
&nbsp;

&nbsp;

&nbsp;

&nbsp;
used projects 
&nbsp;

&nbsp;
https://github.com/qmail/qmailadmin.git 
&nbsp;

&nbsp;
https://github.com/OpenYMSG/openymsg 
&nbsp;

&nbsp;
https://github.com/jacoco/eclemma
&nbsp;

&nbsp;
https://github.com/eclipse/eclipse 
&nbsp;

&nbsp;
https://github.com/basvodde/filezilla
&nbsp;

&nbsp;
https://github.com/pallets/flask
&nbsp;

&nbsp;
https://github.com/PHPMailer/PHPMailer
&nbsp;

&nbsp;

&nbsp;

