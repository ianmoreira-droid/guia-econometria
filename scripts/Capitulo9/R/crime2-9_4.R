# Exemplo 9.4
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo9")
library(car)

data(crime2, package ='wooldridge')
dados = crime2

Reg1 <- lm(lcrmrte ~ unem + llawexpc,
           data = dados,
           subset = d87 == 1)
summary(Reg1)

Reg2 <- lm(lcrmrte ~ unem + llawexpc + lcrmrt_1,
           data = dados,
           subset = year == 87)
summary(Reg2)