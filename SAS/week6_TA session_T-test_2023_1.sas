/**************************************/
/* Introduction to Biostat 2022.10.31 */
/**************************************/

LIBNAME BIOSTAT '/home/users/2022_2 Introduction to Biostatistics';


/*Data summary : PROC UNIVARIATE */
PROC UNIVARIATE DATA=BIOSTAT.PEPPERS;
RUN;

/*********************/
/* One sample T-test */
/*********************/
PROC MEANS DATA=BIOSTAT.PEPPERS MEAN STD STDERR T PROBT;
RUN;

PROC TTEST DATA=BIOSTAT.PEPPERS;
RUN;

PROC TTEST DATA=BIOSTAT.PEPPERS H0=2;
RUN;

/*****************/
/* Paired T-test */
/*****************/

DATA BIOSTAT.PULSE;
SET BIOSTAT.PULSE;
D=PRE-POST;
RUN;

PROC MEANS DATA=BIOSTAT.PULSE MEAN STD STDERR T PROBT;
VAR D;
RUN;

PROC TTEST DATA=BIOSTAT.PULSE;
VAR D; /*D(Difference between pre and post)*/
RUN;

PROC TTEST DATA=BIOSTAT.PULSE;
PAIRED PRE*POST; /*Same as above result with more graphs*/
RUN;


/******************************/
/* Independent samples T-test */
/******************************/
PROC TTEST DATA=BIOSTAT.BULLETS;
CLASS POWDER;
VAR VELOCITY;
RUN;
