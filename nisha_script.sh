#! /bin/bash

Pwd=`/bin/pwd`          # pwd is Enabled to source the working directory of config file at the beginning

source $Pwd/nishascript.conf     # used to source the config file to the script and $Pwd will redirect the exact path
$TOUCH $Pwd/Scriptlogs.log  # log file has been created to the directory
#-----------------------------------------------------------------------------------------------------------------------------------------
func(){ if [[ $? -ne 0 ]]; then $ECHO "Failure at $1">> $Pwd/Scriptlogs.log 
        exit
    else 
	    $ECHO $date $Pwd $0 $2 $3 $4 
	    fi }                                   #function 'func()' will match the condition if commands execute or not and give the logs failure an exit if condition of execution fails.
                                                   #if function passes then it will generate output to logs folder from wherever it is called
						       
#----------------------------------------------------------------------------------------------------------------------------------------- 
$ECHO $date $Pwd  " INITIALISING $0">> $Pwd/Scriptlogs.log                                          #storing logs in specified >> filename 

$ECHO "Enter new Directory Name for Storing Data Files:" 
func $LINENO "[INITIAL]:Asking user to input directory name to store output datafile">> $Pwd/Scriptlogs.log
                                                          #LINENO will output the failure line no. to log folder with specified >> filename 
                                                          #Function func is called to store the respective values in $ assigned in func()

read DIR                                                 #input from user is stored to variable DIR with the help of read command.
func $LINENO "[SUCCESS]: Entered directory name is-" "$DIR" "">> $Pwd/Scriptlogs.log                   #storing logs in specified >> filename 

func $LINENO "[CHECK]:checking if directory name-" "$DIR" " already Exists or not">> $Pwd/Scriptlogs.log                                                                                                                                             #storing logs in specified >> filename
#-----------------------------------------------------------------------------------------------------------------------------------------

if test -d "$DIR"; then                            #Function will test if input directory name exists or not, if true then proceed.	
$ECHO "Already Exists! Try New"               
$ECHO $date $Pwd $0 "[FAIL]: Directory " "$DIR" " already Exists ">> Scriptlogs.log    
$0                                               #If Conditios is true, then it runs the script again to ask new directory name

func $LINENO "[REINITIATING SCRIPT "$0"] ">> Scriptlogs.log

else                                               #IF Condition is False, then it Enters under else for further processing.
#------------------------------------------------------------------------------------------------------------------------------------------

$MKDIR $DIR                                        #Creating a new Directory to store the downloaded and generated output files.
func $LINENO "[SUCCESS]: New Directory" "$DIR" " has been created at "$Pwd"">> $Pwd/Scriptlogs.log    #storing logs in specified >> filename 

cd $DIR                                            #to Enter inside the new created Directory.
func $LINENO "[SUCCESS]:Output Directory changed to "$Pwd"/"$DIR"" >> $Pwd/Scriptlogs.log              #storing logs in specified >> filename 

#------------------------------------------------------------------------------------------------------------------------------------------

$ECHO "Downloading Spreadsheets from url and Extracting data...."

#URL1='https://docs.google.com/spreadsheets/d/e/2PACX-1vTrNldUZStbLCL-Q9Le9ilWrWxR1XW5N4zOzpBbM4aBEsgp2wheS7ioOx0yQ8a_zZuxvw4fXkwYH-Mh/pub?output=csv'
#URL2='https://docs.google.com/spreadsheets/d/e/2PACX-1vRc3-RATBQ0U-XYPwb8uRHs0sMwJspqnspJxWFPXVz_pF0NA2QTFA-rkmPsRjMOlF_xPdpwBRjYOkhK/pub?output=csv'                                          
#These links are already forked from config file and commented for future reference

$DOWNLOAD -q -O Evaluation_Sheet1.csv $URL1                                 #To download the file Quietly using the published link of First spreadsheet.
func $LINENO "[SUCCESS] Spreadsheet1 downloaded from below url -" "$URL1" " ">> $Pwd/Scriptlogs.log    #storing logs in specified >> filename

       
func $LINENO "[SUCCESS] Downloaded file renamed to Evaluation_sheet1.csv ">> $Pwd/Scriptlogs.log    #storing logs in specified >> filename

$DOWNLOAD -q -O Evaluation_Sheet2.csv $URL2                                 #To download the file Quietly using the published link of First spreadsheet.
func $LINENO "[SUCCESS] Spreadsheet2 downloaded from below url --" "$URL2" " ">> $Pwd/Scriptlogs.log    #storing logs in specified >> filename

                                                      #To rename the generated output file to Evaluation_sheet2
func $LINENO "[SUCCESS] Downloaded file renamed to Evaluation_sheet2.csv ">> $Pwd/Scriptlogs.log    #storing logs in specified >> filename

#------------------------------------------------------------------------------------------------------------------------------------------

