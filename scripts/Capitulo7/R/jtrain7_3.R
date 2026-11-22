# Exemplo 7.3
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo7")
library(car)

data(jtrain, package ='wooldridge')
dados = jtrain

Reg <- lm(hrsemp ~ grant + lsales + lemploy, data = dados, subset = year == 1988)
summary(Reg)

summary(Reg)$coefficients["grant", "t value"]
summary(Reg)$coefficients["lemploy", "t value"]