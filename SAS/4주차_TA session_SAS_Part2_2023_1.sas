
/*Setting up the LIBRARY (working directory)*/
LIBNAME BIOSTAT '/home/u47370435/2023_1 Introduction to Biostatistics';



/*SET statement*/
***SET***;
*Getting two datasets with all the observations in the both datasets;
DATA SET1;
		SET BIOSTAT.DEATH2004 BIOSTAT.DEATH2005;
RUN;

*Getting two datasets using RENAME statement;
DATA SET1_2;
		SET BIOSTAT.DEATH2004 BIOSTAT.DEATH2005 (RENAME=(SIDO=JUSO));
RUN;

*Getting two datasets with specified observations;
DATA SET2;
		SET BIOSTAT.DEATH2004(FIRSTOBS=9 OBS=10) BIOSTAT.DEATH2005(FIRSTOBS=15 OBS=20);
RUN;



/*Creating and Modifying variables*/
***Using IF-ELSE statement***;
*Sample data for IF-ELSE exercise;
DATA IFELSE;
SET BIOSTAT.DEATH2005(OBS=30);
IF AGEY >85 THEN AGEY=.;
RUN;

*Basic usage;
DATA IF1;
SET IFELSE;
KEEP DMONTH SEASON SIDO SUDO;

IF 3<=  DMONTH <=5 THEN SEASON='SPRING';  
ELSE IF 6<=  DMONTH <=8 THEN SEASON='SUMMER';
ELSE IF 9<=  DMONTH <=11 THEN SEASON='FALL';
ELSE IF DMONTH=12 OR ( 1<=  DMONTH <=2) THEN SEASON='WINTER';

IF SIDO = '11' OR SIDO = '23' OR SIDO = '31' THEN SUDO=1;
ELSE SUDO=0;

RUN;

*Advanced usage;
DATA IF2;
SET IFELSE;
KEEP SEX SEX_TYPE DAY DDAY NEW_DAY 
		SIDO ICD1 ICD2 NEW_ICD1 NEW_ICD2 ;

IF SEX=2 THEN DO; *Do-End with IF statement;
		SEX_TYPE='Female';
		NEW_DAY=MIN(DAY,DDAY);
END;

IF SIDO='39' THEN DO; *Nested IF statement;
		IF SEX=1 THEN DO;
				NEW_ICD1=SUBSTR(ICD1,1,3);
				NEW_ICD2=SUBSTR(ICD2,1,3);
		END;
END;
RUN;

*Be careful when dealing with missing values;
DATA IF3;
SET IFELSE;
KEEP AGEY AGE_GROUP;

IF AGEY < 65 THEN AGE_GROUP='Under 65 y';
ELSE IF AGEY < 75 THEN AGE_GROUP='65~75 y';
ELSE AGE_GROUP='Over 75 y';
RUN;

*Correct output;
DATA IF3_2;
LENGTH AGE_GROUP $10; *This is specified to prevent truncated result; 
SET IFELSE;
KEEP AGEY AGE_GROUP;

IF AGEY = . THEN AGE_GROUP=''; * you need to specify the IF statement for missing values;
ELSE IF AGEY < 65 THEN AGE_GROUP='Under 65 y';
ELSE IF AGEY < 75 THEN AGE_GROUP='65~75 y';
ELSE AGE_GROUP='Over 75 y';
RUN;



/*MERGE statement*/
***MERGE***;
*SIDO name table for merging tables;
DATA SIDO_TABLE;
LENGTH SIDO $2 NAME $40;
INPUT SIDO $ NAME $;
CARDS;
00 해외
11 서울특별시
21 부산광역시
22 대구광역시
23 인천광역시
24 광주광역시
25 대전광역시
26 울산광역시
31 경기도
32 강원도
33 충청북도
34 충청남도
35 전라북도
36 전라남도
37 경상북도
38 경상남도
39 제주특별자치도
99 지역미상
;
RUN;
PROC PRINT DATA=SIDO_TABLE; RUN;

*Data modification for merging practice;
DATA DEATH2005_REVISED;
SET BIOSTAT.DEATH2005;
IF SIDO='39' THEN DO;
		IF DAY <=3 THEN SIDO='23';
		ELSE IF DAY <=6 THEN SIDO='24';
		ELSE IF DAY <=9 THEN SIDO='25';
		ELSE IF DAY <=12 THEN SIDO='26';		
		ELSE IF DAY <=15 THEN SIDO='32';
		ELSE IF DAY <=18 THEN SIDO='33';
		ELSE IF DAY <=21 THEN SIDO='35';
		ELSE IF DAY <=24 THEN SIDO='36';
		ELSE IF DAY <=27 THEN SIDO='37';
		ELSE SIDO='39';
END;
RUN;

*DEATH2005 table with for merging tables(only 1 observation for each SIDO code);
PROC SORT DATA=DEATH2005_REVISED 
		  OUT=DEATH2005_UNIQUE(KEEP=AGEY DIA EDU SIDO DDATE)  NODUPKEY; 
BY SIDO; 
RUN;

*Sorting procedure(Essential step to merge tables); 
PROC SORT DATA=DEATH2005_UNIQUE OUT=SORT_DEATH2005; BY SIDO; RUN;
PROC SORT DATA=SIDO_TABLE; BY SIDO; RUN;

*MERGE TYPE1(A OR B);
DATA MERGE1;
MERGE SORT_DEATH2005 SIDO_TABLE;
BY SIDO;
RUN;

