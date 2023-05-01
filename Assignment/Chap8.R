# Chap8 과제

### 9.
group_=read.csv('D:/GitHub/2023_HealthStatistics/Assignment/data/group.csv')
group_
group_$group=as.factor(group_$group)
group_$group_num=ifelse(group_$group=="A",1,ifelse(group_$group=="B",2,3))
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
