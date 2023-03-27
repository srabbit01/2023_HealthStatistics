### March 20 ###
# chap 5 examples

## EX.5.2.2.
# 모집단 크기 10, 평균 185.6, 표준편차 12.7
# 확률표본의 표준편차가 190 이상일 확률?
1-pnorm(190,185.6,12.7/sqrt(10))
# 확률분포 그래프
par(mfrow =c(2,1)) # 하나의 창에 세로 2개 가로 1개 그래프 그릴 것 지정
# curve(데이터,from=x축최소,to=x축최대,ylim=y축범위=c(최소,최대),main="제목")
curve(dnorm(x,mean =185.6,sd=12.7),from=150,to=223,ylim=c(0,0.1),
      main="distribution of the population")
curve(dnorm(x,mean =185.6,sd=12.7/sqrt(10)),from=150,to=223,ylim=c(0,0.1),
      main="distribution of the sample means of size=10")
# 분산을 모집단 크기의 제곱근으로 나누는 경우, 분산이 작아짐

## 두 집단의 평균 비교
## EX.5.3.2.
# 집단1: 평균 45, 표준편차 15
# 집단2: 평균 30, 표준편차 20
# 두 집단의 평균의 차이가 20 이상일 확률?

## 표본비율의 분포
## EX.5.3.2.
# 여성 중 51%만 산전관리
# 확률표본수 200인 경우, 산전관리 여성 비율 45% 이하일 확률?
# 가설검정 : 51%보다 작음

## 두 표본비율 간 차이의 분포
## EX.5.5.2.
# 75세 이상 성인의 34%(200명), 65~74세 성인의 26%(250명) 차이 존재
pnorm(-0.6956)-pnorm(-3.0143)
# 0.2420518 : 0.05 이상으로 두 집단이 차이가 없음 의미

## CLT Example
# sample(x,size,replace=T/F)
'''
- x : 독립변수
- size : 뽑을 데이터 개수 (default : sum(x))
- replace = True면 뽑았던 데이터 재추출, False면 재추출 없음 (반복)
> 만일 replace가 False인데, size > sum(x)이면 Error 발생
'''
x = 1:12
sample(x,30,replace=T)
x = c(0,1)
samp = sample(x,100,replace=T)
mean(samp) # 0.46
var(samp) # 0.2509091
hist(samp,xlim=c(0,1))
# rpois
rpop = rpois(10000,2) # 평균이 2가 되는 포아송분포 랜덤 생성
mean(rpop) # 1.9963
var(rpop) # 2.006687
# 포아송분포의 평균과 분산은 지정된 평균(2)와 비슷해야 함

clt.example<-function(sample.size){
  sapply(1:1000,function(y){mean(sample(population,sample.size,replace =T))}
}
population<-rpois(10000,2)
hist (clt.example(1))
hist (clt.example(5))
hist (clt.example(10)
hist (clt.example(15))
hist (clt.example(25))
hist (clt.example(50))