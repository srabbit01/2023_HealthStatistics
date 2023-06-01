/*IMPORT DATAFILE*/
PROC IMPORT DATAFILE="/home/u47370435/2022_2 IB/iris.csv"
					OUT=IRIS
					DBMS=CSV REPLACE;
					GETNAMES=YES;
					GUESSINGROWS=150;
RUN;



/***Simple Linear Regression***/
/*Using PROC REG*/
*Equals to the lm(Sepal.Length ~ Petal.Width, data=iris) in R;
PROC REG DATA=IRIS;
		MODEL SEPAL_LENGTH = PETAL_WIDTH;
RUN; QUIT;
/*Using PROC GLM*/
*Equals to the lm(Sepal.Length ~ Petal.Width, data=iris) in R;
PROC GLM DATA=IRIS PLOTS=(ALL);
		MODEL SEPAL_LENGTH = PETAL_WIDTH;
RUN; QUIT;



/***Multiple Linear Regression***/
/*Using PROC GLM*/
*Basic model;
*Equals to the lm(Sepal.Length ~ Petal.Width+Petal.Length, data=iris) in R;
PROC GLM DATA=IRIS PLOTS=(ALL);
		MODEL SEPAL_LENGTH = PETAL_WIDTH  PETAL_LENGTH / CLPARM solution;
RUN; QUIT;

*Adding categorical variable;
*Equals to the lm(Sepal.Length ~ Petal.Width+Petal.Length+Species, data=iris) in R;
PROC GLM DATA=IRIS PLOTS=(ALL);
		CLASS SPECIES (REF='virginica');
		MODEL SEPAL_LENGTH = PETAL_WIDTH  PETAL_LENGTH SPECIES / CLPARM solution;
RUN; QUIT;

*Interaction;
*Equals to the lm(Sepal.Length ~ Petal.Width + Petal.Length + Petal.Width*Petal.Length + Species, data=iris) in R;
PROC GLM DATA=IRIS PLOTS=(ALL);
		CLASS SPECIES (REF='virginica');
		MODEL SEPAL_LENGTH = PETAL_WIDTH  PETAL_LENGTH PETAL_WIDTH*PETAL_LENGTH  SPECIES/ CLPARM solution;
RUN; QUIT;

