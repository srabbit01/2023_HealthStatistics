# Chap10 과제

### 7.
X=c(18,13,18,15,10,12,8,4,7,3)
Y=c(23,20,18,16,14,11,10,7,6,4)
n=length(X)
data=data.frame(X,Y)
## 1) 상관계수
cor(X,Y)
## 2) 유의성 검정
cor.test(data$X,data$Y)
# 결과적으로  p-value=0.0002372<유의수준=0.05이므로 기각역 포함
# 즉, 영가설 기각 = 모상관계수는 0


### 8.
eat=c(180,200,230,410,600,550,275,580,105,250,460,650)
Ag=c(90,120,125,290,310,290,170,375,70,105,205,480)
n=length(eat)
fish=data.frame(eat,Ag)
## 1) 회귀방정식 및 결정계수
fi_reg=lm(Ag~eat,fish); fi_reg
summary(fi_reg)
## 2) 상과계수
cor(fish)
## 3) 유의성 검정
cor.test(fish$eat,fish$Ag) # p-value=5.66e-06


### 9.
xi=82500
yi2=871
xi2=523750000
xiyi=510500
yi=107; n=100
# 회귀계수가 알려지지 않았기 때문에
## 1) 상관계수
r=(n*xiyi-xi*yi)/sqrt((n*xi2-(xi^2))*(n*yi2-(yi^2))); r
## 2) 유의성 검정
r_square=r^2
# 검정통계량
t=r*sqrt((n-2)/(1-r_square)); t # 10.24482
# 결정계수
qt(0.975,n-2) # 1.984467
# 결과적으로 검정통계량(t)=10.244822>결정계수=1.984467이므로 기각역 포함
# 즉, 영가설 기각 = 모상관계수는 0
## 3) p-vaule
pt(t,n-2,lower.tail=F)*2 # 3.562841e-17
## 4) 95% 신뢰구간
zr=1/2*log((1+r)/(1-r)); zr
# 하한값
LCI=zr-qnorm(0.975)*1/sqrt(n-3)
(exp(2*LCI)-1)/(exp(2*LCI)+1)
# 상한값
HCI=zr+qnorm(0.975)*1/sqrt(n-3)
(exp(2*HCI)-1)/(exp(2*HCI)+1)

### 10.
Y=c(115,86,19,6,23,147,27,140,345,92,85,24,185,30,9,76,51,73,47,48,16)
X1=c(0.38,1.65,0.16,0.08,0.02,1.98,0.15,0.25,0.55,0.22,0.09,0.17,0.28,0.19,0.03,0.21,0.09,0.06,0.08,0.12,0.03)
X2=c(899,167,73,146,82,2483,404,2438,780,517,346,82,2932,658,103,2339,31,158,773,545,5)
X3=c(56,158,152,35,60,1993,30,72,12,5,5,12,108,33,5,5,36,5,5,67,5)
data=data.frame(Y,X1,X2,X3)
## 1) 단순상관계수
cor(data)
## 2) 단순상관계수 유의성 검정
cor.test(data$Y,data$X1)$p.value
cor.test(data$Y,data$X2)$p.value
cor.test(data$Y,data$X3)$p.value
cor.test(data$X1,data$X2)$p.value
cor.test(data$X1,data$X3)$p.value
cor.test(data$X2,data$X3)$p.value
library("Hmisc")
rcorr(as.matrix(data))$P
## 3) 다중상관계수
reg=lm(Y~X1+X2+X3,data)
sqrt(summary(reg)$r.sq)
## 4) 다중상관계수 유의성 검정
anova(lm(Y~1,data),reg)
## 5)
'''
library("ppcor")
pcor(data)$estimate
'''