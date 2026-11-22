# Exemplo 7.4
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo7")
library(car)

data(hprice1, package ='wooldridge')
dados = hprice1

Reg <- lm(lprice ~ llotsize + lsqrft + bdrms + colonial, data = dados)
summary(Reg)

# Efeito de ser colonial em %
coef(Reg)["colonial"]*100
