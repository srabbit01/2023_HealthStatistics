###########################
######## Data input #######
###########################

#### Vectors
#numeric vector
a <- c(1, 2, 5.3, 6, -2,4) 

#character vector
b <- c("one", "two", "three") 

#logical vector
c <- c(TRUE, TRUE, TRUE, FALSE, TRUE, FALSE) 

#[ ]: index for the vector
a[c(2,4)] #2nd and 4th elements of vector

#### Factors
gender <- c(rep("male",20), rep("female", 30)) 
gender <- factor(gender)

# R now treats gender as a nominal variable 
summary(gender)


### Matrices
# generates 5 x 4 numeric matrix 
y<-matrix(1:20, nrow=5,ncol=4)
dim(y)
y[,4] # 4th column of matrix
y[3,] # 3rd row of matrix 
y[2:4, 1:3] # rows 2,3,4 of columns 1,2,3

z1 <- 1:3
z2 <- 10:12
cbind(z1, z2) #column-binding
rbind(z1, z2) #row-binding


### Data Frames
d <- c(1, 2, 3, 4)
e <- c("red", "white", "red", NA)
f <- c(TRUE, TRUE, TRUE, FALSE)
mydata <- data.frame(d, e, f)
#assign variable names
names(mydata) <- c("ID", "Color", "Passed")
rownames(mydata)
colnames(mydata)


### Array
b<-array(1:30,dim=c(2,5,3))
class(b)


### Lists
# example of a list with 4 components - 
# a string, a numeric vector, a matrix, and a scalar 
w <- list(name="Fred", numbers=a, matrix=y, age=5.3)


### Importing data
# From CSV file
malaria <-read.table("C:/R_data/malaria.csv", header=TRUE, sep=",")
malaria <-read.csv("C:/R_data/malaria.csv", header=TRUE)

# From Excel
install.packages("readxl")
library(readxl)
read_excel()
malaria <- read_excel("C:/R_data/malaria.xlsx", #path
                      sheet = "malaria", #sheet name to read from
                      range = "A1:D101", #cell range to read from
                      col_names = TRUE, #TRUE to use the first row as column names
                      col_types = "guess", #guess the types of columns
                      na="NA") #Character vector of strings to use for missing values

# From text file
malaria <- read.table("C:/R_data/malaria.txt", header=TRUE, sep="\t")


### Exporting data
#to CSV file
write.table(malaria, "C:/R_data/mal02.csv", sep=',', row.names=F)
write.csv(malaria, "C:/R_data/mal02.csv", row.names=F)

#to tab delimited text file
write.table(malaria, "C:/R_data/mal02.txt", sep="\t", row.names=F) 

#to Excel
install.packages("writexl")
library(writexl)
write_xlsx(malaria, "C:/R_data/mal02.xlsx")


### Viewing data
ls() # list objects in the working environment
names(malaria) # list the variables in malaria
str(malaria) # list the structure of malaria
levels(malaria $v1) # list levels of factor v1 in malaria
malaria$v1<-factor(malaria$mal) 
dim(malaria) # dimensions of an malaria
class(malaria) # class of an malaria (numeric, matrix, dataframe, etc)
malaria # print malaria 
head(malaria, n=10) # print first 10 rows of malaria
tail(malaria, n=5) # print last 5 rows of malaria
summary(malaria)


### Value Labels
# variable v1 is coded 1, 2 or 3
# we want to attach value labels 1=red, 2=blue, 3=green
v1 <- c(1, 1, 1, 2, 2, 3)
v2 <- factor(v1, levels = c(1, 2, 3), labels = c("red", "blue", "green")) 


### Missing data
#Testing for missing values
y <- c(1, 2, 3, NA)
is.na(y) # returns a vector (F F F T) 

#Recoding values to missing
malaria[malaria$age==99, "age"]<-NA

#Excluding missing values from analyses
x <- c(1,2,NA,3)
mean(x)  # returns NA
mean(x, na.rm=TRUE) # returns 2


### Getting help
help.start() # general help 
help(table) # help about function table()
?table 
??table

getwd() # print the current working directory
ls() # list the objects in the current workspace
setwd("C:/docs/mydir") # note / instead of \in windows 
list.files() #print a list of files in the working directory


### Useful Functions
# For vector
a
length(a) # number of elements or components
str(a) # internal structure of an object
class(a) # class or type of an object

# For matrix
y<-matrix(1:20, nrow=5,ncol=4)
y
length(y) # number of elements or components
str(y) # internal structure of an object
class(y) # class or type of an object
dim(y) # dimension of an object

# For list
length(w) # number of elements or components
str(w) #structure of an object
class(w) # class or type of an object
attributes(w) # attribute list

w$name
w$number[1]
w$matrix[1,2]
w$age
w

# More...
a <- c(1, 2.4, 3.2, 0.5, 0.7, 0.9, 4)
b <- a+1
a
b
c(a, b)
mycbind <- cbind(a,b) #combine objects by column
mycbind
myrbind <- rbind(a,b) #combine objects by row
myrbind

class(a)
class(b)
class(mycbind)
rownames(mycbind) <- c("Sun","Mon","Tue","Wd","Thu","Fri","Sat")
colnames(mycbind) <- c("TV watching","Exercise")
mycbind

