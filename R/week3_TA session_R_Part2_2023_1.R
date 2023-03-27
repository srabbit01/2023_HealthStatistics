###########################
##### Data management #####
###########################

### Arithmetic Operators
a <- c(3,5)
a

# + addition; - subtraction; * multiplication; / division 
a[1]+a[2] 	

#^ or ** exponentiation 
a[1]^2
a[1]**2

#x %% y modulus (x mod y) 
a[2] %% a[1] 
24%%9 
9%%24 

#x %/% y integer division  
a[2] %/% a[1] 
24%/%9 
9%/%24 


###Logical Operators 
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
malaria <-read.table("C:\\R_data\\malaria.csv", header=TRUE, sep=",")
head(malaria)
dim(malaria)
summary(malaria)

### to create new variables 
#1. malaria$diff <- malaria$ab - malaria$age 
head(malaria)

#2. 'ifelse'
malaria$agecat <- ifelse(malaria$age >7, "student", "baby") 
head(malaria)

#3. [condition]
malaria$agecat2[malaria$age > 7] <- "student"
malaria$agecat2[malaria$age <= 7] <- "baby"
head(malaria)

#4. 'if'-'else'
sbp <- 126

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


### to sort data
# sort by mal
head(malaria,10)
newdata <- malaria[order(malaria$mal), ] 
head(newdata, 10)

# sort by mal and age
newdata2 <- malaria[order(malaria$mal, malaria$age),]
head(newdata2, 10)

#sort by mal (ascending) and age (descending)
newdata3 <- malaria[order(malaria$mal, -malaria$age),] 
head(newdata3, 10)


###Merging data
#Raw dataset
malaria <-read.table("C:\\R_data\\malaria.csv", header=TRUE, sep=",")
head(malaria)
tail(malaria)
dim(malaria)

#Adding rows 
extra<-read.table("C:\\R_data\\extra15.csv", header=TRUE, sep=",")
head(extra)
tail(extra)
dim(extra)
malaria_binded<-rbind(malaria, extra) 
tail(malaria_binded, 20)
dim(malaria_binded)

#Adding columns by matching 
region<-read.table("C:\\R_data\\region.csv", header=TRUE, sep=",")
region<-read.table("C:\\R_data\\region.csv", header=TRUE, sep=",", fileEncoding="CP949", encoding="UTF-8")
head(region)
dim(region)
malaria_binded2<-merge(malaria_binded, region, by="subject")
head(malaria_binded2, 20) 
dim(malaria_binded2)


###Subsetting
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
#to import data
data1 <- read.table("C:\\R_data\\data2010.csv", header=TRUE, sep=",")
names(data1)
dim(data1)
head(data1)
tail(data1)
summary(data1)


## statistical functions
x <- data1$meanpm10
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

#numeric
summary(data1$meanpm10)
summary(data1$season)
#factor
data1$season_f <- as.factor(data1$season) # 'factor'
summary(data1[, c("season","season_f")])
table(data1$yy) #frequency table even for numeric variables

x <- data1$meanpm10
sd(x, na.rm=T)
breaks <- seq(0, 240, by=50) 
breaks.cut <- cut(x, breaks, right=FALSE) ##0-49,50-99,100-149,150-199
freq <- table(breaks.cut)
freq
freq1 <- data.frame(freq)
freq1
freq1$percent <- round(freq1$Freq/sum(freq1$Freq)*100, 2)
freq1$cum_per <- round(cumsum(freq1$percent), 2)
freq1


###implicit loops
data1 <- read.table("C:\\R_data\\data2010.csv", header=TRUE, sep=",")

#returns a list
lapply(data1[, c("meantemp","meanpm10","meanso2")], mean, na.rm=T)

#returns a vector
sapply(data1[, c("meantemp","meanpm10","meanso2")], mean, na.rm=T) 

#returns a table
tapply(data1$meantemp, data1$season, median) #create a table 
median(data1[data1$season==1,"meantemp"], na.rm=T)

###Testing for Missing Values
is.na(data1$meanpm10)[1:500] # returns TRUE if x is missing
which(is.na(data1$meanpm10)) 
table(is.na(data1$meanpm10))
sum(is.na(data1$meanpm10)) 

n_na <- sapply(data1[, c("meantemp","meanpm10","meanso2")], function(x) sum(is.na(x))); n_na
n <- sapply(data1[, c("meantemp","meanpm10","meanso2")], function(x) length(x)); n
a <- rbind(n_na,n); a
na_table <- t(a); na_table

###Practice
v_mean <- round(sapply(data1[, c("nonacc","meantemp","meanno2")], mean, na.rm=T), 2); v_mean
v_sd <- round(sapply(data1[, c("nonacc","meantemp","meanno2")], sd, na.rm=T),2); v_sd
v_percentile <- sapply(data1[, c("nonacc","meantemp","meanno2")], quantile, na.rm=T); v_percentile
v_n_na <- sapply(data1[, c("nonacc","meantemp","meanno2")], function(x) sum(is.na(x))); v_n_na
#to combine results
ds <- rbind(v_mean, v_sd, v_percentile, v_n_na); ds
#to export results 
write.table(ds, "C:\\R_data\\result1.csv", row.names=F, sep=',')
write.table(ds, "C:\\R_data\\result2.csv", row.names=T, sep=',')

### histogram
par(mfrow=c(2,2)) #split the screen in several panels
hist(data1$meanpm10) 
hist(data1$meanpm10, breaks=5)  
hist(data1$meanpm10, breaks=20, density=15) 
hist(data1$meanpm10, freq=FALSE)
par(mfrow=c(1,1))

### Stem and leaf plot
malaria$age
stem(malaria$age)


### bar chart
win.graph()
counts <- table(data1$influenza); counts
barplot(counts, main="Influenza epidemics", horiz=TRUE,
        names.arg=c("0 Non-epidemic", "1 Epidemic"))
dev.off()

### boxplot
win.graph()
boxplot(nonacc~dow, data=data1, main="Mortality vs weekday", 
        xlab="Day of week", ylab="Total mortality") 
dev.off()

### Simple Scatterplot 
win.graph()
plot(data1$meantemp, data1$nonacc,
     main= "Regression of mortality on Temperature") 
abline(lm(data1$nonacc~data1$meantemp), col=2) # regression line (y~x)
lines(lowess(data1$nonacc~data1$meantemp), col=5) # lowess line (x,y)
dev.off()

### Basic Scatterplot Matrix
win.graph()
pairs(~ nonacc+meantemp+meanpm10+meanno2+meanco+maxco+maxo3, data=data1, 
      main="Simple Scatterplot Matrix")
dev.off()
