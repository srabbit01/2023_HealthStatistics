# Chap4 과제

### 14.
# Load dose.csv
dose = read.csv('C:/work/Crystal/GitHub/2023_HealthStatistics/Assignment/data/dose.csv',header=T)
dose
## 1)
# 누적도수 추가
dose$accFreq = cumsum(dose$freq)
## 2)
# 확률분포
barplot(dose$freq/sum(dose$freq),names=dose$drug,main="확률분포",xlab="중독물질의 수",ylab="확률",ylim=c(0,0.3))
# 누적확률분포
barplot(dose$accFreq/sum(dose$freq),names=dose$drug,main="누적확률분포",xlab="중독물질의 수",ylab="누적확률",ylim=c(0,1))
## 7)
# 확률 추가
dose$prob = dose$freq/sum(dose$freq)
# 평균 = sum(X*확률)
dmean = sum(dose$drug*dose$prob)
dmean
# 분산 = E(X^2)-(E(X))^2
dvar = sum((dose$drug**2)*dose$prob)-(sum(dose$drug*dose$prob))**2
dvar
# 표준편차
dsd = sqrt(dvar)
dsd

### 15. 고혈압 성인 비율 = 20%, 20명 랜덤 추출
# 평균 발생 횟수 = 20 * 0.2 = 4
## 1) 고혈압 환자 = 3
dpois(3,4)
## 2) 고혈압 환자 3명 이상
ppois(3,4,lower=F)
## 3) 고혈합 환자 3명 미만
ppois(3,4,lower=T)
## 4) 고혈압 환자 3명 이상 7명 미만
ppois(7,4)-ppois(3,4)

### 17.
## 1) 고혈압 환자 0명
dpois(0,4)
## 2) 고혈압 환자 1명 초과
ppois(1,4,lower=F)
## 3) 고혈압 환자 1명 이상 3명 이하
ppois(3,4)-ppois(1,4)
## 4) 고혈압 환자 2명 이하
ppois(2,4)
## 5) 고혈압 환자 5명
dpois(5,4)

### 19. 울산 공장 연평균 5건 사고 발생
## 1) 1년 간 7건 사고 발생
dpois(7,5)
## 2) 1년 간 10건 이상 사고 발생
ppois(10,5,lower=F)
## 3) 1년 간 사고 발생 없음
ppois(0,5)
## 4) 1년 간 5건 미만 발생
ppois(5,5)

### 20. N(0,1^2)
## 1) P(0<Z<1.43)
pnorm(1.43,0,1)-pnorm(0,0,1)
pnorm(1.43,0,1)-0.5
## 2) P(-2.87<Z<2.64)
pnorm(2.64,0,1)-pnorm(-2.87,0,1)
## 3) P(Z>=0.50)
pnorm(0.50,0,1,lower=F)
## 4) P(Z>=-0.45)
pnorm(-0.45,0,1,lower=F)
## 5) P(Z<-2.35)
pnorm(-2.35,0,1)
## 6) P(Z<2.35)
pnorm(2.35,0,1)
## 7) P(-1.96<=Z<=1.96)
pnorm(1.96,0,1)-pnorm(-1.96,0,1)
## 8) P(-2.58<=Z<=2.58)
pnorm(2.58,0,1)-pnorm(-2.58,0,1)
2*(pnorm(2.58,0,1)-0.5)
## 9) P(-1.65<=Z<=1.65)
pnorm(1.65,0,1)-pnorm(-1.65,0,1)

### 21. N(163,5^2)
## 1) 168 이상
pnorm(168,163,5,lower=F)
## 2) 158 미만
pnorm(158,163,5)
## 3) 158 초과 168 미만
pnorm(168,163,5)-pnorm(158,163,5)
## 4) 153 초과 173 미만
pnorm(173,163,5)-pnorm(153,163,5)

### 23. 평균 20, 분산 16
# 성공확률
1-16/20
# 시행횟수
20/0.2

### 24.
## 1)
qnorm(0.0094,100,15)
## 2)
qnorm(0.1093,100,15,lower=F)
## 3)
# pnorm(100,100,15) # 0.5
qnorm(0.5+0.4778,100,15)
## 4)
# 2*(pnorm(u+k,100,15)-0.5) = 0.9660
# pnorm(u+k,100,15) = 0.9660/2+0.5
# qnorm(0.9660/2+0.5,100,15) # u+k = 131.8011 (u=100)
qnorm(0.9660/2+0.5,100,15)-100