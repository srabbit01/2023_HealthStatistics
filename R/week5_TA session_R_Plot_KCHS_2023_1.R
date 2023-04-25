#------------- 1-1. Time-series plot (Obesity) -------------#
# Load data
setwd("C:/R_data/지역사회건강조사 실습파일")
obesity <- read.csv("obesity.csv")
head(obesity)

# Plot
windows()
par(mfrow=c(2,1))

plot(obesity$year, obesity$crude,type="l", lwd=2,
     xlab="Year", ylab="Crude Obesity", col="red",
     main="Gwanakgu obesity prevalence (Crude)")

plot(obesity$year, obesity$adjusted,type="l", lwd=2,
     xlab="Year", ylab="Adjusted Obesity", col="blue",
     main="Gwanakgu obesity prevalence (Adjusted)")


#------------- 1-2. Map (Hypertension) -------------#
# Load Packages
library(dplyr)
library(sf)
library(ggplot2)

# Load data 
setwd('C:/R_data/지역사회건강조사 실습파일')
hypertension <- read.csv("hypertension.csv", 
                         fileEncoding = "CP949", encoding = "UTF-8") 
head(hypertension)

setwd('C:/R_data/지역사회건강조사 실습파일/shp')
sgg_sf <- read_sf("sigungu2.shp")
sgg_sf

# Transform CRS to WGS84(4326)
sgg_sf <- sgg_sf %>% st_transform(4326)
sgg_sf

# Merge : sgg_sf & hypertension
hypertension$SIG_CD<-as.numeric(hypertension$code)
sgg_hypertension <- merge(sgg_sf, hypertension, by="SIG_CD", all.x=TRUE, duplicateGeom=TRUE)

# Map
windows()
sgg_hypertension %>% 
  ggplot() + ggtitle("Hypertension - crude rate") + 
  geom_sf(aes(fill=crude)) +
  scale_fill_distiller(palette="Blues", direction = 1, name="Crude rate") +
  theme(plot.title = element_text(hjust=0.5, face='bold', size=15),legend.position = c(0.9, 0.4))

windows()
sgg_hypertension %>% 
  ggplot() + ggtitle("Hypertension - adjusted rate") + 
  geom_sf(aes(fill=adjusted)) +
  scale_fill_distiller(palette="Blues", direction = 1, name="Adjusted rate") +
  theme(plot.title = element_text(hjust=0.5, face='bold', size=15),legend.position = c(0.9, 0.4))


# With more options...
windows()
sgg_hypertension %>% 
  ggplot() + ggtitle("Hypertension - adjusted rate") + 
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

