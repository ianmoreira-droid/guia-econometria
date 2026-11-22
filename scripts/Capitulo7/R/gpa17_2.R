# Exemplo 7.2
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo7")
library(car)

data(gpa1, package ='wooldridge')
dados = gpa1

Reg <- lm(colGPA ~ PC + hsGPA + ACT, data = dados)
summary(Reg)

# Valor t
coef(Reg)["PC"] / sqrt(vcov(Reg)["PC", "PC"])

# Regressão para teste de PC
reg1 <- lm(colGPA ~ PC, data = dados)
coef(reg1)["PC"]
sqrt(vcov(reg1)["PC", "PC"])
coef(reg1)["PC"]/ sqrt(vcov(reg1)["PC", "PC"])