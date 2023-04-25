#------------- 1-1. Time-series plot (Obesity) -------------#
# Load data
'''
setwd('경로') : working directory 설정
'''
setwd("C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/local_health")
obesity <- read.csv("obesity.csv")
head(obesity)

# Plot
'''
windows() : 새로운 창 생성
par(mfrow=c(행,열)) : 멀티프레임 행/열 지정 > 한 창 내에 다량의 그래프 생성 가능
plot(x축,y축,type="종류",lwd=두께,xlab="x축이름",ylab="y축이름",col="그래프색상",main="제목")
'''
windows()
par(mfrow=c(2,1))
# 조율 그래프
plot(obesity$year, obesity$crude,type="l", lwd=2,
     xlab="Year", ylab="Crude Obesity", col="red",
     main="Gwanakgu obesity prevalence (Crude)")
# 표준화율 그래프
plot(obesity$year, obesity$adjusted,type="l", lwd=2,
     xlab="Year", ylab="Adjusted Obesity", col="blue",
     main="Gwanakgu obesity prevalence (Adjusted)")


#------------- 1-2. Map (Hypertension) -------------#
# Load Packages
install.packages("Rcpp")
# library(dplyr)
library(sf)
library(ggplot2)

# Load data 
setwd("C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/local_health")
hypertension <- read.csv("hypertension.csv", 
                         fileEncoding = "CP949", encoding = "UTF-8") 
head(hypertension)

setwd('C:/work/Crystal/GitHub/2023_HealthStatistics/R/data/local_health/shp')
'''
read_sf("파일명.shp") : shp 파일 읽어오기
'''
sgg_sf <- read_sf("sigungu2.shp")
sgg_sf

# Transform CRS to WGS84(4326)
# sgg_sf <- sgg_sf %>% st_transform(4326)
'''
st_transform(sgg_sf,4326) : CRS 변경
- 4326 : WGS 84 번호
'''
sgg_sf = st_transform(sgg_sf,4326)
sgg_sf

# Merge : sgg_sf & hypertension
'''
as.numeric() : 숫자형 변수로 변환
'''
hypertension$SIG_CD<-as.numeric(hypertension$code)
'''
merge(변수1,변수2) : 두 변수 합치기
by="기준" : 합 칠 때 기준이 되는 열
all.x=True면 모든 독립변수(X) 입력, FALSE면 모두 입력하지 않음
duplicateGeom=TRUE면 중복되는 경우에도 삭제하지 않음, FALSE면 중복되는 경우 삭제
'''
sgg_hypertension <- merge(sgg_sf, hypertension, by="SIG_CD", all.x=TRUE, duplicateGeom=TRUE)

# Map
windows()
'''
ggplot(변수) : 지도 그리기
geom_sf(aes(fill=crude)) : fill=crude면, adjusted면
scale_fill_distiller() : 
theme() : 지도 디자인 설정
- hjust=0.5 : 가운데 정렬
legend position=c(가로 : 범위 위치 좌표 지정
'''
# sgg_hypertension %>% 
ggplot(sgg_hypertension) + ggtitle("Hypertension - crude rate") + 
geom_sf(aes(fill=crude)) +
scale_fill_distiller(palette="Blues", direction = 1, name="Crude rate") +
theme(plot.title = element_text(hjust=0.5, face='bold', size=15),legend.position = c(0.9, 0.4))

windows()
# sgg_hypertension %>% 
ggplot(sgg_hypertension) + ggtitle("Hypertension - adjusted rate") + 
geom_sf(aes(fill=adjusted)) +
scale_fill_distiller(palette="Blues", direction = 1, name="Adjusted rate") +
theme(plot.title = element_text(hjust=0.5, face='bold', size=15),legend.position = c(0.9, 0.4))


# With more options...
windows()
# sgg_hypertension %>% 
ggplot(sgg_hypertension) + ggtitle("Hypertension - adjusted rate") + 
geom_sf(aes(fill=adjusted)) +
scale_fill_distiller(palette="Reds", direction = 1, name="Adjusted rate") +
theme_bw() +
theme(plot.title = element_text(hjust=0.5, face='bold', size=15),
      strip.text.x = element_text(size=10, face = "bold", margin = margin(0, 2, 0, 0)),
      strip.text.y = element_text(size=10, face = "bold", margin = margin(0, 2, 0, 0), angle = 90),
      strip.background = element_rect(color = "white"),
      plot.background = element_rect(fill = NA, color = NA),
      panel.background = element_rect(fill = NA, color = NA),
      legend.background = element_rect(fill = NA, color = NA),
      legend.position = c(0.9, 0.4),
      axis.text = element_blank(), axis.title = element_blank(),
      axis.line = element_blank(),axis.ticks = element_blank(),
      axis.text.x = element_blank(),
      panel.border = element_blank(),
      panel.grid.major = element_blank())

