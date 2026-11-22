# Exemplo 10.10
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo10")
library(wooldridge)

#Detrending
reg_invpc_t <- lm(linvpc ~ t, data = hseinv)
hseinv$linvpc_dt <- resid(reg_invpc_t)

reg_price_t <- lm(lprice ~ t, data = hseinv)
hseinv$lprice_dt <- resid(reg_price_t)

#Regress
Reg <- lm(linvpc_dt ~ lprice_dt, data = hseinv)
summary(Reg)