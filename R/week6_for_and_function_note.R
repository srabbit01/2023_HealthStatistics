# rm(list = ls()); gc()
## Removing the entire environment and activating garbage collector to clear the memory

setwd('C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/pm25') # Set your own working directory!!
getwd()

list.files() # 폴더 내 파일 이름들 확인 : character 형태의 벡터
list.files()[1]

data = read.csv(list.files()[1])
# data.table::fread : 빨리 불어오기
summary(data)
rm(data) # 변수/데이터 지우기

# 반복문 : for loop
'''
for(i in 반복변수){
  반복결과
}
'''

data = data.frame() # data란 변수에 빈 data.frame 생성
for(i in 1:length(list.files())) {
  sub = read.csv(list.files()[i])
  data = rbind(data,sub) # data 세로 단위 아래로 붙이기
  rm(sub)
  print(i)
}
summary(data)
head(data); tail(data)
# 반복문으로 'apply' 함수도 사용 가능 > 매우 조금 더 빠름
'''
# 병렬현상을 이용하여 반복문 실행 > "foreach" 사용
'''
# 반복문 내 반복문 : Nested for loop
'''
for(i in 반복변수){
  결과1
  for(k in 반복변수){
    결과2
  }
}
'''

# 사용자 정의 함수 : 사용자가 함수를 직접 지정하는 것
'''
함수명=function(내부변수1,내부변수2,...){
  함수내용
  return(출력값)
}
함수명(변수1,변수2,...)
> 지정된 변수를 모두 입력해야 출력됨 > 만일 모두 지정하지 않으면 Error 발생
'''
readall = function(x) {
  setwd(x)
  data = data.frame()
  for(i in 1:length(list.files())) {
    sub = read.csv(list.files()[i])
    data = rbind(data,sub)
    rm(sub)
  }
  return(data) # 함수 결과 무엇을 출력할지 지정
}

x = getwd()
data2 = readall(x)
summary(data2)

# 사용자 정의 함수 저장
# save(readall,file = '../Code/readall.R')
# readall=load('.../Code/readall.R')