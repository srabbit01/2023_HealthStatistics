###########################
######## Data input #######
###########################

#### Vectors(1차원,벡터)
#numeric vector
a <- c(1, 2, 5.3, 6, -2,4)

#character vector
b <- c("one", "two", "three")

#logical vector
c <- c(TRUE, TRUE, TRUE, FALSE, TRUE, FALSE)
# class(변수) : 특정 변수의 class 확인
class(c)

#[ ]: index for the vector
a[c(2,4)] #2nd and 4th elements of vector

#### Factors
gender <- c(rep("male",20), rep("female", 30))
# rep("문자",n개) : 특정 "문자" n번 반복
gender <- factor(gender)

# R now treats gender as a nominal variable 
summary(gender) # male과 female의 개수 확인 가능


### Matrices(2차원,행렬)
# 2차원 구조이나, 반드시 모든 class 동일해야 함
# generates 5 x 4 numeric matrix 
y<-matrix(1:20, nrow=5,ncol=4)
# nrow=행개수, ncol=열개수
dim(y) # 행렬개수 확인
## 지정된 행/렬만 추출
y[,4] # 4th column of matrix > 행렬의 4번째 열만 추출
y[3,] # 3rd row of matrix > 행렬의 3번째 행만 추출
y[2:4, 1:3] # rows 2,3,4 of columns 1,2,3

z1 <- 1:3
z2 <- 10:12
cbind(z1, z2) #column-binding : 두 변수를 열로 묶기
rbind(z1, z2) #row-binding : 두 변수를 행으로 묶기


### Data Frames(2차원)
# 2차원 구조이나, 값들의 class가 달라도 됨
# 열 단위로 묶임
d <- c(1, 2, 3, 4) # Numeric Value
e <- c("red", "white", "red", NA) # NA : 결측치
f <- c(TRUE, TRUE, TRUE, FALSE) # Logical Value
mydata <- data.frame(d, e, f)
#assign variable names : 열 이름 지정
# names(변수)=c("변수명","변수명","변수명")
names(mydata) <- c("ID", "Color", "Passed")
rownames(mydata)
colnames(mydata)


### Array(3차원,배열)
b<-array(1:30,dim=c(2,5,3)) # dim=c(행,열,차원)
class(b)


### Lists
# example of a list with 4 components - 
# a string, a numeric vector, a matrix, and a scalar 
# list(차원명=차원변수,...)
w <- list(name="Fred", numbers=a, matrix=y, age=5.3)
w$name # 특정 차원의 행렬만 추출


### Importing data
# From CSV file
# 주의 : 경로의 경우 '\'로 되어 있으면 읽어드릴 수 없기에 '/'로 바꾸기
malaria <-read.table("C:/work/Crystal/2023(석1)/1학기/보건통계학개론/실습/malaria.csv",
                     header=TRUE, sep=",")
# header : 가장 첫번째 행이 열의 이름인지 데이터인지 지정
#          > True이면 열의 이름, False이면 데이터 의미
# sep : 어떤 형식으로 데이터가 분리되어 있는지 지정
malaria <-read.csv("C:/work/Crystal/2023(석1)/1학기/보건통계학개론/실습/malaria.csv",
                   header=TRUE)
# read.csv() 함수는 csv 파일만 불러오기 가능

# From Excel
# 엑셀 파일은 바로 불러오기 불가능 > 패키지 설치 후 불러오기 가능
install.packages("readxl")
library(readxl)
read_excel("C:/work/Crystal/2023(석1)/1학기/보건통계학개론/실습/malaria.xlsx") # 엑셀 파일 불러오기
malaria <- read_excel("C:/work/Crystal/2023(석1)/1학기/보건통계학개론/실습/malaria.xlsx", #path
                      sheet = "malaria", #sheet name to read from : 엑셀의 어떤 시트를 사용할지
                      range = "A1:D101", #cell range to read from : 불러올 범위 지정
                      col_names = TRUE, #TRUE to use the first row as column names (read.csv의 header와 동일)
                      col_types = "guess", #guess the types of columns : 열의 종류
                      na="NA") #Character vector of strings to use for missing values (Default : "NA")

# From text file
malaria <- read.table("C:/R_data/malaria.txt", header=TRUE, sep="\t")
# 텍스트 파일은 "/t"로 분리되어 있음


### Exporting data
#to CSV file
write.table(malaria, "C:/R_data/mal02.csv", sep=',', row.names=F)
# row.names : 행의 이름 저장할지 지정
#             > True 혹은 T인 경우 저장, False 혹은 F인 경우 저장하지 않음
write.csv(malaria, "C:/R_data/mal02.csv", row.names=F)

#to tab delimited text file
write.table(malaria, "C:/R_data/mal02.txt", sep="\t", row.names=F) 

#to Excel
install.packages("writexl")
library(writexl)
write_xlsx(malaria, "C:/R_data/mal02.xlsx")


