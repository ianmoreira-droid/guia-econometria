#Exemplo 12.2
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo12")
library(wooldridge)
library(dplyr)

#Regressão
Reg <- lm(lprepop ~ lmincov + lusgnp + lprgnp + t, data = prminwge)

summary(Reg)

uhat <- residuals(Reg)
ts(prminwge, start = min(prminwge$year), frequency = 1)
Luhat <- dplyr::lag(uhat)

Reg2 <- lm(uhat ~ lmincov + lusgnp + lprgnp + t + Luhat, data = prminwge)

summary(Reg2)