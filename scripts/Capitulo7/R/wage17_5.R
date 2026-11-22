# Exemplo 7.5
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo7")
library(car)

data(wage1, package ='wooldridge')
dados = wage1

Reg1 <- lm(lwage ~ female + educ + exper + expersq + tenure + tenursq, data = dados)
summary(Reg1)

# Efeito porcentagem de ser mulher
100 * (exp(coef(Reg1)["female"]) - 1)