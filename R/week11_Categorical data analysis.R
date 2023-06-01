##### Goodness of Fit 
####Example 11.2.1: Normal distribution
### Example of calculating probability at certain range
# Given mean, sd
x.mean <- 21.05319
x.s2 <- 75.9482

# Range of X
start <- 1
end <- 6
# Probability for a range on a normal distribution
prob.start <- pnorm(start, mean=x.mean, sd=sqrt(x.s2), lower.tail=TRUE)
prob.end <- pnorm(end, mean=x.mean, sd=sqrt(x.s2), lower.tail=TRUE)
prob.end - prob.start

# Range of Z
z.start <- (1-x.mean)/sqrt(x.s2)
z.end <- (6-x.mean)/sqrt(x.s2)
# Probability for a range on a normal distribution
prob.start <- pnorm(z.start, lower.tail=TRUE)
prob.end <- pnorm(z.end, lower.tail=TRUE)
prob.end - prob.start

# All probabilities for each range under H0
round(pnorm(1, mean=x.mean, sd=sqrt(x.s2), lower.tail=TRUE), 4)
for (i in 0:7){
  start <- i*5+1; print(paste0("start:", start)) 
  end <- start+5; print(paste0("end:", end)) 
  prob <- pnorm(end, mean=x.mean, sd=sqrt(x.s2), lower.tail=TRUE)-pnorm(start, mean=x.mean, sd=sqrt(x.s2), lower.tail=TRUE)
  print(paste0("PROBABILITY:", round(prob, 4)))
}
round(pnorm(41, mean=x.mean, sd=sqrt(x.s2), lower.tail=FALSE), 4)

##### Independence Test
####Example 11.3.1
### Chi Squared Test
data	<-	as.table(cbind(c(294,98,50,203), c(921,2862,3064,2652))) 
dimnames(data)	<-	list(var1=c("A","B","C","D"), var2=c("Yes","No")) 
chisq_result <- chisq.test(data); chisq_result
# Ei (expected frequency)
chisq_result$expected

####Example 11.3.2
### Chi Squared Test
data	<-	as.table(cbind(c(131,14), c(52,36))) 
dimnames(data)	<-	list(smoke=c("Y","N"), alcohol=c("Y","N")) 
chisq.test(data, correct=FALSE) 
chisq.test(data, correct=TRUE) 	# Yates' continuity correction

### Chi Squared Test manual calculation (2 x 2 table)
a=131; b=52; c=14; d=36
n=a+b+c+d
# Chi Squared Test
numerator <- n*(a*d-b*c)**2
denominator <- (a+c)*(b+d)*(a+b)*(c+d)
test.stat <- numerator / denominator; test.stat

# Chi Squared Test with Yates' continuity correction
numerator <- n*(abs(a*d-b*c)-0.5*n)**2
denominator <- (a+c)*(b+d)*(a+b)*(c+d)
test.stat <- numerator / denominator; test.stat



##### Homogeneity Test
####Example 11.3.2
### Chi Squared Test
data	<-	as.table(cbind(c(28,19,41,53), c(35,38,44,60))) 
dimnames(data)	<-	list(type=c("A","B","C","D"), category=c("LT_18Y","18Y+")) 
chisq.test(data) 

###Fisher's exact Test
#IF some EXPECTED FREQUENCY are LESS THAN 5
data	<-	as.table(cbind(c(0,19,41,53), c(1,38,44,60))) 
dimnames(data)	<-	list(type=c("A","B","C","D"), category=c("LT_18Y","18Y+")) 
#Check expected frequency
chi.table <- chisq.test(data) 
chi.table$expected
#Fisher's exact Test
fisher.test(data)



##### Estimates in observational study
### Relative Risk (RR) and Odds Ratio (OR)
# install.packages("mosaic") 	# for oddsRatio, relrisk
library(mosaic)
data	<-	as.table(cbind(c(178,26), c(3386,380))) 
dimnames(data)	<-	list(exposure=c("Non-smoking","Smoking"), outcome=c("Disease","Disease-free")) 
# Odds Ratio (OR) (including RR result as well)
oddsRatio(data, verbose = TRUE)
# Relative Risk (RR) (including OR result as well)
relrisk(data, verbose = TRUE)

#IF OUTCOME IS NOT RARE CASE
data	<-	as.table(cbind(c(1000,300), c(3386,380))) 
dimnames(data)	<-	list(exposure=c("Non-smoking","Smoking"), outcome=c("Disease","Disease-free")) 
# Odds Ratio (OR)
oddsRatio(data, verbose = TRUE) #OR and RR are QUITE DIFFERENT when outcome is not rare
# Relative Risk (RR)
relrisk(data, verbose = TRUE)



### Mantel-Haenszel statistics
# install.packages("questionr") 	# for wtd.table
# install.packages("abind") 	      # for abind
# install.packages("DescTools") 	# for BreslowDayTest
library(questionr) 
library(abind) 
library(DescTools) 
data_ag	<- read.csv("D:/alligator.csv")
data_ag$Food_2 <- ifelse(data_ag$Food == "Fish", "Fish", "Other")
#Some data steps to conduct MH test (stratified by Lake variable)
table_tmp	<- lapply(unique(data_ag$Lake), function(lake) {
  data_tmp	<- data_ag[data_ag$Lake == lake,] ;
  return(wtd.table(data_tmp$Size, data_tmp$Food_2, data_tmp$Count))
}) 
names(table_tmp)	<- unique(data_ag$Lake) 
table_mh	<- abind(table_tmp, along=3) 
# Mantel-Haenszel statistics (confounder variable: Lake) 
mantelhaen.test(table_mh)
BreslowDayTest(table_mh) 
# Odds Ratio for each stratum (by Lake)
trnsfrm <- Rev(table_mh[,,"George"], margin=1); oddsRatio(trnsfrm, verbose = TRUE)
trnsfrm <- Rev(table_mh[,,"Hancock"], margin=1); oddsRatio(trnsfrm, verbose = TRUE)
trnsfrm <- Rev(table_mh[,,"Ocklawaha"], margin=1); oddsRatio(trnsfrm, verbose = TRUE)
trnsfrm <- Rev(table_mh[,,"Trafford"], margin=1); oddsRatio(trnsfrm, verbose = TRUE)



