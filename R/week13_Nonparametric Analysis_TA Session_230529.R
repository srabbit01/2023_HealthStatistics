# install.packages("coin") ;
# install.packages("dunn.test") ;
library(coin) ;
library(dunn.test) ;

#################### Example using real data ####################

data(mtcars) ;
data(chickwts) ;
data(Orange) ;

# Wilcoxon test for 1 data
hist(mtcars$disp) ;
wilcox.test(mtcars$disp, mu=250) ;

# Wilcoxon test for 2 groups
boxplot(hp ~ am, data=mtcars) ;
wilcox_test(hp ~ as.factor(am), data=mtcars, distribution = 'exact', alternative = 'two.sided') ;

# Kolmogorov-Smirnov test
hist(chickwts$weight) ;
ks.test(chickwts$weight, 'pnorm', mean=mean(chickwts$weight), sd=sd(chickwts$weight)) ;
mtcars_1	<- mtcars[mtcars$am == 1,] ; mtcars_0	<- mtcars[mtcars$am == 0,] ;
ks.test(mtcars_0$disp, mtcars_1$disp, exact=TRUE) ;

# Kruskal-Wallis test & Dunn's test
kruskal.test(weight~feed, data=chickwts) ;
aggregate(weight~feed, data=chickwts, "median") ;
boxplot(weight~feed, data=chickwts)
dunn.test(chickwts$weight, chickwts$feed, kw=FALSE, method="bh") ;

# Friedman's test for 2 way variance analysis
friedman.test(Orange$circumference, Orange$age, Orange$Tree) ;
friedman.test(Orange$circumference, Orange$Tree, Orange$age) ;

# Spearman correlation
plot(qsec~hp, data=mtcars) ;
cor.test(~ qsec+hp, data=mtcars, method="spearman") ;
spearman_test(qsec ~ hp, data=mtcars) ;


#################### Example 12.3.1 ####################

data_test	<- data.frame(student_id=seq(15), score=c(75,90,86,110,115,94,132,74,82,104,88,124,110,77,99)) ;
data_test$sign	<- ifelse(data_test$score - 100 > 0, TRUE, FALSE) ;
# Ignore if zero values exist
zeros <- sum(ifelse(data_test$score - 100 == 0, TRUE, FALSE))

n <- nrow(data_test)-zeros ; n
k <- sum(data_test$sign) ; k

pbinom(k,n,0.5)

# Two-sided test
p_val	<- 2*(ifelse(k < n/2, pbinom(k,n,0.5), 1 - pbinom((k-1),n,0.5))) ; p_val
# Same result
binom.test(k, n, 0.5)

#################### Example 12.3.2 ####################

rm(list=ls()) ;
data_brush	<- data.frame(id=seq(12), edu_yes=c(1.6,2,3.7,3.5,3.3,2.4,2,1.5,1.5,2.1,3.6,2.3),
						edu_no=c(2,2,4.1,2.4,4.2,3.6,3.5,3,2.5,2.5,2.5,2.5))

# H1: median(edu_yes - edu_no) < 0
data_brush$sign	<- ifelse(data_brush$edu_yes - data_brush$edu_no > 0, 1, 
				ifelse(data_brush$edu_yes - data_brush$edu_no == 0, 0, -1)) ;

# 차이가 없는 행 제거
data_brush	<- data_brush[data_brush$sign != 0,] ;

n <- nrow(data_brush) ; k <- sum(data_brush$sign > 0) ;

p_val	<- pbinom(k,n,0.5) ;

#################### Example 12.4.1 ####################

rm(list=ls()) ;
data	<- c(4.90,4.1,6.73,7.27,7.42,7.5,6.76,4.64,5.98,3.14,3.24,5.8,6.17,5.39,5.78) ;
wilcox.test(data, mu=4.7) ;

#################### Example 12.5.1 ####################

rm(list=ls()) ;
median.test	<- function(x,y) {
	z <- c(x,y) ;
	g <- rep(1:2, c(length(x),length(y))) ;	# 그룹 변수
	m <- median(z) ;
	# 그룹에 따라 중앙값 초과한 관측값의 수
	chisq.test(z<m, factor(g), correct=FALSE) ;
}

xx	<- c(35,26,27,21,27,38,23,25,25,27,45,46,33,26,46,41) ;
yy	<- c(29,50,43,22,42,47,42,32,50,37,34,31) ;
median.test(xx, yy) ;

#################### Example 12.6.1 ####################

rm(list=ls()) ;
#install.packages('coin')
#install.packages('exactRankTests')
library(coin) 
library(exactRankTests)

xx	<- c(252,240,205,200,170,170,320,148,214,254,164,288,138,240,217,240,302,312)
yy	<- c(185,310,212,238,184,136,200,270,280,264,270,210,192,126,220,295)

dat	<- data.frame(val=c(xx,yy), group=factor(rep(1:2,c(length(xx),length(yy)))) ) 
wilcox.exact(val~group, data=dat, alternative = 'two.sided') ;

