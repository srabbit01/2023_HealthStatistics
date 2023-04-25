###################################
########## t-test #################
###################################


###################################
#1. One sample t-test
###################################
# 모집단 정의 방법 : 모수 사용
'''
모수의 특징
- unkown : 알 수 없음
- fixed : 이미 정해짐 = 이미 고정된 상수
'''

getwd()
setwd("C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/myrawdata")
# load data
peppers<-read.table("peppers.csv",header=TRUE,sep=",")
head(peppers)
peppers

?t.test
## Default S3 method:
#t.test(x, y = NULL,
#       alternative = c("two.sided", "less", "greater"),
#       mu = 0, paired = FALSE, var.equal = FALSE,
#       conf.level = 0.95, ...) 
'''
paired : TRUE면 두 집단 짝비교(종속성) FALSE면 독립성 검정
var.eqal : TRUE면 동분산 FALSE면 동분산 아님
conf.level : 1-alpha
'''

summary(peppers)

#default: mean=0, n=28, confidence level=0.95, alternative="two.sides"
t.test(peppers$angle) 
'''
	One Sample t-test

data:  peppers$angle
t = 3.1742, df = 27, p-value = 0.003733
alternative hypothesis: true mean is not equal to 0
95 percent confidence interval:
 1.123883 5.233259
sample estimates:
mean of x 
 3.178571 
'''
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

pulse<-read.table("pulse.csv",header=TRUE,sep=",")
pulse

t.test(pulse$pre, pulse$post, paired=TRUE)
t.test(pulse$pre, pulse$post, alternative='two.sided', conf.level=.95, paired=TRUE) #same result

t.test(pulse$pre, pulse$post, alternative='greater', conf.level=.95, paired=TRUE)
t.test(pulse$pre, pulse$post, alternative='less', conf.level=.95, paired=TRUE)

#################################################
#3. Independent sample t-test (Two Sample t-test)
#################################################

bullets<-read.table("bullets.csv",header=TRUE,sep=",")
bullets

#F Test to Compare Two Variances
?var.test
var.test(velocity ~ powder, data=bullets) # 등분산성 검정
'''
	F test to compare two variances

data:  velocity by powder
F = 1.6433, num df = 7, denom df = 9, p-value = 0.4782
alternative hypothesis: true ratio of variances is not equal to 1
95 percent confidence interval:
 0.3915426 7.9261017
sample estimates:
ratio of variances 
          1.643323 
> 귀무가설 : 비율이 1 = 분산 동일 의미
> 결과, p-value(0.4782) > 0.05로 귀무가설 채택
'''

t.test(velocity~powder, var.equal=TRUE, data=bullets) #pooled variance 

# 분산이 동일하지 않은 경우, var.equal=FALSE(default)
# t.test(velocity~powder, var.equal=FALSE, data=bullets)
# = t.test(velocity~powder, data=bullets) #same result
