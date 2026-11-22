# Exemplo 4.9
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo4")
library(car)

data(bwght, package ='wooldridge')
dados = bwght

#Regressão
Reg <- lm(bwght ~ cigs + parity + faminc + motheduc + fatheduc, data = dados)
summary(Reg)

# Teste conjunto
linearHypothesis(Reg, c("motheduc = 0", "fatheduc = 0"))