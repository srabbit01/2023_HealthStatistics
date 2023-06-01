
/*Example for DATA Step*/
DATA EXAMPLE; 
INPUT NO AGE GENDER $;
CARDS;
1 20 F
2 23 M
3 28 M
4 22 F
;
RUN;

/*Example for PROC Step*/
PROC MEANS DATA=EXAMPLE; 
VAR AGE; /*Any annotation*/
RUN;


/*Setting up the working directory*/
LIBNAME PUBLIC "/home/u47370435/2023_1 Introduction to Biostatistics" ;


/*Example of missing value type according to the variable type*/
DATA EXAMPLE; 
INPUT NO AGE GENDER $;
CARDS;
1 20 F
. 23 M
3 28 .
4 22 F
;
RUN;


/*Data and Variable name restriction*/
DATA BYTE12345678901234567890123567890; 
VAR=1;
RUN;

DATA EXAMPLE3; 
VARNAME12345678901234567890123567890=1;
RUN;



/*Importing external files*/
***Using PROC IMPORT procedure;
PROC IMPORT OUT= WORK.band
            DATAFILE= "/home/u47370435/2023_1 Introduction to Biostatistics/Bands.csv" 
            DBMS=CSV REPLACE;
			GETNAMES=NO;
			DATAROW=1; 
RUN;

PROC IMPORT OUT= WORK.band2
            DATAFILE= "/home/u47370435/2023_1 Introduction to Biostatistics/Bands2.csv" 
            DBMS=CSV REPLACE;
     		GETNAMES=YES;
    		 DATAROW=2; 
RUN;



	
/*Importing SAS files*/
*import 1 file only (copy);
DATA EXAMPLE4;
		SET SASHELP.CLASS;
RUN;


*more than 2 files;
DATA EXAMPLE5;
		SET SASHELP.CLASS SASHELP.CLASS;
RUN;


*more than 2 files with different variables;
DATA EXAMPLE6;
		SET SASHELP.CLASS EXAMPLE;
RUN;


***include, exclude variables using keep/drop statement;
*KEEP;
DATA EXAMPLE7;
		SET SASHELP.CLASS;
		KEEP NAME AGE;
RUN;
*DROP;
DATA EXAMPLE8;
		SET SASHELP.CLASS;
		DROP NAME AGE;
RUN;

**Various ways to use KEEP/DROP statement;
*KEEP;
DATA EXAMPLE7;
		SET SASHELP.CLASS(KEEP=NAME AGE);
RUN;
*DROP;
DATA EXAMPLE8;
		SET SASHELP.CLASS(DROP=NAME AGE);
RUN;

*KEEP;
DATA EXAMPLE7(KEEP=NAME AGE);
		SET SASHELP.CLASS;
RUN;
*DROP;
DATA EXAMPLE8(DROP=NAME AGE);
		SET SASHELP.CLASS;
RUN;



/*Creating New files directly*/
***Using INPUT & CARDS statement;
**List input method;
DATA EXAMPLE9;
INPUT NAME $       SALARY     DATE MMDDYY8.;
CARDS;
KELLY 8113 10012018
STEVE 9000 12012019
COX 7500 02282015
;
RUN;

**List input method (with @@);
DATA EXAMPLE10;
INPUT NAME $       SALARY     DATE MMDDYY8. @@;
CARDS;
KELLY 8113 10012018 STEVE 9000 12012019 COX 7500 02282015
;
RUN;

**Some types of error while using list input method;
*Error from the inner BLANK;
DATA EXAMPLE11;
INPUT NAME $       SALARY      DATE MMDDYY8.;
CARDS;
KELLY CHOI  8113  10012018
STEVE FOX  9000  12012019
COX R  7500  02282015
;
RUN;

*Error from the LENGTH of the character values;
DATA EXAMPLE12;
INPUT NAME $       SALARY     DATE MMDDYY8.;
CARDS;
KELLYABCDEFG 8113 10012018
STEVEABCDEFG 9000 12012019
COXABCDEFG 7500 02282015
;
RUN;
DATA EXAMPLE13;
LENGTH NAME $15;
INPUT NAME $       SALARY     DATE MMDDYY8.;
CARDS;
KELLYABCDEFG 8113 10012018
STEVEABCDEFG 9000 12012019
COXABCDEFG 7500 02282015
;
RUN;

*Error from the MISSING value;
DATA EXAMPLE14;
INPUT NAME $       SALARY     DATE MMDDYY8.;
CARDS;
KELLY 8113 10012018
          9000 12012019
COX            02282015
;
RUN;
DATA EXAMPLE15;
INPUT NAME $       SALARY     DATE MMDDYY8.;
CARDS;
KELLY 8113 10012018
.          9000 12012019
COX    .   02282015
;
RUN;


**Column input method;
DATA EXAMPLE16;
INPUT NAME $ 1-10      SALARY 11-14    SPACE $ 16-44;
CARDS;
KELLY CHOI8113 SEOUL NATIONAL UNIVERSITY  
STEVE FOX 9000 REPUBLIC OF KOREA
COX R     7500 LECTURE ROOM IN BUILDING 220
;
RUN;



/*Creating and Modifying Variables*/
DATA PUBLIC.PRACTICE;
		SET SASHELP.CLASS;
		NEW_VAR1=201; *Creating New Numeric variable;
		NEW_VAR2='Public Health'; *Creating New Chracter variable;
		
		COPY_VAR1=AGE; *Copy all the values of variable AGE;
		
		CALC_VAR1=WEIGHT + 10; *Add;
		CALC_VAR2=WEIGHT - 10; *Subtract;
		CALC_VAR3=WEIGHT * 10; *Multiply;
		CALC_VAR4=WEIGHT / 10; *Divide;
		CALC_VAR5=WEIGHT ** 2; *Square;
		
		CALC_VARS1=SUM(HEIGHT, WEIGHT); *Sum of Variables;
		CALC_VARS2=MEAN(HEIGHT, WEIGHT); *Mean of Variables;
		
		CHAR_VAR1=SUBSTR(NAME,1,3); *Substring Character;
		CHAR_VAR2=CATS(NAME, SEX); *Paste Characters;
		
		AGE=AGE-5; *Modifying existing variable;
RUN;



/*Exporting data files*/
**Using PROC EXPORT procedure;
*Export to CSV file;
PROC EXPORT DATA= EXAMPLE16
            OUTFILE= "/home/u47370435/2023_1 Introduction to Biostatistics/Anynames1.csv" 
            DBMS=CSV REPLACE;
			PUTNAMES=YES;
RUN;

*Export to TXT file;
PROC EXPORT DATA= EXAMPLE16
            OUTFILE= "/home/u47370435/2023_1 Introduction to Biostatistics/Anynames2.TXT" 
            DBMS=TAB REPLACE;
			PUTNAMES=NO;
RUN;


**Using export wizard;
