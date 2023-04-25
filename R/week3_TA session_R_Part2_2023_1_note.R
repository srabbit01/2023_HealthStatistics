###########################
##### Data management #####
###########################

### Arithmetic Operators : 산술 연산자
a <- c(3,5)
a

# + addition; - subtraction; * multiplication; / division 
'''
+ : 더하기
- : 빼기
* : 곱하기
/ : 나누기
'''
a[1]+a[2] 	

#^ or ** exponentiation 
'''
a**b 또는 a^b : a의 b승
'''
a[1]^2
a[1]**2

#x %% y modulus (x mod y)
'''
%% : 나머지
%/% : 몫
'''
a[2] %% a[1] 
24%%9 
9%%24 

#x %/% y integer division  
a[2] %/% a[1] 
24%/%9 
9%/%24 


###Logical Operators : 논리 연산자
'''
< 또는 > : 크고 작음
<= 또는 >= : 크거나 같음 혹은 작거나 같음
== : 동일
!= : 다름
! : not(아님)
| : or(또는)
& : and(그리고)
# 맞으면 TRUE 틀리면 FALSE 출력
'''
a

#< less than       
a<2 		

#<= less than or equal to 
a<=2		

#> greater than          
a>2		

#>= greater than or equal to 
a>=2		

#== equal to 
a==2		

#!= not equal to 
a!=2		

#!x  (Not x) 
!a>4		

#x | y (x OR y) 
a[1]<5 | a[2]<5	

#x & y (x AND y) 
a[1]<5 & a[2]<5	

# to import data
malaria <-read.table("C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/malaria.csv",header=TRUE,sep=",")
'''
header : 첫 행 열이름이면 TRUE 데이터면 FALSE
sep : 분리된 상태
'''
head(malaria) # 첫 5개의 행 출력
dim(malaria) # 차원 : 행 열 개수 출력
summary(malaria) # 각 행의 최소, 1사분면, 중위수, 평균, 3사분면, 최대 확인
'''
    subject            age              ab              mal      
 Min.   :  1.00   Min.   : 3.00   Min.   :   2.0   Min.   :0.00  
 1st Qu.: 25.75   1st Qu.: 5.75   1st Qu.:  29.0   1st Qu.:0.00  
 Median : 50.50   Median : 9.00   Median : 111.0   Median :0.00  
 Mean   : 50.50   Mean   : 9.79   Mean   : 311.5   Mean   :0.27  
 3rd Qu.: 75.25   3rd Qu.:12.00   3rd Qu.: 373.8   3rd Qu.:1.00  
 Max.   :100.00   Max.   :99.00   Max.   :2066.0   Max.   :1.00 
'''

### to create new variables : 새로운 변수 만들기
#1.
'''
데이터셋명$새로운변수(열)명 = 연산데이터 (연산자 활용)
'''
malaria$diff <- malaria$ab - malaria$age
head(malaria)

#2. 'ifelse'
'''
ifelse(조건,True결과,False결과)
'''
# 7세 초과 student, 7세 이하 baby
malaria$agecat <- ifelse(malaria$age >7, "student", "baby")
head(malaria)

#3. [condition] : 조건 설정
'''
데이터셋명$새로운변수(열)명[조건] = "True결과"
'''
malaria$agecat2[malaria$age > 7] <- "student"
malaria$agecat2[malaria$age <= 7] <- "baby"
head(malaria)

#4. 'if'-'else' : 조건문
sbp <- 126

'''
if(조건1){
  조건1True결과
} else if(조건2){
  조건2True결과
} else if(조건3){
  조건3True결과
} else{
  위모든조건False결과
}
# 위에서 내려오는 과정에서 하나라도 만족되면 break
# if > False > else if > False > ... > False > else > 결과
# else는 모든 if문의 조건이 False인 경우에만 실행
'''
if (sbp>=140) {
  category <- "High Blood Pressure Stage 1"
}

if (sbp>=140) {
  category <- "High Blood Pressure Stage 2"
} else if (sbp>=130) {
  category <- "High Blood Pressure Stage 1"
} else if (sbp>=120) {
  category <- "Elevated Blood Pressure"
} else {
  category <- "Normal Blood Pressure"
}
category

'''
# 변수 입력의 경우, 새로운변수 = if(조건){}...으로 하면 코드 짧게 가능
'''
category <- if (sbp>=140) {
  "High Blood Pressure Stage 2"
} else if (sbp>=130) {
  "High Blood Pressure Stage 1"
} else if (sbp>=120) {
  "Elevated Blood Pressure"
} else {
  "Normal Blood Pressure"
}
category