*MERGE TYPE2(A AND B);
DATA MERGE2;
MERGE SORT_DEATH2005(IN=A) SIDO_TABLE(IN=B);
BY SIDO;
IF A AND B;
RUN;

*MERGE TYPE3(ONLY A);
DATA MERGE3;
MERGE SORT_DEATH2005(IN=A) SIDO_TABLE(IN=B);
BY SIDO;
IF A;
RUN;

*MERGE TYPE4(ONLY B);
DATA MERGE4;
MERGE SORT_DEATH2005(IN=A) SIDO_TABLE(IN=B);
BY SIDO;
IF B;
RUN;




/*Special Statement in SAS*/
*FORMAT / INFORMAT statement*

***FORMAT***;
*Pre-specified FORMAT;
PROC FORMAT;
		VALUE AGE_GROUP 1='65세 이상' 2='65세 미만';
		VALUE RISK 1='고위험군' 2='저위험군';
		VALUE TRT 1='실험군' 2='대조군';
RUN;

*Dataset;
DATA FORMAT;
A=1; B=1; C=1; D=1; E=1; F=1; G=1; I=1;
RUN;

*Print data using FORMAT;
PROC PRINT DATA=FORMAT;
FORMAT A MMDDYY8. B DATE9. C DOLLAR12. D PERCENT8.2 
			 E 12.5 F AGE_GROUP. G RISK. I TRT.;
RUN;


***INFORMAT***;
*Without INFORMAT statement;
DATA INFORMAT1;
INPUT W $ DATE $ SPC $ PRICE $ ;
CARDS;
240W 02-07-2008 Ginger     120,000
240W 02-07-2008 Protea     1,180,000
356W 02-08-2008 Heliconia  62,000
356W 02-08-2008 Anthurium 300,000
188R 02-11-2008 Ginger     24,000
;
RUN;

*using INFORMAT statement;
DATA INFORMAT2;
INPUT W $ DATE MMDDYY10. SPC $ PRICE COMMA20. ;
CARDS;
240W 02-07-2008 Ginger     120,000
240W 02-07-2008 Protea     1,180,000
356W 02-08-2008 Heliconia  62,000
356W 02-08-2008 Anthurium 300,000
188R 02-11-2008 Ginger     24,000
;
RUN;

*using INFORMAT & LENGTH statement;
DATA INFORMAT3;
LENGTH W $8 SPC $10;
INPUT W $ DATE MMDDYY10. SPC $ PRICE COMMA20. ;
CARDS;
240W 02-07-2008 Ginger     120,000
240W 02-07-2008 Protea     1,180,000
356W 02-08-2008 Heliconia  62,000
356W 02-08-2008 Anthurium 300,000
188R 02-11-2008 Ginger     24,000
;
RUN;


***INPUT, PUT***;
*Example of INPUT(Convert character to numeric), PUT(Convert numeric to character) ;
DATA INPUT_PUT;
		VAR1='14'; *Character;
		VAR2=2000; *Numeric;
		VAR3='14.23456789'; *Character;
		VAR4=1; *Numeric;

		INPUT1=INPUT(VAR1, BEST12.); *Character to Numeric;
		PUT2=PUT(VAR2,10.); *Numeric to Character;
		INPUT3=INPUT(VAR3, BEST12.); *Character to Numeric;
		PUT4=PUT(VAR4, YYMMDD10.); *Numeric to Character(DATE);
RUN;




/*Basic Analysis Procedures*/
***Various Useful Procedures***;

*PROC CONTENTS;
PROC CONTENTS DATA=BIOSTAT.DEATH2005; 
RUN;

*PROC SORT;
PROC SORT DATA=SASHELP.CLASS OUT=SORT1; BY NAME; RUN; *Order by name;
PROC SORT DATA=SASHELP.CLASS OUT=SORT2; BY DESCENDING NAME; RUN; *Descending order by name;
PROC SORT DATA=SASHELP.CLASS OUT=SORT3; BY NAME DESENDING AGE; RUN; *Order by two variables;

PROC SORT DATA=SASHELP.CLASS OUT=SORT4 NODUPKEY; BY AGE; RUN; *Delete duplicate value by AGE;
PROC SORT DATA=SASHELP.CLASS OUT=SORT5 NODUPKEY; BY _ALL_; RUN; *Delete duplicate value by all variables;

*PROC UNIVARIATE;
PROC UNIVARIATE DATA=SASHELP.CLASS;
CLASS SEX; *Use it when you want seperate results by group;
VAR HEIGHT; *Select variable(s) you want;
HISTOGRAM; *Print histogram;
RUN;

*PROC MEANS;
PROC MEANS DATA=SASHELP.CLASS N MEAN STD MIN MAX Q1 MEDIAN Q3 p1 p80 p95 p99; 
CLASS SEX; *Use it when you want seperate results by group;
VAR HEIGHT; *Select variable(s) you want;
OUTPUT OUT=MEAN_RESULT ; *Output file of the result;
RUN;

*PROC FREQ;
PROC FREQ DATA=BIOSTAT.DEATH2005; *Generate frequency table;
TABLE EDU ;
RUN;
PROC FREQ DATA=BIOSTAT.DEATH2005; *Frequency table & Chi-square Test;
TABLE SEX*EDU / CHISQ ;
RUN;

*PROC TTEST;
PROC TTEST DATA=SASHELP.CLASS;
CLASS SEX; *2 Group variable;
VAR AGE; *Select variable(s) you want to test;
RUN;
