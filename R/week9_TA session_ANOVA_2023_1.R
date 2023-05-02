###################################################
########## ANOVA(Analysis of Variance) ############
###################################################


###############
###Example 1###
###############

##########################
#1) make raw data 
##########################

method<-rep(c("A","B","C"),c(7,7,7))
ascorbic<-c(14.29,19.1,19.09,16.25,15.09,16.61,19.63,20.06,20.64,18,19.56,
            19.47,19.07,18.38,20.04,26.23,22.74,24.04,23.37,25.02,23.27)
frozenfood<-data.frame(cbind(method,ascorbic))
frozenfood


##########################
#2) ANOVA
##########################

fit <- lm(ascorbic ~ method, data=frozenfood) 
anova(fit)
#summary(fit)
summary(aov(ascorbic ~ method, data=frozenfood))



###############
###Example 2###
###############

##########################
#1) make raw data 
##########################

#1
y<-data.frame(c(3,15))
age<-c(1,1,1,2,2,2,3,3,3,4,4,4,5,5,5)
method<-c("a","b","c","a","b","c","a","b","c","a","b","c","a","b","c")
hour<-c(7,9,10,8,9,10,9,9,12,10,9,12,11,12,14)

#2
length(age) ; length(method) ; length(hour)
class(age) ; class(method) ; class(hour)
y<-data.frame(cbind(age,method,hour),stringsAsFactors=F) #cbind & data.frame
y

#1+2 (위의 과정을 한번에)
y<-data.frame(cbind(age=c(1,1,1,2,2,2,3,3,3,4,4,4,5,5,5),  
  method=c("a","b","c","a","b","c","a","b","c","a","b","c","a","b","c"),
  hour=c(7,9,10,8,9,10,9,9,12,10,9,12,11,12,14)),stringsAsFactors=F)
y


##########################
#2) explore raw data
##########################

dim(y); names(y) ; class(y); class(y$age) ; class(y$method);  class(y$hour);
y$hour<-as.numeric(y$hour) # 문자변수를 숫자변수로 변환하기 
class(y$hour)

table(y$age) ; table(y$method) ; table(y$hour)
summary(y$hour)
tapply(y$hour, y$age, mean) # age group 별 hour 평균 산출
tapply(y$hour, y$age, sum) # age group 별 hour 합계 산출
tapply(y$hour, y$age, sd) # age group 별 hour 표준편차 산출
tapply(y$hour, y$method, mean) # method 별 hour 평균 산출
tapply(y$hour, y$method, sum) # method 별 hour 합계 산출

par(mfrow=c(1,2))
boxplot(hour ~ age, data=y, col="red")
boxplot(hour ~ method, data=y, col="blue")


##########################
#3) ANOVA
##########################

fit <- lm(hour ~ age + method, data=y) 
anova(fit)  
#summary(fit)
summary(aov(hour ~ age + method, data=y))

###Tukey's HSD(Honest Significant Difference) method
a1 <- aov(hour ~ age + method, data=y)
require(graphics)
par(mfrow=c(1,2))
TukeyHSD(a1, "age", ordered = TRUE) 
#posthoc_age <- TukeyHSD(x=a1, 'age', conf.level=0.95) 
plot(TukeyHSD(a1, "age")) 
TukeyHSD(a1, "method", ordered = TRUE) 
plot(TukeyHSD(a1, "method")) 


###############
###Example 3###
###############

##########################
#1) make raw data 
##########################

seg<-rep(c(1,2,3),c(12,12,12))
method<-rep(rep(c("routine","A","B"),c(4,4,4)),3)
result<-c(56,46,29,33,47,28,28,30,28,42,53,42,51,21,36,27,59,47,45,53,68,
          75,77,84,45,41,31,37,55,71,76,85,44,68,77,76)
consultation<-data.frame(cbind(seg,method,result))
consultation


##########################
#2) ANOVA
##########################

fit <- lm(result ~ seg + method + seg*method, data=consultation) 
anova(fit)  
#summary(fit)
summary(aov(result ~ seg + method + seg*method, data=consultation))
