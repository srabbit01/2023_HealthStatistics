### Simple Linear Regression ###
#example data
head(iris)

#Scatter plot
plot(iris$Petal.Width, iris$Sepal.Length,pch=16)

#Fit a model
mod1<-lm(Sepal.Length ~ Petal.Width, data=iris)
#Coefficients
mod1
#Useful functions to see results
summary(mod1)
anova(mod1)

#Save result to get values from the model(summary)
sm.mod1 <- summary(mod1)
#Coefficients
sm.mod1$coefficients
#R square
sm.mod1$r.squared
#Adjusted R square
sm.mod1$adj.r.squared

#Save result to get values from the model(anova)
anv.mod1 <- anova(mod1)
#values
SS <- anv.mod1$`Sum Sq`; SS
SSR <- anv.mod1$`Sum Sq`[1]; SSR
SST <- sum(SS); SST
#R square (manually calculated)
Rsquare <- SSR/SST; Rsquare
#Adjusted R square (manually calculated)
n <- nrow(iris)
p <- 1
1-((1-Rsquare)*(n-1))/(n-p-1)

#Scatter plot with Regression line
plot(iris$Petal.Width, iris$Sepal.Length,pch=16)
abline(mod1,lwd=2,col="red")


##F-test (manually calculated)
#MSR, MSE
anv.mod1$`Mean Sq`
#F-statistics
F <- anv.mod1$`Mean Sq`[1]/anv.mod1$`Mean Sq`[2]; F
#p-value for F-statistics
pf(F, anv.mod1$Df[1], anv.mod1$Df[2], lower.tail=FALSE)



### Multiple Linear Regression ###
#Fit a model
mod2<-lm(Sepal.Length ~ Petal.Width + Petal.Length, data=iris)
#Coefficients
mod2
#Useful functions to see results
summary(mod2)
anova(mod2)

#Save result to get values from the model(summary)
sm.mod2 <- summary(mod2)
#Coefficients
sm.mod2$coefficients
#R square
sm.mod2$r.squared
#Adjusted R square
sm.mod2$adj.r.squared

#Save result to get values from the model(anova)
anv.mod2 <- anova(mod2)
#values
SS <- anv.mod2$`Sum Sq`; SS
SSR <- sum(anv.mod2$`Sum Sq`[1:2]); SSR
SST <- sum(SS); SST
#R square (manually calculated)
Rsquare <- SSR/SST; Rsquare
#Adjusted R square (manually calculated)
n <- nrow(iris)
p <- 2
1-((1-Rsquare)*(n-1))/(n-p-1)


##F-test (using anova())
#only intercept model
mod.int<-lm(Sepal.Length ~ 1, data=iris)
#F-test using anova function (intercept only model vs. full model)
anova(mod.int, mod2)


##F-test (manually calculated)
#information of Sum of squares / Degree of freedoms
anv.mod2$`Sum Sq`
anv.mod2$Df
#MSR
SSR <- sum(anv.mod2$`Sum Sq`[1:2]); SSR
SSR.df <- sum(anv.mod2$Df[1:2]); SSR.df
MSR <- SSR/SSR.df; MSR
#MSE
SSE <- anv.mod2$`Sum Sq`[3]; SSE
SSE.df <- anv.mod2$Df[3]; SSE.df
MSE <- SSE/SSE.df; MSE
#F-statistics
F <- MSR/MSE; F
#p-value for F-statistics
pf(F, SSR.df, SSE.df, lower.tail=FALSE)


## Confidence Intervals for model coefficients
confint(mod2)
confint(mod2,level=0.90)
confint(mod2,level=0.95)
confint(mod2,level=0.99)


## Prediction
# using predict() function
new <- data.frame(Petal.Width=1.2, Petal.Length=4.1)
predict(mod2, new, se.fit=TRUE)
# Calculate y hat manually
b0 <- mod2$coefficients[1]
b1 <- mod2$coefficients[2]
b2 <- mod2$coefficients[3]
y.hat <- b0 + b1*1.2 + b2*4.1; 
names(y.hat) <- 'predicted y hat'; y.hat

# y hat with confidence interval
predict(mod2, new ,interval="confidence")
# y hat with prediction interval
predict(mod2, new ,interval="prediction")


##Regression with Categorical variable
# Create categorical variable using factor()
iris.new <- iris
iris.new$fac.Species <- factor(iris.new$Species)
class(iris.new$fac.Species)
levels(iris.new$fac.Species)

# Fit a model with categorical variable
mod3<-lm(Sepal.Length ~ fac.Species, data=iris.new)
summary(mod3)
# Change the reference group using relevel()
iris.new$fac.Species <- relevel(iris.new$fac.Species, ref='virginica')
levels(iris.new$fac.Species)
mod3.relevel<-lm(Sepal.Length ~ fac.Species, data=iris.new)
summary(mod3.relevel)


##Regression with interaction term
mod4<-lm(Sepal.Length ~ Petal.Width + Petal.Length + Petal.Width*Petal.Length, data=iris)
summary(mod4)

