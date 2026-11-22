#Exemplo 3.5
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo3")
library(ggplot2)

data(crime1, package ='wooldridge')
dados = crime1

#Regressão
Crimeregress <- lm(narr86 ~ pcnv + ptime86 + qemp86, data = dados)

summary(Crimeregress)
summary(Crimeregress)$r.squared

save(Crimeregress, dados, file = "crime1.RData")

#Regressão 2
Crimeregress2 <- lm(narr86 ~ pcnv + avgsen + ptime86 + qemp86, data = dados)

summary(Crimeregress2)
summary(Crimeregress2)$r.squared

save(Crimeregress2, dados, file = "crime1-2.RData")