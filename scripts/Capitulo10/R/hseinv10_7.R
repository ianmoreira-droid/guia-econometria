# Exemplo 10.7
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo10")
library(wooldridge)

#Regressão
Reg <- lm(linvpc ~ lprice, data = hseinv)

summary(Reg)

Reg2 <- lm(linvpc ~ lprice + t, data = hseinv)

summary(Reg2)