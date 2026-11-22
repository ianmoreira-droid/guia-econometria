# Exemplo 7.8
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo7")
library(car)

data(lawsch85, package ='wooldridge')
dados = lawsch85

dados$r61_100 <- ifelse(dados[, 1] >= 61 & dados[, 1] <= 100, 1, 0)

Reg <- lm(lsalary ~ top10 + r11_25 + r26_40 +
            r41_60 + r61_100 + LSAT + GPA + llibvol + lcost, data = dados)
summary(Reg)

# Efeito de estar no top 10 em %
100 * (exp(coef(Reg)["top10"]) - 1)