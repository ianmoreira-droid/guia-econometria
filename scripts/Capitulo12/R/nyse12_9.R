# Exemplo 12.9
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo12")
library(wooldridge)
library(multcomp)

#Regressão
Reg <- lm(return ~ return_1, data = nyse)

summary(Reg)

uhat <- residuals(Reg)
uhat2 <- uhat^2

ts(nyse, start = min(nyse$t), frequency = 1)
luhat <- dplyr::lag(uhat)
luhat2 <- dplyr::lag(uhat2)

nyse$uhat2 <- c(NA, NA, uhat2)
nyse$luhat2 <- c(NA, NA, luhat2)
Reg1 <- lm(uhat2 ~ luhat2, data = nyse)
summary(Reg1)
t1 <-(coef(Reg1)["luhat2"] / summary(Reg1)$coefficients["luhat2", "Std. Error"])
t1

Reg2 <- lm(uhat ~ luhat, data = nyse)
summary(Reg2)
t2 <-(coef(Reg2)["luhat"] / summary(Reg2)$coefficients["luhat", "Std. Error"])
t2
