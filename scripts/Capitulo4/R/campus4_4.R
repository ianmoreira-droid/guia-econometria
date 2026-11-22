# Exemplo 4.4
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo4")
library(ggplot2)

data(campus, package ='wooldridge')
dados = campus

Reg <- lm(lcrime ~lenroll, data = dados)

summary(Reg)

(coef(Reg)["lenroll"] - 1) / summary(Reg)$coefficients["lenroll", "Std. Error"]