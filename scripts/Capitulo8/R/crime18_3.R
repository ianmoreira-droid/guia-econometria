# Exemplo 8.3
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo8")
library(lmtest)
library(sandwich)
library(car)

data(crime1, package ='wooldridge')
dados = crime1
dados$avgsensq <- dados$avgsen^2

Reg <- lm(narr86 ~ pcnv + avgsen + avgsensq + ptime86 + qemp86 + inc86 + black + hispan, data = dados)
summary(Reg)

linearHypothesis(Reg, c("avgsen = 0", "avgsensq = 0"))
coeftest(Reg, vcov = vcovHC(Reg, type = "HC1"))

# LM usual
Reg1 <- lm(narr86 ~ pcnv + ptime86 + qemp86 + inc86 + black + hispan, data = dados)
dados$u <- residuals(Reg1)

Reg2 <- lm(u ~ pcnv + avgsen + avgsensq + ptime86 + qemp86 + inc86 + black + hispan, data = dados)
LM <- nobs(Reg2) * summary(Reg2)$r.squared
pvalor1 <- pchisq(LM, df = 2, lower.tail = FALSE)
LM
pvalor1

# LM robusto
dados$uhat <- residuals(Reg1)

Reg3 <- lm(avgsen ~ pcnv + ptime86 + qemp86 + inc86 + black + hispan, data = dados)
dados$r_avgsen <- residuals(Reg3)

Reg4 <- lm(avgsensq ~ pcnv + ptime86 + qemp86 + inc86 + black + hispan, data = dados)
dados$r_avgsen2 <- residuals(Reg4)

dados$z1 <- dados$r_avgsen * dados$uhat
dados$z2 <- dados$r_avgsen2 * dados$uhat
dados$one <- 1

Reg5 <- lm(one ~ z1 + z2 - 1, data = dados)

# Equivalente a e(N) - e(rss) e chi2tail(2,e(N)-e(rss))
nobs(Reg5) - sum(residuals(Reg5)^2)
pchisq(nobs(Reg5) - sum(residuals(Reg5)^2),
       df = 2, lower.tail = FALSE)