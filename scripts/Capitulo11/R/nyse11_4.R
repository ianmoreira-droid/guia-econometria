# Exemplo 11.4
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo11")
library(wooldridge)
library(multcomp)

#Regressão
Reg1 <- lm(return ~ return_1, data = nyse)

summary(Reg1)
