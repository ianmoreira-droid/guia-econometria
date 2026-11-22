# Exemplo 10.2
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo10")


data(intdef, package ='wooldridge')

#Regressão
Reg10_2 <- lm(i3 ~ inf + def, data = intdef)

summary(Reg10_2)

