*****************************************************************************
*****************************************************************************
*************************Non-parametric Analysis***************************
*****************************************************************************
*****************************************************************************;

/****Central location parameter(Median) Test****/
/*Sign test*/
*Creating data;
DATA NONP_1;
INPUT SCORE;
CARDS;
75
90
86
110
115
94
132
74
82
104
88
124
110
77
99
;
RUN;

*Run Sign test;
PROC UNIVARIATE DATA=NONP_1 MU0=100;
VAR SCORE;
RUN;

*Cumulative Probability of Binomial Distribution;
DATA CUM_1;
P=CDF('BINOMIAL', 6, 0.5, 15) * 2; *CDF('BINOMIAL', x, p, n);
RUN;


/*Wilcoxon signed rank test*/
*Creating data;
DATA NONP_2;
INPUT X;
CARDS;
4.9
4.1
6.73
7.27
7.42
7.5
6.76
4.64
5.98
3.14
3.24
5.8
6.17
5.39
5.78
;
RUN;

*Run Wilcoxon signed rank test;
PROC UNIVARIATE DATA=NONP_2 MU0=4.7;
VAR X;
RUN;


/*Median test*/
*Creating data;
DATA NONP_3;
INPUT REGION MENTAL_SCORE @@;
CARDS;
1 35 1 26 1 27 1 21 
1 27 1 38 1 23 1 25
1 25 1 27 1 45 1 46
1 33 1 26 1 46 1 41
2 29 2 50 2 43 2 22
2 42 2 47 2 42 2 32
2 50 2 37 2 34 2 31
;
RUN;

*Run Median test;
PROC NPAR1WAY DATA=NONP_3 MEDIAN;
CLASS REGION;
VAR MENTAL_SCORE;
RUN;


/*Wilcoxon-Mann-Whitney test*/
*Creating data;
DATA NONP_4;
INPUT GROUP WEIGHT @@;
CARDS;
1 252 1 240 1 205 1 200 
1 170 1 170 1 320 1 148 
1 214 1 254 1 164 1 288 
1 138 1 240 1 217 1 240 
1 302 1 312 2 185 2 310 
2 212 2 238 2 184 2 136 
2 200 2 270 2 280 2 264 
2 270 2 210 2 192 2 126 
2 220 2 295 
;
RUN;
 
*Run Wilcoxon-Mann-Whitney test;
PROC NPAR1WAY DATA=NONP_4 WILCOXON;
CLASS GROUP;
VAR WEIGHT;
EXACT WILCOXON / n=10000000 seed=829596001;
RUN;


/****Goodness-of-fit Test****/
/*Kolmogorov-Smirnov test*/
*Creating data;
DATA NONP_5;
INPUT GLU @@;
CARDS;
75 77 92 86
80 77 80 92
84 80 72 78
84 68 77 78
81 92 77 68
75 80 81 81
80 87 92 76
72 80 77 87
78 77 76 86
;
RUN;

*Run Kolmogorov-Smirnov test;
PROC UNIVARIATE DATA=NONP_5 NORMAL; 
VAR GLU;
RUN;


/****One-way ANOVA****/
/*Kruskal-Wallis test*/
*Creating data;
DATA NONP_6;
INPUT GROUP RESPONSE @@;
CARDS;
1 12.01 2 3.67 3 55.63 
1 29.44 2 4.05 3 27.88
1 28.02 2 6.49 3 66.81 
1 38.33 2 21.12 3 46.27
1 55.91 2 1.11 3 31.19
;
RUN;

*Run Kruskal-Wallis test;
PROC NPAR1WAY DATA=NONP_6 WILCOXON;
CLASS GROUP;
VAR RESPONSE;
EXACT WILCOXON / N=10000000 ;
RUN;


/****Two-way ANOVA****/
/*Friedman test*/
*Creating data;
DATA NONP_7;
INPUT PHYS MEDTOOL $ PERFORMANCE @@;
CARDS;
1 A 2 2 A 2 3 A 2 4 A 1
5 A 3 6 A 1 7 A 2 8 A 1
9 A 1 1 B 3 2 B 3 3 B 3
4 B 3 5 B 2 6 B 2 7 B 3
8 B 3 9 B 3 1 C 1 2 C 1
3 C 1 4 C 2 5 C 1 6 C 3
7 C 1 8 C 2 9 C 2
;
RUN;

*Run Friedman test;
PROC FREQ DATA=NONP_7;
 TABLES PHYS*MEDTOOL*PERFORMANCE 
    / CMH2 SCORES=RANK;
RUN;


/****Correlation Analysis****/
/*Spearman¡¯s rank correlation coefficient test*/
*Creating data;
DATA NONP_8;
INPUT X Y @@;
CARDS;
500 525 475 130
390 325 325 190
325 90 205 295
200 180 75 74
230 420 50 60
175 105 130 148
76 75 200 250
174 102 201 151
125 130
;
RUN;

*Run Spearman¡¯s rank correlation coefficient test;
PROC CORR DATA=NONP_8 SPEARMAN;
VAR X Y;
RUN;

