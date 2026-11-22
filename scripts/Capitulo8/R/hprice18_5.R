# Exemplo 8.5
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo8")
library(lmtest)
library(sandwich)
library(car)

data(hprice1, package ='wooldridge')
dados = hprice1

Reg1 <- lm(lprice ~ llotsize + lsqrft + bdrms, data = dados)
summary(Reg1)

dados$lpricehat <- predict(Reg1)
dados$lpricehat2 <- dados$lpricehat^2
dados$uhat <- residuals(Reg1)
dados$uhat2 <- dados$uhat^2

Reg2 <- lm(uhat2 ~ lpricehat + lpricehat2, data = dados)

LM <- nobs(Reg2) *summary(Reg2)$r.squared
pvalor <- pchisq(LM, df = 2, lower.tail = FALSE)
LM
pvalor