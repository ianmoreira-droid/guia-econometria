#Exemplo 3.2 e 3.6
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo3")
library(ggplot2)


data(wage1, package ='wooldridge')
dados = wage1

#Regressão 3.2
Wagregress <- lm(lwage ~ educ + exper + tenure, data = dados)

summary(Wagregress)
summary(Wagregress)$r.squared

save(Wagregress, dados, file = "lwage1.RData")

# Reg 3.6
Wagregress2 <- lm(lwage ~ educ, data = dados)

summary(Wagregress2)
summary(Wagregress2)$r.squared

save(Wagregress2, dados, file = "lwage1-6.RData")
