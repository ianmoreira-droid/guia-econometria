# Exemplo 10.3
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo10")
library(wooldridge)

#Regressão
Reg <- lm(lprepop ~ lmincov + lusgnp, data = prminwge)

summary(Reg)