#################### Example 12.7.1 ####################

rm(list=ls()) ;
xx	<- c(75,92,80,80,83,72,83,77,81,77,75,81,80,92,72,77,78,76,77,86,77,92,80,78,
		68,78,92,68,80,81,87,76,80,87,77,86) ;
ks.test(xx, 'pnorm', mean=80, sd=6) ;	# Tie 존재: asymptotic 분포로부터 근사적인 p-value 계산

#################### Example 12.8.1 ####################

rm(list=ls()) ;
xx	<- c(12.01,3.67,55.63,29.44,4.05,27.88,28.02,6.49,66.81,38.33,21.12,46.27,55.91,1.11,31.19) ;
dat	<- data.frame(val=xx, group=factor(rep(1:3,5))) ;
kruskal.test(val~group, data=dat) ;

#################### Example 12.8.2 ####################

rm(list=ls()) ;
val	<-c(17.38,15.20,14.76,16.88,17.02,26.67,15.75,16.02,15.30,16.98,52.59,
		44.55,44.80,43.25,50.75,52.25,46.13,48.87,27.87,24.00,26.55,25.00,
		27.55,25.92,26.01,16.48,17.00,34.55,31.15,30.50,31.25,32.75,33.00,
		27.30,60.77,59.99,58.94,57.05,60.50,61.50,51.10) ;
group	<- factor(rep(c('A','B','C','D','E'), c(10,8,9,7,7))) ;
dat	<- data.frame(val, group) ;
kruskal.test(val~group, data=dat) ;

dunn.test(dat$val, dat$group, kw=FALSE, method="bh") ;

#################### Example 12.9.1 ####################

rm(list=ls()) ;

val	<- c(2,3,1,2,3,1,2,3,1,1,3,2,3,2,1,1,2,3,2,3,1,1,3,2,1,3,2) ;
group	<- factor(rep(1:3,9)) ;
id	<- factor(rep(1:9, each=3)) ;
friedman.test(val, group, id) ;	# group 별 차이
friedman.test(val, id, group) ;	# id 별 차이

#################### Example 12.10.1 ####################

rm(list=ls()) ;
dat	<- data.frame(id=seq(17), X=c(500,475,390,325,325,205,200,75,230,50,175,130,76,200,174,201,125),
				Y=c(525,130,325,190,90,295,180,74,420,60,105,148,75,250,102,151,130)) ;
cor.test(~ X + Y, data=dat, method="spearman") ;

#################### Example 12.10.2 ####################

rm(list=ls()) ;
dat_patient	<- data.frame(age=c(82,85,83,64,82,53,26,47,37,49,65,40,32,50,62,33,36,53,
						50,71,54,62,47,66,34,46,27,54,72,41,35,75,50,76,28),
				mineral=c(169.62,48.94,41.16,63.95,21.09,5.40,6.33,4.26,3.62,
						4.82,108.22,10.20,2.69,6.16,23.87,2.70,3.15,60.59,
						4.48,46.93,30.91,34.27,41.44,109.88,2.78,4.17,6.57,
						61.73,47.59,10.46,3.06,49.57,5.55,50.23,6.81)) ;
cor.test(~ age + mineral, data=dat_patient, method="spearman") ;
spearman_test(age ~ mineral, data=dat_patient) ;	# coin package, 표준정규분포 사용 (asymptotic approximation)

#################### Example 12.11.1 ####################

rm(list=ls()) ;
dat	<- data.frame(X=c(53.9,57.4,41.0,40.0,42.0,64.4,59.1,49.9,43.2),
			Y=c(163,164,156,151,152,167,165,153,155)) ;
comb_all	<- combn(nrow(dat), 2) ;	# 모든 가능한 index의 pair

S	<- sapply(seq(ncol(comb_all)), function(i) {
	ind_1	<- comb_all[1,i] ;
	ind_2	<- comb_all[2,i] ;

	delta_y	<- dat$Y[ind_2] - dat$Y[ind_1] ;
	delta_x	<- dat$X[ind_2] - dat$X[ind_1] ;

	return(ifelse(delta_x == 0, NA, delta_y/delta_x)) ;
}) ;
slope_hat	<- median(S) ;

intercept_hat_1	<- median(dat$Y - slope_hat*dat$X) ;	# 오차항 추정값 1

E	<- sapply(seq(ncol(comb_all)), function(i) {
	ind_1	<- comb_all[1,i] ;
	ind_2	<- comb_all[2,i] ;

	return(mean((dat$Y - slope_hat*dat$X)[c(ind_1, ind_2)])) ;
}) ;
intercept_hat_2	<- median(E) ;	# 오차항 추정값 2

plot(Y~X, data=dat) ;
abline(intercept_hat_1, slope_hat, lty=1, col="black") ;
abline(intercept_hat_2, slope_hat, lty=2, col="red") ;