### Viewing data
ls() # list objects in the working environment : 지금까지 만든 변수 이름 확인
names(malaria) # list the variables in malaria : 데이터셋의 열 이름 확인
str(malaria) # list the structure of malaria : 데이터셋의 속성 확인
# > 데이터셋 열의 각 이름, 클래스 등 확인 가능
# 변수$열명 : 데이터셋의 특정 열 데이터 확인
malaria$v1<-factor(malaria$mal) # factor(요인형) 열 추가
levels(malaria$v1) # list levels of factor v1 in malaria : 요인형 종류 확인
# > 데이터가 100개 이상이면 NULL 출력
levels(malaria$age)
dim(malaria) # dimensions of an malaria : 행과 열 개수 확인
class(malaria) # class of an malaria (numeric, matrix, dataframe, etc) : 자료구조 확인
malaria # print malaria : 데이터셋 내 모든 데이터 출력
head(malaria, n=10) # print first 10 rows of malaria : 위 n개 행의 데이터 출력
tail(malaria, n=5) # print last 5 rows of malaria : 아래 n개의 행의 데이터 출력
# > default : 5
summary(malaria) # 데이터셋의 수리학적 계산


### Value Labels
# variable v1 is coded 1, 2 or 3
# we want to attach value labels 1=red, 2=blue, 3=green
v1 <- c(1, 1, 1, 2, 2, 3)
v2 <- factor(v1, levels = c(1, 2, 3), labels = c("red", "blue", "green")) 
# levels : 요인형 부여
# labels : 각 요인의 이름 부여
v2 # 각 요인 별로 라벨링 됨


### Missing data ###
### 중간고사 빈출 ###
#Testing for missing values
y <- c(1, 2, 3, NA, NA) # NA : 결측치
is.na(y) # returns a vector (F F F T) : 어떤 데이터가 결측치인지 확인
# TRUE면 결측치, FALSE면 결측치가 아님 의미
which(is.na(y)) # 몇 번째가 결측치를 가지는지 모두 출력

#Recoding values to missing
malaria[malaria$age==99, "age"]<-NA # age 열의 99를 가진 행에 결측치 입력
which(is.na(malaria)) # 160 : 160번째 행에 결측치 존재 의미

#Excluding missing values from analyses
x <- c(1,2,NA,3)
mean(x)  # returns NA : 만일 데이터셋 내에 NA가 존재하면 계산 결과 NA 반환
mean(x, na.rm=TRUE) # returns 2 (default : na.rm=FALSE)
# na.rm=TRUE : 만일 결측치가 있는 경우, 결측치를 제외하고 계산


### Getting help
help.start() # general help : 도움이 될 만한 것들 확인 가능
help(table) # help about function table() : help(함수)
?table # 특정 함수에 대한 도움 확인
??table # ? 하나보다 더 자세한 도움 받기 가능

getwd() # print the current working directory : 현주소(폴더) 확인
ls() # list the objects in the current workspace : 현재까지 만든 변수 확인
setwd("C:/docs/mydir") # note / instead of \in windows : 현주소 변경
list.files() #print a list of files in the working directory : 현주소 내 파일(데이터) 확인
# 만일, 파일을 불러올 때 따로 경로를 입력하지 않으면 현주소에서 불러옴
# 파일이 없는 경우, Error 발생


### Useful Functions
# For vector
a
length(a) # number of elements or components : 벡터의 길이(개수)
str(a) # internal structure of an object : 속성 확인
class(a) # class or type of an object : 자료구조 확인

# For matrix
y<-matrix(1:20, nrow=5,ncol=4)
y
length(y) # number of elements or components : 전체 데이터 개수 확인
str(y) # internal structure of an object
class(y) # class or type of an object
# "matrix" "array" : array로 생성하였기 때문
dim(y) # dimension of an object : 각 행과 열의 개수 확인

# For list
length(w) # number of elements or components : 열의 개수 출력
str(w) #structure of an object
class(w) # class or type of an object
attributes(w) # attribute list : 리스트의 속성 출력
# 기본으로 '$names' 출력
attributes(w$number)

w$name
w$number[1]
w$matrix[1,2]
w$age
w

# More...
a <- c(1, 2.4, 3.2, 0.5, 0.7, 0.9, 4)
b <- a+1 # a 변수에 1을 더한 값의 벡터 만들기
a
b
c(a, b) # 한 줄로 묶기
mycbind <- cbind(a,b) #combine objects by column : 열 단위 묶기
mycbind
myrbind <- rbind(a,b) #combine objects by row : 행 단위 묶기
myrbind

class(a)
class(b)
class(mycbind)
rownames(mycbind) <- c("Sun","Mon","Tue","Wd","Thu","Fri","Sat")
# rownames : 각 행의 이름
colnames(mycbind) <- c("TV watching","Exercise")
# colnames : 각 열의 이름
mycbind

