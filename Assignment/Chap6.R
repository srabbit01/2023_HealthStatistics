# Chap6 과제

### 13. n=150, 30% 진드기 알레르기 양성
# 모비율 95% 신뢰구간?
n=150
pos=150*0.3
# 모비율 추정량
ratio=pos/n # 0.3
# 표준오차
err=sqrt(ratio*(1-ratio)/n) # 0.03741657
# 하한값
ratio-1.96*err # 0.2266635
# 상한값
ratio+1.96*err # 0.3733365

### 14. n=80, 위험등급=25
# 위험등급 모비율 95% 신뢰구간?
n=80
risk=25
# 모비율 추정량
ratio=risk/n # 0.3125
# 표준오차
err=sqrt(ratio*(1-ratio)/n) # 0.05182226
# 하한값
ratio-1.96*err # 0.2109284
# 상한값
ratio+1.96*err # 0.4140716

### 15. 14번 이어서, 95% 신뢰구간 길이가 0.05 이하가 되기 위한 최소 표본 크기?
d=0.05 # 95% 신뢰구간 폭(Cl) = 0.05
n=(qnorm(0.975)**2)*ratio*(1-ratio)/(0.05**2)
n # 330.1254  = 331개

### 16. n=500, 210 남 중 42 건강검진 목적, 290 여 중 140 건강검진 목적
# 두 모비율 차 95% 신뢰구간?
nm=210
nw=290
pm=42/210 # 0.2
pw=140/290 # 0.4827586
# 모비율 차 추정량
wMm=pw-pm # 0.2827586
# 표준오차
err=sqrt((pm)*(1-pm)/nm+(pw)*(1-pw)/nw) # 0.04028584
# 하한값
wMm-1.96*err # 0.2037984
# 상한값
wMm+1.96*err # 0.361718

### 18. n=200, 180명 신약 먹은 후 증상 호전
# 모비율의 90% 신뢰구간?
n=200
pos=180
# 모비율 추정량
ratio=pos/n # 0.9
# 표준오차
err=sqrt(ratio*(1-ratio)/n) # 0.0212132
# 하한값
ratio-1.645*err # 0.8651043
# 상한값
ratio+1.645*err # 0.9348957

### 20. n=10, 모집단 정규분포 따른 가정
weight=c(20.5,24.8,21.3,22.7,18.2,31.6,25.4,21.9,19.7,22.2)
# 모평균의 95% 신뢰구간?
mw=mean(weight) # 22.83
# 표준오차
err=sd(weight)/sqrt(length(weight)) # 1.191083
# 하한값
mw-qt(0.975,10-1)*err # 20.13558
# 상한값
mw+qt(0.975,10-1)*err # 25.52442

### 21. 2개의 독립 표본 추출
a=c(7.04,7.12,7.51,7.88,7.25,7.26,7.85,7.14,7.96,7.57,7.92,7.37,7.66,7.62,7.65)
b=c(7.16,7.05,7.09,7.31,7.14,7.25,7.32,7.47,7.74,7.10,7.35,7.19)
# 등분산 가정, 두 모평균 차에 대한 90% 신뢰구간?
ma=mean(a) # 7.52
mb=mean(b) # 7.264167
# 모평균 차 추정량
aMb=ma-mb # 0.2558333
## 모분산 동일 = 합동추정량
s1=sd(a)
s2=sd(b)
sp2=((length(a)-1)*(s1**2)+(length(b)-1)*(s2**2))/(length(a)+length(b)-2) # 0.07021967
# 표준오차
err=sqrt(sp2/length(a)+sp2/length(b)) # 0.1026302
# 하한값
aMb-qt(0.95,length(a)+length(b)-2)*err # 0.08052657
# 상한값
aMb+qt(0.95,length(a)+length(b)-2)*err # 0.4311401

### 22.
a=c(4.0,5.2,4.2,5.9,16.8,3.5,3.0,6.4,6.8,3.6,6.9,5.7)
b=c(5.0,11.2,11.6,3.5,5.3,3.5,6.2,6.6,7.1,6.4,4.5,5.1,3.2,4.7,4.5,3.0)
# 등분산 가정, 두 모평균 차에 대한 95% 신뢰구간?
ma=mean(a)
mb=mean(b)
# 모평균 차 추정량
aMb=ma-mb
## 모분산 동일 = 합동추정량
s1=sd(a)
s2=sd(b)
sp2=((length(a)-1)*(s1**2)+(length(b)-1)*(s2**2))/(length(a)+length(b)-2)
# 표준오차
err=sqrt(sp2/length(a)+sp2/length(b))
# 하한값
aMb-qt(0.975,length(a)+length(b)-2)*err # -2.11679
# 상한값
aMb+qt(0.975,length(a)+length(b)-2)*err # 2.69179

### 23.신뢰구간을 구할 때 높은 신뢰계수 선호, 신뢰계수가 100%인 경우 신뢰구간 폭?
# 신뢰구간 = 추정량(+-)신뢰성계수*표준오차
# 추정량 혹은 표준오차는 주어진 표본 혹은 모 집단에서 구하는 것
qnorm(1+(1-1)/2) # 신뢰성계수 무한대
# 따라서 신뢰구간의 폭은 (-무한대,무한대)로 모든 추정량이 신뢰구간에 포함
# 너무 넓은 범위가 신뢰구간에 포함 > 신뢰성 낮을 수도...

### 24.
# chickwts
cw=chickwts$weight
cf=chickwts$feed
# weight 변수의 95% 신뢰구간?
mw=mean(cw)
# 표준오차
err=sd(cw)/sqrt(length(cw))
# 하한값
mw-qt(0.975,length(cw)-1)*err # 242.8301
# 상한값
mw+qt(0.975,length(cw)-1)*err # 279.7896

### 25.
# 두 모평균 차에 대한 95% 신뢰구간?
hb=chickwts[chickwts$feed=="horsebean",] # horsebean
ls=chickwts[chickwts$feed=="linseed",] # linseed
# feed 변수 별 weight
hbw=hb$weight
lsw=ls$weight
# 두 모분산 정규분포 가정
hbm=mean(hbw) # 160.2
lsm=mean(lsw) # 218.75
# 모평균 차 추정량
lMh=lsm-hbm # 58.55
## 1) 모분산 동일 = 합동추정량
s1=sd(hbw)
s2=sd(lsw)
sp2=((length(hbw)-1)*(s1**2)+(length(lsw)-1)*(s2**2))/(length(hbw)+length(lsw)-2)
# 표준오차
err=sqrt(sp2/length(hbw)+sp2/length(lsw))
# 하한값
lMh-qt(0.975,length(hbw)+length(lsw)-2)*err # 16.92382
# 상한값
lMh+qt(0.975,length(hbw)+length(lsw)-2)*err # 100.1762
## 2) 모분산 다름 = t'-분포
t1=qt(0.975,length(hbw)-1)
t2=qt(0.975,length(lsw)-1)
tp=((s1**2/length(hbw))*t1+(s2**2/length(lsw))*t2)/((s1**2/length(hbw))+(s2**2/length(lsw)))
# 표준오차
err=sqrt(var(hbw)/length(hbw)+var(lsw)/length(lsw))
# 하한값
lMh-tp*err # 15.36832
# 상한값
lMh+tp*err # 101.7317

