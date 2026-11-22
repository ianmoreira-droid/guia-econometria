# Exemplo 8.4
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo8")
library(lmtest)
library(sandwich)
library(car)

data(hprice1, package ='wooldridge')
dados = hprice1

# Reg1
Reg1 <- lm(price ~ lotsize + sqrft + bdrms, data = dados)
summary(Reg1)
dados$u <- residuals(Reg1)
dados$u2 <- dados$u^2

# Reg auxiliar do LM
Reg1_1 <- lm(u2 ~ lotsize + sqrft + bdrms, data = dados)
summary(Reg1_1)$fstatistic

LM1 <- nobs(Reg1_1) *summary(Reg1_1)$r.squared
pvalor1 <- pchisq(LM1, df = 3, lower.tail = FALSE)
LM1
pvalor1

# Reg2
Reg2 <- lm(lprice ~ llotsize + lsqrft + bdrms, data = dados)
summary(Reg2)
dados$uhat <- residuals(Reg2)
dados$uhat2 <- dados$uhat^2

Reg2_1 <- lm(uhat2 ~ llotsize + lsqrft + bdrms, data = dados)
summary(Reg2_1)$fstatistic

LM2 <- nobs(Reg2_1) *summary(Reg2_1)$r.squared
pvalor2 <- pchisq(LM2, df = 3, lower.tail = FALSE)
LM2
pvalor2