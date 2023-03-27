# Chap2 과제

# Load birth.csv
birth = read.csv('C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/birth.csv',header=T)
head(birth)

### 7.
mean(birth$bweight) # 평균 : 3136.884
median(birth$bweight) # 중앙값 : 3188.5
names(which.max(table(birth$bweight))) # 최빈값 : 3184
sd(birth$bweight) # 표준편차 : 637.4515
var(birth$bweight) # 분산 : 406344.4


### 8.
# 계급 개수 결정
k = 1+(3.222*log10(length(birth$bweight)))
k # 9.696081 > 계급 개수 : 10개
# 도수분포
bweight_cut = cut(birth$bweight,breaks= 10) 
table(bweight_cut)
# 상대도수분포
prop.table(table(bweight_cut))
# 히스토그램
hist(birth$bweight,main="bweight Hist")
# 도수다각형
hist(birth$bweight,probability=T,main="bweight Hist")
lines(density(birth$bweight),col="red")

### 9.
## 1)
Mbw = birth$bweight[birth$sex==1]
mean(Mbw) # 평균
median(Mbw) # 중앙값
sd(Mbw) # 표준편차
var(Mbw) # 분산
## 2)
Wbw = birth$bweight[birth$sex==2]
mean(Wbw) # 평균
median(Wbw) # 중앙값
sd(Wbw) # 표준편차
var(Wbw) # 분산
## 3)
boxplot(Mbw)
## 4)
boxplot(Wbw)


### 10.
## 1)
stem(birth$bweight,scale=2)
## 2)
min(birth$bweight)
max(birth$bweight)
## 3)
mean(birth$bweight) # 평균
median(birth$bweight) # 중앙값
sd(birth$bweight) # 표준편차
var(birth$bweight) # 분산

### 11.
# 누적도수분포
cumsum(table(bweight_cut))
# 상대도수분포
prop.table(table(bweight_cut))
# 누적상대도수분포
cumsum(prop.table(table(bweight_cut)))

## 14.
1+(3.222*log10(274-50+1)) # 8.57
1+(3.222*log10(249-50+1)) # 8.41
1+(3.222*log10(250-50+1)) # 8.42

### 18
mean(birth$matage) # 평균
median(birth$matage) # 중앙값
names(which.max(table(birth$matage))) # 최빈값
