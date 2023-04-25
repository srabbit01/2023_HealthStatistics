###################################
########## t-test #################
###################################


###################################
#1. One sample t-test
###################################

peppers<-read.table("C:\\R_data\\myrawdata\\peppers.csv",header=TRUE,sep=",")
head(peppers)
peppers

?t.test
## Default S3 method:
#t.test(x, y = NULL,
#       alternative = c("two.sided", "less", "greater"),
#       mu = 0, paired = FALSE, var.equal = FALSE,
#       conf.level = 0.95, ...) 

summary(peppers)

#default: mean=0, n=28, confidence level=0.95, alternative="two.sides"
t.test(peppers$angle) 

mean(peppers$angle)
var(peppers$angle)
sd(peppers$angle) #sqrt(var(peppers$angle))
(3.178571-0)/(5.298872/sqrt(28)) #t-value

qt(0.975, df=27) 
3.17851-2.051831*(5.298872/sqrt(28)) #lower CI
3.17851+2.051831*(5.298872/sqrt(28)) #upper CI
mean(peppers$angle)-qt(0.975,df=27)*(sd(peppers$angle)/sqrt(28)) 
mean(peppers$angle)+qt(0.975,df=27)*(sd(peppers$angle)/sqrt(28)) 

#mean=2, n=28, confidence level=0.95, alternative="two.sides"
t.test(peppers$angle,mu=2.0,conf.level=.95) 


###################################
#2. Paired t-test
###################################

pulse<-read.table("C:\\R_data\\myrawdata\\pulse.csv",header=TRUE,sep=",")
pulse

t.test(pulse$pre, pulse$post, paired=TRUE)
t.test(pulse$pre, pulse$post, alternative='two.sided', conf.level=.95, paired=TRUE) #same result

t.test(pulse$pre, pulse$post, alternative='greater', conf.level=.95, paired=TRUE)
t.test(pulse$pre, pulse$post, alternative='less', conf.level=.95, paired=TRUE)

#################################################
#3. Independent sample t-test (Two Sample t-test)
#################################################

bullets<-read.table("C:\\R_data\\myrawdata\\bullets.csv",header=TRUE,sep=",")
bullets

#F Test to Compare Two Variances
?var.test
var.test(velocity ~ powder, data=bullets)

t.test(velocity~powder, var.equal=TRUE, data=bullets) #pooled variance 

t.test(velocity~powder, var.equal=FALSE, data=bullets)
t.test(velocity~powder, data=bullets) #same result
