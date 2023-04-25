### March 27 ###
# chap 6 examples

## EX.6.2.1.
# 10명의 표본, 표본평균은 22, 분산 45

## EX.6.2.4.
birth = read.csv("C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/birth.csv",header=T)
head(birth)
x = birth$matage
n = length(x); n # 500
summary(x)
'''
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  23.00   31.00   34.00   34.03   37.00   43.00 
'''
sd(x)**2

m = mean(x); m # 34.028
s = sqrt(var(x)); s # 3.897897
n = length(x); n # 500
alpha = 0.05 # 알파값 = 0.05로 지정
'''
오차 = qnorm(1-알파값/2)*표준편차/sqrt(길이)
'''
error = qnorm(1-alpha/2)*s/sqrt(n)
left = m-error; left # 33.68634
right = m+error; right # 34.36966
'''
# 1) 함수 만들기
confint = function(m,s,n,alpha=0.05){
  error = qnorm(1-alpha/2)*s/sqrt(n)
  left = m-error
  right = m+error
  c(left,right)
}
# 2) 함수 불러오기
confint(m,s,n)
'''
confint(0.7164,sqrt(0.36),35,alpha=0.10) # 0.5495814 0.8832186
# 두 값의 차(left-right) 확인하기
confint(0.7164,sqrt(0.36),35,alpha=0.10)[2]-confint(0.7164,sqrt(0.36),35,alpha=0.10)[1]
# 0.3336372

## EX.6.3.1.
# n=19, 평균 250.8, 표준편차 130.9, 모평균의 95% 신뢰구간?

## t-분포 그리기
x = seq (-4,4,length=100) # 등간격 100으로 만들기
hx = dnorm(x)
degf = c(1,3,8,30) # 자유도
colors = c("red","blue","darkgreen ","gold","black")
labels = c("df =1","df =3","df =8","df =30","normal")
plot(x,hx,type="l",lty=2,xlab ="x label",
     ylab="Density",main="Comparison of t Distribution")
for (i in 1:4){
lines(x,dt(x,degf[i]),lwd =2,col=colors[i])
}

legend("topright",inset=.05,title="Distributions",
       labels,lwd=2,lty=c(1, 1, 1, 1, 2),col=colors)

### 6.4. 두 집단 분산 차의 신뢰구간
## 1) 모분산 동일 = 합동추정량
# s1 = sd(X1)
# s2 = sd(X2)
# sp2 = ((n1-1)*s1**2+(n2-1)*s2**2)/(n1+n2-2)
## 2) 모분산 다름 = t'-분포
# t1 = qt(누적확률,n1-1)
# t2 = qt(누적확률,n2-1)
# t' = ((s1**2/n1)*t1+(s2**2/n2)*t2)/((s1**2/n1)+(s2**2/n2))

### 6.5. 모비율의 신뢰구간
# 하한값 = 표본비율-qnorm(누적확률)*sqrt(표본비율(1-표본비율)/n)
# 상한값 = 표본비율+qnorm(누적확률)*sqrt(표본비율(1-표본비율)/n)

### 6.6. 두 모비율 차의 신뢰구간
# p = 두 비율의 차 = p1-p2
# 하한값 = p-qnorm(누적확률)*sqrt(p1*(1-p1)/n1+p2*(1-p2)/n2)
# 상한값 = p+qnorm(누적확률)*sqrt(p1*(1-p1)/n1+p2*(1-p2)/n2)

### 6.7. 표본 크기의 결정 : 모평균
# d > 복원/비복원에 따라 다름
# n = ((qnrom(누적확률)**2)*p*(1-p))/(d**2)
## 카이제곱분포

### 6.10. 두 정규분포 모집단 분산비의 신뢰구간
library(car)