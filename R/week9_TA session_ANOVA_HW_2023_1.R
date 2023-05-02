PainRelief <- read.table("C:\\R_data\\PainRelief.csv", sep=',', header=T)
summary(PainRelief)

PainRelief$PainLevel <- factor(PainRelief$PainLevel)
PainRelief$Codeine <- factor(PainRelief$Codeine)
PainRelief$Acupuncture <- factor(PainRelief$Acupuncture)
summary(PainRelief)

anova(lm(Relief ~ PainLevel + Codeine + Acupuncture, data=PainRelief))
