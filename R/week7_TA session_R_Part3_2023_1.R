# Homework for TA session Part2
data1 <- read.table("C:\\R_data\\data2010.csv", header=TRUE, sep=",")
mycity <- subset(data1, ccode==21)


#Add a new variable to the dataset
mycity$other<-mycity$nonacc-(mycity$cardio + mycity$respir)


#Descriptive statistics for all variables: ‘summary’ (numeric or factor)
summary(mycity)
mycity$ccode<-as.factor(mycity$ccode)
mycity$cname<-as.factor(mycity$cname)
mycity$influenza<-as.factor(mycity$influenza)


#Select 6 variables (2 from death, 2 from air pollution, 2 from weather
n_na <- sapply(mycity[,c("cardio","respir","meanpm10","meanso2","meantemp","meanhumi")],
               function(x) sum(is.na(x)))
n <- sapply(mycity[,c("cardio","respir","meanpm10","meanso2","meantemp","meanhumi")],
              function(x) length(x))
p_na <- round((n_na/n)*100, 2)
na_table <-rbind(n_na, n, p_na)


#Make a table for mean values of 6 variables by season (use 'tapply' function
cardio <- tapply(mycity$cardio, mycity$season, mean, na.rm=T)
respir <- tapply(mycity$respir, mycity$season, mean, na.rm=T)
meanpm10 <- tapply(mycity$meanpm10, mycity$season, mean, na.rm=T)
meanso2 <- tapply(mycity$meanso2, mycity$season, mean, na.rm=T)
meantemp <- tapply(mycity$meantemp, mycity$season, mean, na.rm=T)
meanhumi <- tapply(mycity$meanhumi, mycity$season, mean, na.rm=T)

rbind(cardio, respir, meanpm10, meanso2, meantemp, meanhumi)

aggregate(mycity[,c("cardio","respir","meanpm10","meanso2","meantemp","meanhumi")],
          by=list(mycity$season), mean, na.rm=T)



#2 histograms (2 variables)
par(mfrow=c(1,2))
hist(mycity$cardio) 
hist(mycity$respir) 

#a boxplot (1 from death) by dow
boxplot(cardio~dow, data=mycity, main="Death from cardio vs weekday", 
        xlab="Day of week", ylab="Total mortality") 

#a boxplot (1 from weather or air pollution) by year
boxplot(meantemp~yy, data=mycity, main="Mean temperature vs year", 
        xlab="Year", ylab="Mean temperature") 

#Draw a graph to explore the association between health outcome (1 from death variables)
# and exposure (1 from weather or air pollution variables): scatter plot + line
par(mfrow=c(1,1))
plot(mycity$meantemp, mycity$cardio,
     main= "Regression of mortality on Temperature") 
abline(lm(mycity$cardio~mycity$meantemp), col=2) # regression line (y~x)




# For loop
for(i in 1:10) {
  print(i)
}


x <- c("a", "b", "c", "d")

for(i in 1:4){
  print(x[i])   # Print out each element of 'x'
}

for(i in seq_along(x)){
  print(x[i])   # Generate a sequence based on length of 'x'
}


# Nested For loops
x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i, j])   # Generate a sequence based on length of 'x'
  }
}


# Practice - For loop
data1<-read.table("C:\\R_data\\data2010.csv", header=TRUE, sep=",")
city<-read.table("C:\\R_data\\city.csv", header=TRUE, sep=",", 
                 fileEncoding="CP949", encoding="UTF-8")

mdata<-merge(subset(data1,yy==2000), city, by="ccode")
head(mdata)

result<-matrix(NA,7,3)
x<-c("cardio", "respir", "meanpm10")
y<-city$cityname    # "서울" "부산" "대구" "인천" "광주" "대전" "울산"
colnames(result)<-x
rownames(result)<-y
result

for(i in seq_along(x)){   # Also use 1:3 instead of seq_along(x)
  for(j in seq_along(y)){   # Also use 1:7 instead of seq_along(x)
    result[j,i]<-round(mean(mdata[mdata$cityname==y[j], x[i]], na.rm=T), 2)
  }
}
result
mdata[mdata$cityname=="울산", "meanpm10"]


# Function
myadd <- function(x, y) {
  x + y
}
myadd(2,4)


above10 <- function(x) {
  use <- x > 10   #TRUE or FALSE
  x[use]
}
x<-1:20
above10(x)


above <- function(x, n) {
  use <- x > n   #TRUE or FALSE
  x[use]
}
above(x)
above(x, 12)

above <- function(x, n=10) {   # Make n=10 as default
  use <- x > n   #TRUE or FALSE
  x[use]
}
above(x)


# Practice - Function
columnmean <- function(y) {
  nc <- ncol(y)
  means <- numeric(nc)
    for(i in 1:nc) {
      means[i] <- mean(y[, i], na.rm=T)
    }
  means
}
columnmean(result)
result

