# Exemplo 10.9
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo10")
library(wooldridge)

#Regressão
Reg <- lm(lprepop ~ lmincov + lusgnp + t, data = prminwge)

summary(Reg)