### to sort data : 배열
# sort by mal : 1개의 열 기준 배열
'''
order(데이터셋명$열)
'''
head(malaria,10) # malaria 10개 출력 
# malaria 데이터셋의 mal열 오름차순 배열 후, 새로운 변수 생성
newdata <- malaria[order(malaria$mal),]
head(newdata, 10)
newdata2 <- malaria[order(malaria$age),]
head(newdata2,10)

# sort by mal and age : 2개 이상 열 기준 배열
'''
order(데이터셋명$열1,데이터셋명2$열2,...)
# 열1 기준 정렬 후, 열1이 동일한 데이터에 대해 열2 기준 정렬
'''
newdata2 <- malaria[order(malaria$mal, malaria$age),]
head(newdata2, 10)

#sort by mal (ascending) and age (descending) : 오름차순/내림차순 정렬
'''
order(데이터셋명$열) : 오름차순 정렬
order(-데이터셋명$열) : 내림차순 정렬
'''
newdata3 <- malaria[order(malaria$mal, -malaria$age),] 
head(newdata3, 10)


###Merging data
#Raw dataset
malaria <-read.table("C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/malaria.csv", header=TRUE, sep=",")
head(malaria)
tail(malaria)
dim(malaria)

#Adding rows : 행 단위(세로) 붙이기
extra<-read.table("C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/extra15.csv", header=TRUE, sep=",")
head(extra)
tail(extra)
dim(extra) # 15 4
'''
rbind(데이터셋1,데이터셋2) : 두 데이터셋 세로 붙이기(행 단위 붙이기)
'''
malaria_binded<-rbind(malaria, extra) 
head(malaria_binded, 20)
tail(malaria_binded, 20)
dim(malaria_binded) # 115 4

#Adding columns by matching : 열 단위(가로) 붙이기 (특정 열 기준)
region<-read.table("C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/region.csv", header=TRUE, sep=",")
region<-read.table("C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/region.csv", header=TRUE, sep=",", fileEncoding="CP949", encoding="UTF-8")
'''
# 파일이 인코딩된 포맷
fileEncoding="" 
encoding=""
'''
head(region)
dim(region)
'''
merge(데이터셋1,데이터셋2,by="기준열") : 두 데이터셋 가로 붙이기 (열 단위 붙이기)
# 기준이 되는 열이 있어야 함 > 일반적 붙이기 X
# 즉, 데이터셋1과 데이터셋2에는 동일한 열이 존재해야 함
'''
malaria_binded2<-merge(malaria_binded, region, by="subject")
head(malaria_binded2, 20) 
dim(malaria_binded2)


###Subsetting : 특정 조건 기준을 만족하는 행만 추출
'''
subset(데이터셋,조건)
'''
mal.1 <- subset(malaria, mal==1)
head(mal.1)
dim(mal.1)
summary(mal.1)

mal.baby <- subset(malaria, mal == 1 & age < 8) 
head(mal.baby)
dim(mal.baby)
summary(mal.baby)


##############################################
##### derscriptive statistics using R  #######
##############################################
'''
특정 데이터셋에 대한 통계량 제공
1) 중심(평균,중위수,최빈값)
2) 산포(분산,표준편차)
3) 최솟값, 최댓값, 왜도, 첨도 등
'''

#to import data
data1 <- read.table("C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/data2010.csv", header=TRUE, sep=",")
names(data1)
dim(data1)
head(data1)
tail(data1)
summary(data1)


## statistical functions
x <- data1$meanpm10 # 특정 열을 새로운 변수에 저장
x
'''
# 1) 평균 : mean(데이터셋,na.rm=T/F,trim=n/100)
- na.rm : TRUE면 NA(결측치) 제거 후 계산, FALSE면 NA 제거하지 않음
# 만일 결측치를 제거하지 않고 계산하면, 존재하는 경우 NA 출력
- trim : 양 끝 n% 데이터 제외 (극단치 제거 목적)
- 만일, 계산 결과의 소숫점 이하 개수 지정하기 위해 반올림 함수 사용
# 반올림 : round(데이터셋,소숫점이하수)
# 2) 중위수 : median(데이터셋,na.rm=T/F)
# 3) 분산 : sd(데이터셋,na.rm=T/F)
# 4) 분위수 : quantile(데이터셋,na.rm=T/F,probs=c(a%,b%,c%,...)/100)
- probs : 확인할 퍼센트% 설정
# 5) 합 : sum(데이터셋)
# 6) 범위 : range(데이터셋,na.rm=T/F)
# 7) 최솟값: min(데이터셋,na.rm=T/F)
# 8) 최댓값 : max(데이터셋,na.rm=T/F)
# 9) summary(데이터셋) : 각 열 별 최소, 1분위수(25%), 중위수, 평균, 3분위수(75%), 최대, 결측치수 
'''
mean(x)
mean(x, na.rm=TRUE)
mean(x, trim=.10, na.rm=T) #Trimmed Mean
round(mean(x, na.rm=T),2)
sd(x, na.rm=TRUE) 
median(x, na.rm=T) 
quantile(x, na.rm=T) 
quantile(x, probs = c(0.1, 0.5, 1, 2, 5, 10, 50)/100, na.rm=T) 
range(x, na.rm=T) 
sum(x, na.rm=T) 
min(x, na.rm=T) 
max(x, na.rm=T) 
summary(x)

