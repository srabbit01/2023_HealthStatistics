# Chap12 과제

### 3.
num=c(1:15)
score=c(75,90,85,110,115,95,132,74,82,104,88,124,110,76,98)
med=100
alpha=0.05
wilcox.test(score,mu=100)


### 4.
ani=c(63,68,79,65,64,63,65,64,76,74,66,66,67,73,69,76)
mu=70
wilcox.test(ani,mu=mu,alternatice="less")


### 5.
num=c(1:8)
be=c(214,362,202,158,403,219,307,331)
af=c(232,276,224,412,562,203,340,313)
## 1)
t.test(be,af,paired=TRUE)
## 2)
wilcox.test(be,af,paired=TRUE)


### 6.
# install.packages('coin')
library(coin)
A=c(99,85,73,98,83,88,99,80,74,91,80,94,94,98,80)
B=c(78,74,69,79,57,78,79,68,59,91,89,55,60,55,79)
data=data.frame(val=c(A,B),level=rep(c("A","B"),each=15))
wilcox_test(val~as.factor(level),data=data,distribution="exact")


### 7.
G1=c(252,215,240,240,190,302,205,270,312,200,159,126,170,204,268,170,215,215,320,254,183,148,164,287,214,288,210,270,138,225,265,240,258,203,217,221)
G2=c(185,195,220,310,210,295,212,190,202,238,172,268,184,190,220,136,140,311,200,280,164,270,264,206,200,270,170,212,210,190,182,192,225,126)
data=data.frame(val=c(G1,G2),group=c(rep("G1",each=36),rep("G2",each=length(G2))))
wilcox_test(val~as.factor(group),data=data,distribution="exact")


### 8.
brain=c(859,962,973,904,920,1073,1051,1001,1012,1039,1041,1064,1016,1002,1086,1166,1141,1168,1146,1140,1117,1202,1255,1233,1348)
mu=1050
sd_=50
ks.test(brain,"pnorm",mean=mu,sd=sd_)


### 9.
re1=c(80.75,78.15,85.4,71.94,82.05)
re2=c(58.63,72.7,64.2,62.5,63.24)
re3=c(84.21,101.76,107.74,115.3,126.15)
data=data.frame(cost=c(re1,re2,re3),region=rep(c("re1","re2","re3"),each=5))
kruskal.test(cost~region,data=data)


### 10.
ID=c(1:9)
ba=c(98,95,76,95,83,99,82,75,88)
phy=c(95,71,80,81,77,70,80,72,81)
ana=c(77,79,91,84,80,93,87,81,83)
alpha=0.05
data=data.frame(ID=c(ID,ID,ID),score=c(ba,phy,ana),subject=rep(c("ba","phy","ana"),each=9))
friedman.test(data$score,data$subject,data$ID)


### 11.
region=c(1:10)
per=c(8,9,7,3,2,4,1,5,6,10)
flu=c(1,3,4,9,8,7,10,6,5,2)
alpha=0.05
data=data.frame(region,per,flu)
cor.test(data$per,data$flu,method="spearman",alternative="greater")
