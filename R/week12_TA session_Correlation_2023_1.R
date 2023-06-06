### Simple Linear Regression ###
#attach(iris)
head(iris)


#Regression and Correlation
mod1<-lm(Sepal.Length ~ Petal.Width, data=iris)
summary(mod1)
coefficients(summary(mod1))

sqrt(summary(mod1)$r.squared)
cor.test(Sepal.Length, Petal.Width, data=iris)
cor.test(~ Sepal.Length + Petal.Width, data=iris)
cor(iris$Sepal.Length, iris$Petal.Width) #Pearson's corr coef


#Multiple Correlation Coefficient
mod2<-lm(Sepal.Length ~ Petal.Width + Petal.Length, data=iris)
#summary(mod2) #coefficients(summary(mod2))

sqrt(summary(mod2)$r.squared)

mod3<- lm(Sepal.Length ~ 1, iris)
anova(mod3, mod2)


#Partial Correlation Coefficient
#install.packages("ppcor")
library(ppcor)
pcor.test(iris$Sepal.Length, iris$Sepal.Width, iris$Petal.Length)
cor(iris[1:3])
pcor(iris[1:3])


## Graphics in R
attach(iris)
plot(Sepal.Length, Sepal.Width)
# plot(iris$Sepal.Length, iris$Sepal.Width)
# plot(Sepal.Width, Sepal.Length)
# plot(iris[1:4])
abline(h=3)
abline(a=0, b=1/2)

#Options
plot(iris[1:2], 
     main="Scatter Plot", sub="iris",
     xlab="xvalue", ylab="yvalue", 
     xlim=c(2,10), ylim=c(1,5),
     type="b", 
     pch=11, lty=4, lwd=0.1, 
     col="blue")
abline(a=0, b=1/2, 
       lty=5, lwd=2, col="red")

plot(mod1) # lm(Sepal.Length~Petal.Width, iris)
plot(mod1, which=1)
plot(Petal.Width, Sepal.Length)
abline(mod1, col="red")



