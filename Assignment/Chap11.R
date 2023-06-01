# Chap9 과제

### 13.
sex=read.csv("sex.csv")
sex
data=data.frame(sex$A,sex$B,sex$C,sex$D)
chisq.test(data)


### 14.
rp=read.csv("raceparty.csv")
rp
data=data.frame(rp$A,rp$B,rp$C,rp$D)
chisq.test(data)


### 15.
blood=read.csv("blood.csv")
blood
data=data.frame(blood$yes,blood$no)
chisq.test(data)


### 16.
rh=read.csv("racehemo.csv")
rh
data=data.frame(rh$above10,rh$X9to10,rh$below9)
chisq.test(data)
