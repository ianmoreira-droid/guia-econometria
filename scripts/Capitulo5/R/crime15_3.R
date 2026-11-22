# Exemplo 5.3
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo5")

data(crime1, package ='wooldridge')

#Regressão
Reg <- lm(narr86 ~ pcnv + ptime86 + qemp86, data = crime1)

summary(Reg)
util <- residuals(Reg)

Reg2 <- lm(util ~ pcnv + avgsen + tottime + ptime86 + qemp86, data = crime1)

summary(Reg2)

# LM = N * R²
LM <- nobs(Reg) * summary(Reg2)$r.squared
print(LM)

# LM2 = N * R² arredondado para 4 casas decimais
LM2 <- nobs(Reg) * round(summary(Reg2)$r.squared, 4)
print(LM2)