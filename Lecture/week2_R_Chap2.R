### March 13 ###
# chap 2 examples

# sequence: 1부터 5까지 변수 x에 넣기
x = 1:5 # = seq(1,5)
'''
seq(시작,끝,단계) : 반복되는 연속 숫자 지정
- 단계 : 시작+단계, ~, 끝-단계, 끝
'''
sum(x) # 모든 값들의 합
length(x) # 길이 : 값의 개수
mean(x) # 평균 : 3 = sum(x)/length(x)
median(x) # 중위수 : 3
var(x) # 분산
'''
# variance(분산)
var(x) = sum((x-meam(x))^2)/(length(x)-1)
'''

x1 = c(x,50)
x1
length(x1) # 길이
mean(x1) # 평균 : 10.83
median(x1) # 중위수 : 3.5

x2 = c(x1,5000)
mean(x2) # 723.57
median(x2) # 4
# 보통 평균은 이상치에 영향을 많이 받으나, 중위수는 영향이 적음

## Exercise 2.4.2, file name=e242.R
age <- c(34,30,35,31,33,33,29,37,36,39)
sort(age)
table(age)
hist(age) # 히스토그램 그리기
0.6*33+0.4*33
summary(age)
# 백분위수 구하기
apropos("quan") # quan으로 시작하는 함수 묻기
?quantile # quantile 함수 무엇인지 묻기
# 전체 중 40% 백분위에 해당하는 값
quantile(age,.40) # quantile(변수,백분위수/100)

n <-length(age)
n
p <-0.40
r = floor((n+1)*p) ; b = (n+1)*p
p-r
r;b
(1 -b)*sort(age)[r]+b*sort(age)[r+1] # 백분위수 계산하는 방법(식)