######################################

#numeric : 숫자형
summary(data1$meanpm10)
summary(data1$season)
#factor : 요인형
data1$season_f <- as.factor(data1$season) # 'factor' : 숫자형 > 요인형 변환
summary(data1[, c("season","season_f")]) # season_f : 요인 별 어떤 값을 담았는지 나옴
'''
table(데이터셋$요인형열) : 각 요인 별 빈도수 확인
'''
table(data1$yy) #frequency table even for numeric variables

x <- data1$meanpm10
sd(x, na.rm=T)
'''
반복 데이터 생성 : seq(시작,끝,by=단계)
제외 : cut(데이터셋,기준구간,right=T/F)
- right : TRUE면 오른쪽 값 포함 = (], FALSE면 오른쪽 값 포함하지 않음 = [)
dataframe 자료형 변환 : data.frame(데이터셋)
'''
breaks <- seq(0, 240, by=50) 
breaks.cut1 <- cut(x, breaks, right=FALSE) ##0-49,50-99,100-149,150-199
breaks.cut1 # Levels: [0,50) [50,100) [100,150) [150,200)
breaks.cut2 <- cut(x, breaks, right=T)
breaks.cut2 # Levels: (0,50] (50,100] (100,150] (150,200]
freq <- table(breaks.cut)
freq
freq1 <- data.frame(freq)
freq1
freq1$percent <- round(freq1$Freq/sum(freq1$Freq)*100, 2) # 소숫점 둘째자리까지 제한
freq1$cum_per <- round(cumsum(freq1$percent), 2)
freq1


###implicit loops : 반복
data1 <- read.table("C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/data2010.csv", header=TRUE, sep=",")

'''
lapply(데이터셋,함수명,na.rm=T/F) : 특정 함수에 적용 후 리스트 자료형으로 반환
sapply(데이터셋,함수명,na.rm=T/F) : 특정 함수에 적용 후 벡터 자료형으로 반환
tapply(데이터셋$계산열,데이터셋$기준열,함수명) : 특정 함수에 적용 후 테이블 자료형으로 반환
> 특정 열을 기준으로 계산 열에 대한 함수 적용
'''

#returns a list
lapply(data1[, c("meantemp","meanpm10","meanso2")], mean, na.rm=T)
'''
$meantemp
[1] 13.65699

$meanpm10
[1] 55.83057

$meanso2
[1] 5.873787
'''

#returns a vector
sapply(data1[, c("meantemp","meanpm10","meanso2")], mean, na.rm=T) 
'''
 meantemp  meanpm10   meanso2 
13.656987 55.830574  5.873787 
'''

#returns a table
tapply(data1$meantemp, data1$season, median) #create a table 
'''
     1      2      3      4 
13.315 24.300 16.230  1.920 
'''
median(data1[data1$season==1,"meantemp"], na.rm=T)

###Testing for Missing Values
'''
is.na(데이터셋) : 데이터셋이 결측치(NA)인지 여부 > TRUE면 결측치 FALSE면 아님
which(is.na(데이터셋)) : 결측치(NA)를 가진 열만 출력
table(is.na(데이터셋)) : 결측치 및 결측치 아닌 개수 모두 출력
sum(is.na(데이터셋)) : 결측치의 개수만 출력
'''
is.na(data1$meanpm10)[1:500] # returns TRUE if x is missing
'''
  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [17] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
'''
which(is.na(data1$meanpm10)) 
'''
  [1]   829  3228  3229  3230  3231  3232  3233  3234  3235  3236  3237  3238  3239  3240  3241  3242
 [17]  3243  3244  3245  3246  3247  3248  3249  3250  3251  3252  3253  3254  3255  3256  3257  3897
'''
table(is.na(data1$meanpm10))
'''
FALSE  TRUE 
17358   204 
'''
sum(is.na(data1$meanpm10)) # 204

