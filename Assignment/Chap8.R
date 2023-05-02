# Chap8 과제

### 9.
group_=read.csv('D:/GitHub/2023_HealthStatistics/Assignment/data/group.csv')
summary(group_)
group_$value=as.character(group_$value)
group_=data.frame(group_)
# group_$group=as.factor(group_$group)
# group_$group_num=ifelse(group_$group=="A",1,ifelse(group_$group=="B",2,3))
# group_$group_num=as.factor(group_$group_num)
anova(lm(group~value,group_))
summary(aov(group_num~value,group_))
'''
            Df Sum Sq Mean Sq F value Pr(>F)  
value        1  2.619  2.6187   4.475 0.0395 *
Residuals   49 28.675  0.5852                 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
'''
## 결과적으로, p-value=0.0395<alpha=0.05기 때문에 귀무가설 기각
## 즉, 세 집단 중 한 집단 이상 표본 평균이 유의한 차이가 있음
group<-rep(c("A","B","C"),c(19,19,13))
value=c(18,18,20,21,23,23,24,26,26,27,28,29,29,29,30,30,30,30,32,10,16,22,22,23,26,28,28,28,29,29,30,31,32,32,33,33,38,39,17,24,26,27,29,30,30,33,34,35,35,36,9)
group_<-data.frame(cbind(group,value))
fit<-lm(value~group,data=group_) 
anova(fit)
'''
Analysis of Variance Table

Response: value
          Df  Sum Sq Mean Sq F value Pr(>F)
group      2   47.64  23.821  0.5821 0.5626
Residuals 48 1964.40  40.925 
'''
#summary(fit)
summary(aov(value~group,data=group_))

### 10.
hos=read.csv('D:/GitHub/2023_HealthStatistics/Assignment/data/hospital.csv')
hos$hospital=as.factor(hos$hospital)
hos$treat=as.factor(hos$treat)
## 1) 치료물질 간 효과
summary(aov(effect~treat,hos))
# p-value=5.19e-05 ***<유의확률=0.05로 귀무가설 기각
# 즉, 치료물질 간 효과 차이가 있다.
## 2) 병원 간 효과
summary(aov(effect~hospital,hos))
# p-value=0.37>유의확률=0.05로 귀무가설 채택
# 즉, 병원 간 효과 차이가 있다.
## 3) 치료물질과 병원 간 교호작용
summary(aov(effect~treat*hospital,hos))
# p-value=0.189>유의확률=0.05로 귀무가설 기각
# 즉, 교호작용 유의하지 않다.


### 11.
pf(29.29,4,35,lower.tail=F)


### 12.
pf(57.63,3,9,lower.tail=F)


### 14.
pf(8.25,2,7,lower.tail=F)
