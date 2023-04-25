### April 10 ###
# chap 7 examples

## 7.7 가장 중요 ##

## EX.7.9.1.
m0=17.5; m1=16.5; n=100; s=3.6
power.cal<-function(m0,m1,n,s){
  1-(pnorm(1.96+(m0-m1)/s*sqrt(n))-pnorm(-1.96+(m0-m1)/s*sqrt(n)))
}
m1=seq(16,19,0.1)
power.cal(17.5,16.5,100,3.6)
# sample size가 크면 power 증가
# power : 실험에서 목적을 달성할 확률 > 보통 80-90%가 목표
plot(m1,power.cal(17.5,16.5,100,3.6),xlab=expression(mu),ylab=expression(1-beta),type="l")
# sample size를 바꾸면서 power가 얼마나 커지는지 확인 필요
# sample size 늘리기
n=seq(10,200,10)
p=power.cal(17.5,16.5,n,3.6)
plot(n,p,xlab=expression(mu),ylab=expression(1-beta),type="l")
'''
결정
- 임계값 : alpha/2
- H0 : 비기각역(채택역)
- HA : 기각역
'''