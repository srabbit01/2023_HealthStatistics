/*IMPORT DATAFILE*/
proc import datafile="/home/2022_2 Introduction to Biostatistics/iris.csv"
     out=iris
     dbms=csv
     replace;
     getnames=yes;
run;

/*Simple Linear Regression*/
proc reg data=iris;
	model Sepal_Length = Petal_Width;
run;

/* cor.test(~Sepal.Length+Petal.Width, iris) */
proc corr data=iris plots=matrix(histogram) ;
var Sepal_Length Petal_Width;
run;

/* cor.test for 3 variables (with plots) */
proc corr data=iris plots=matrix(histogram) ;
var Sepal_Length Petal_Width Petal_Length ;
run;

/* pcor.test(Sepal.Length, Sepal.Width, Petal.Length) */
proc corr data=iris plots=matrix(histogram) ;
var Sepal_Length Sepal_Width;
partial Petal_Length;
run;

