# Exemplo 12.6
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo12")


data(intdef, package ='wooldridge')

#Regressão
Reg <- lm(i3 ~ inf + def, data = intdef)

summary(Reg)

ts(intdef, start = min(intdef$year), frequency = 1)

uhat <- residuals(Reg)
Luhat <- dplyr::lag(uhat)

Reg1_2 <- lm(uhat ~ Luhat)
summary(Reg1_2)

#Regressão 2
Reg2 <- lm(ci3 ~ cinf + cdef, data = intdef)

summary(Reg2)

uhat2 <- residuals(Reg2)
Luhat2 <- dplyr::lag(uhat2)

Reg2_2 <- lm(uhat2 ~ Luhat2)
summary(Reg2_2)

cor(intdef$i3, intdef$i3_1, use = "complete.obs")