name1=$($SHOW Evaluation_Sheet1.csv|$MATCH -i name|$SCAN -F"$SEEK1" '{print $1}'|$TRAN -cd , |$COUNT -c) add1=1 count1=$((name1+add1))
func $LINENO "[SUCCESS] Counted column no. of [_Intern Name_ in sheet1="$count1"]">> $Pwd/Scriptlogs.log
name2=$($SHOW Evaluation_Sheet2.csv|$MATCH -i name|$SCAN -F"$SEEK1" '{print $1}'|$TRAN -cd , |$COUNT -c) count2=$((name2+add1))
func $LINENO "[SUCCESS] Counted column no. of [_Intern Name_ in sheet2="$count2"]">> $Pwd/Scriptlogs.log    #storing logs in specified >> filename


avg1=$($SHOW Evaluation_Sheet1.csv|$MATCH -i Average|$SCAN -F"$SEEK2" '{print $1}'|$TRAN -cd , |$COUNT -c) count3=$((avg1+add1))
func $LINENO "[SUCCESS] Counted column no. of [_Average_ in sheet1="$count3"]">> $Pwd/Scriptlogs.log
avg2=$($SHOW Evaluation_Sheet2.csv|$MATCH -i Average|$SCAN -F"SEEK2" '{print $1}'|$TRAN -cd , |$COUNT -c) count4=$((avg2+add1))
func $LINENO "[SUCCESS] Counted column no. of [_Average_ in sheet2="$count4"]">> $Pwd/Scriptlogs.log        #storing logs in specified >> filename
  
#sum1=$((avg1-count1))                               #for counting no. of columns between Interns and Average from sheet1
#func $LINENO "[SUCCESS][_columns between Intern name and Average from sheet1="$sum1"]">> $Pwd/Scriptlogs.log 
#sum2=$((avg2-count2))                               #for counting no. of columns between Interns and Average from sheet2
#func $LINENO "[SUCCESS][_columns between Intern name and Average from sheet2="$sum2"]">> $Pwd/Scriptlogs.log



 # The Above Function will match the name and average in the respective addressed sheet and count the number of commas before that Particular found column and add +1 to get the exact column number in the sheet.Here name1,name2 and avg1,avg2 will count the commas with addition of +1 using variable add1. Further count1,count2 will store column no. of Intern name and count3,count4 will store column no. of Average.   

#------------------------------------------------------------------------------------------------------------------------------------------
calsum()
{
	sum=`cat $1 | awk -F"," '{ col_index=0;
    for (i=1; i<=NR; i++) {
   for (j=1; j<=NF; j++) {
      switch (tolower($j)) {
         case "good":
         case "satisfactory":
         case "verygood":
         case "poor":
         case "excellent":
         case "fair":
    columns_to_consider[col_index]=j
    col_index++
 default:
        }
  }
    }
    for (k in columns_to_consider) {
   print "The columns to consider are ", columns_to_consider[k] | "sort -u";
    }
}'|wc -l`

}



$MATCH ^[0-9] Evaluation_Sheet1.csv > Eval1.csv
calsum Eval1.csv
$SCAN -v "col1=$count1" -v "col2=$count3" -v "sum=$sum" -F"," 'BEGIN{printf "_____________________Evaluation Spreadsheet I (on Daily Basis)______________________\n"}{print" " "NAME   : "$col1, "\n" , "SUM    : " $col2*sum, "\n", "AVERAGE: " $col2, "\n","__________________"}' Eval1.csv > Output_of_sheet.csv

func $LINENO  "[SUCCESS]: Extracted Name, Sum, Column from sheet1 and stored to "$Pwd"/"$DIR" as (Output_of_Sheet)">> $Pwd/Scriptlogs.log    #storing logs in specified >> filename 

$MATCH ^[0-9] Evaluation_Sheet2.csv > Eval2.csv
calsum Eval2.csv
$SCAN -v "col3=$count2" -v "col4=$count4" -v "sum=$sum" -F"," 'BEGIN{printf "_____________________Evaluation Spreadsheet II (on the basis of MD file)______________________\n"}{print" " "NAME   : "$col3, "\n" , "SUM    : " $col4*sum, "\n", "AVERAGE: " $col4, "\n","__________________"}' Eval2.csv >> Output_of_sheet.csv
func $LINENO  "[SUCCESS]: Extracted Name, Sum, Column from sheet2 and stored to "$Pwd"/"$DIR" as (Output_of_Sheet)">> $Pwd/Scriptlogs.log    #storing logs in specified >> filename

$REM Evaluation_Sheet1.csv Evaluation_Sheet2.csv
 # AWK Command is used to Display the output with desired 2nd(Intern name) & 11th(Average) column & calculating the sum.here, -F is used here as field seperator(,) for each record and NR is used to Extract the data which is required i.e,it's printing the no. of records between 4th to 24th or 26th to Extract and display the records lying within it.Further redirecting the output using > operator and append >> operator to the desired file name. 
#--------------------------------------------------------------------------------------------------------------------------------------------  
$SHOW Output_of_sheet.csv                                                     # Used to Display the output of sheets to the terminal
func $LINENO "[SUCCESS] Output generated to terminal ">> $Pwd/Scriptlogs.log     #storing logs in specified >> filename
func $LINENO "[EXITING "$0" ]">> $Pwd/Scriptlogs.log                             #storing logs in specified >> filename                        

fi                                                                          #End of if condition.
