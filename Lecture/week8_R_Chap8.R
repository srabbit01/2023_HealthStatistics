### April 17 ###
# chap 8 examples

# ANOVA 검정
sele = read.table ('C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/sele.csv',sep =',',header=T)
# aov(y값~x값,data=데이터)
aov(value~Group,data=sele)
'''
Call:
   aov(formula = value ~ Group, data = sele)

Terms:
                   Group Residuals
Sum of Squares   5931208  23026500
Deg. of Freedom        3       109

Residual standard error: 459.6219
Estimated effects may be unbalanced
'''
boxplot(value~Group,data=sele)