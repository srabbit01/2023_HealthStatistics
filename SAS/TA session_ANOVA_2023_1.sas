/**************************************/
/* Introduction to Biostat 2022.10.31 */
/**************************************/

/************/
/* Example1 */
/************/

DATA FROZENFOOD;
INPUT METHOD $ ASCORBIC;
CARDS;
A 14.29
A 19.1
A 19.09
A 16.25
A 15.09
A 16.61
A 19.63
B 20.06
B 20.64
B 18
B 19.56
B 19.47
B 19.07
B 18.38
C 20.04
C 26.23
C 22.74
C 24.04
C 23.37
C 25.02
C 23.27
;
RUN;
PROC PRINT DATA=FROZENFOOD; RUN; 

PROC ANOVA DATA=FROZENFOOD;
CLASS METHOD;
MODEL ASCORBIC=METHOD;
MEANS METHOD / TUKEY ALPHA=0.05;
RUN;

/************/
/* Example2 */
/************/

DATA A;
INPUT AGE METHOD $ HOUR @@;
DATALINES;
1 a 7 1 b 9 1 c 10 2 a 8 2 b 9 2 c 10 3 a 9 3 b 9 3 c 12
4 a 10 4 b 9 4 c 12 5 a 11 5 b 12 5 c 14 
;
RUN;

PROC PRINT DATA=A; RUN;
PROC MEANS DATA=A SUM N MEAN; CLASS AGE; VAR HOUR; RUN; /* Mean by age */
PROC MEANS DATA=A SUM N MEAN; CLASS METHOD; VAR HOUR; RUN; /* Mean by teaching methods */
PROC MEANS DATA=A SUM N MEAN; VAR HOUR; RUN; /* Total mean */


/* multiple comparison using ttest */
PROC TTEST DATA=A; CLASS METHOD; VAR HOUR; RUN; /* error message */
PROC TTEST DATA=A; WHERE METHOD IN ('a' 'b'); CLASS METHOD; VAR HOUR; RUN;
PROC TTEST DATA=A; WHERE METHOD IN ('a' 'c'); CLASS METHOD; VAR HOUR; RUN;
PROC TTEST DATA=A; WHERE METHOD IN ('b' 'c'); CLASS METHOD; VAR HOUR; RUN;

/* anova test : methods : treatment effect(처리효과) */
PROC ANOVA DATA=A; CLASS METHOD; MODEL HOUR=METHOD; RUN;
QUIT;

/* anova test : methods : treatment effect(처리효과) , age : block effect(블럭효과) */
PROC ANOVA DATA=A; CLASS AGE METHOD; MODEL HOUR=METHOD AGE; RUN;
QUIT;

/* anova test : methods : treatment effect(처리효과) , age : block effect(블럭효과) : Tukey's HSD */
PROC ANOVA DATA=A; CLASS AGE METHOD; 
MODEL HOUR=METHOD AGE; RUN;
MEANS AGE METHOD / TUKEY ALPHA=0.05; RUN;
QUIT;


/************/
/* Example3 */
/************/

DATA CONSULTATION;
INPUT SEG METHOD $ RESULT @@;
CARDS;
1 routine 56 1 routine 46  1 routine 29 1 routine 33
1 A 47 1 A 28 1 A 28 1 A 30 
1 B 28 1 B 42 1 B 53 1 B 42
2 routine 51 2 routine 21 2 routine 36 2 routine  27 
2 A 59 2 A 47 2 A 45 2 A 53 
2 B 68 2 B 75 2 B 77 2 B 84
3 routine 45 3 routine 41 3 routine 31 3 routine 37 
3 A 55 3 A 71 3 A 76 3 A 85 
3 B 44 3 B 68 3 B 77 3 B 76
;
RUN;

PROC PRINT DATA=CONSULTATION; RUN;


PROC ANOVA DATA=CONSULTATION;
CLASS SEG METHOD;
MODEL RESULT=SEG METHOD SEG*METHOD;
RUN;

PROC GLM DATA=CONSULTATION;
CLASS SEG METHOD;
MODEL RESULT=SEG METHOD SEG*METHOD;
RUN;
