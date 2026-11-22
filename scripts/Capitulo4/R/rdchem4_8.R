# Exemplo 4.8
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo8")

data(rdchem, package ='wooldridge')
dados = rdchem

#Regressão
Reg <- lm(lrd ~ lsales + profmarg, data = rdchem)
summary(Reg)

confint(Reg, "lsales", level = 0.95)
confint(Reg, "profmarg")