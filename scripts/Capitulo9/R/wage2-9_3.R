# Exemplo 9.3
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo9")
library(car)

data(wage2, package ='wooldridge')
dados = wage2

Reg1 <- lm(lwage ~ educ + exper + tenure + married + south + urban + black, data = dados)
summary(Reg1)

Reg2 <- lm(lwage ~ educ + exper + tenure + married + south + urban + black + IQ, data = dados)
summary(Reg2)

Reg3 <- lm(lwage ~ educ + exper + tenure + married + south + urban + black + IQ + IQ:educ, data = dados)
summary(Reg3)