#function : 사용자 정의 함수
'''
function(변수1,...) 계산함수(변수1,...))
'''
n_na <- sapply(data1[, c("meantemp","meanpm10","meanso2")], function(x) sum(is.na(x))); n_na
n <- sapply(data1[, c("meantemp","meanpm10","meanso2")], function(x) length(x)); n
a <- rbind(n_na,n); a
'''
t(데이터셋) : 행과 열 변환 > 행은 열, 열은 행으로 바꾸기
'''
na_table <- t(a); na_table

###Practice
v_mean <- round(sapply(data1[, c("nonacc","meantemp","meanno2")], mean, na.rm=T), 2); v_mean
v_sd <- round(sapply(data1[, c("nonacc","meantemp","meanno2")], sd, na.rm=T),2); v_sd
v_percentile <- sapply(data1[, c("nonacc","meantemp","meanno2")], quantile, na.rm=T); v_percentile
v_n_na <- sapply(data1[, c("nonacc","meantemp","meanno2")], function(x) sum(is.na(x))); v_n_na
#to combine results
ds <- rbind(v_mean, v_sd, v_percentile, v_n_na); ds
#to export results : 결과 csv 파일로 저장
'''
write.table(데이터셋,경로,row.names=T/F,sep="")
- row.names : TRUE면 행 이름 저장, FALSE면 저장하지 않음
'''
write.table(ds, "C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/result1.csv", row.names=F, sep=',')
write.table(ds, "C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/result2.csv", row.names=T, sep=',')

### histogram : 히스토그램
'''
par(mfrow=c(행수,열수)) : 행/열 개수만큼 창에 위치 확보
hist(데이터셋,breaks=,density=,freq=)
- breaks : 계급의 개수
- density : 그래프 흐린 정도 (클 수록 흐림)
- freq : TRUE면 관측값, FALSE면 확률밀도로 출력
'''
par(mfrow=c(2,2)) #split the screen in several panels
hist(data1$meanpm10) 
hist(data1$meanpm10, breaks=5)  
hist(data1$meanpm10, breaks=20, density=15) 
hist(data1$meanpm10, freq=FALSE)
par(mfrow=c(1,1))

### Stem and leaf plot : 줄기-잎 그림
'''
stem(데이터셋) : 줄기-잎 그림
'''
malaria$age
stem(malaria$age)
'''
  The decimal point is 1 digit(s) to the right of the |

줄기| 잎
  0 | 3333333344444444455555555666667777777788888889999999999
  1 | 00000000011111112222223333333444444455555555
  2 | 
  3 | 
  4 | 
  5 | 
  6 | 
  7 | 
  8 | 
  9 | 9
- 줄기 : 10의 자리 숫자
- 잎 : 1의 자리 숫자
# 이를 이용하여 각 줄기(10의 자리 숫자)의 개수(빈도) 확인 가능
'''


### bar chart : 막대 그래프
win.graph() # 그래프 출력 창 새로 생성
counts <- table(data1$influenza); counts
'''
barplot(데이터셋,main="제목",horiz=T/F,names.arg=c("계급이름1","계급이름2",...))
- horiz : TRUE면 가로 막대 그래프, FASLE면 세로 막대 그래프 (default=FALSE)
- names.arg=c(계급이름1,계급이름2,...)
'''
barplot(counts, main="Influenza epidemics", horiz=TRUE,
        names.arg=c("0 Non-epidemic", "1 Epidemic"))
dev.off() # 열린 창 닫기

### boxplot : 박스 그래프
win.graph()
'''
boxplot(y축열~x축열,data=데이터셋,main="제목",xlab="x축이름",ylab="y축이름") 
'''
boxplot(nonacc~dow, data=data1, main="Mortality vs weekday", 
        xlab="Day of week", ylab="Total mortality") 
dev.off()

### Simple Scatterplot : 산점도
win.graph()
'''
plot(데이터셋$x축열,데이터셋$y축열,main= "제목") 
# 직선 추가
abline(lm(데이터셋$y축명~데이터셋$x축명),col=색상번호)
# 
lines(lowess(데이터셋$y축명~데이터셋$x축명),col=색상번호)
- lowess : 변곡점 > 구간 별로 쪼개어 직선을 그은 후, 부드럽게 그은 선
'''
plot(data1$meantemp, data1$nonacc,
     main= "Regression of mortality on Temperature") 
abline(lm(data1$nonacc~data1$meantemp), col=2) # regression line (y~x)
lines(lowess(data1$nonacc~data1$meantemp), col=5) # lowess line (x,y)
dev.off()

### Basic Scatterplot Matrix
'''
pairs(y축명~x축명1+x축명2+...,data=데이터셋,main="제목")
'''
win.graph()
pairs(~ nonacc+meantemp+meanpm10+meanno2+meanco+maxco+maxo3, data=data1, 
      main="Simple Scatterplot Matrix")
dev.off()
