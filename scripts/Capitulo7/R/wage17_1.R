# Exemplo 7.1
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo7")
library(car)

data(wage1, package ='wooldridge')
dados = wage1

Reg1 <- lm(wage ~ female + educ + exper + tenure, data = dados)
summary(Reg1)

Reg2 <- lm(wage ~ female, data = dados)
summary(Reg2)