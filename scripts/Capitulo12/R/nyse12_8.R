# Exemplo 12.8
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo12")
library(wooldridge)
library(multcomp)

#Regressão
Reg <- lm(return ~ return_1, data = nyse)

summary(Reg)

uhat <- residuals(Reg)
uhat2 <- uhat^2
t <-(coef(Reg)["return_1"] / summary(Reg)$coefficients["return_1", "Std. Error"])
t

nyse$uhat2 <- c(NA, NA, uhat2)
nyse$return_1 <- dplyr::lag(nyse$return, 1)
Reg1 <- lm(uhat2 ~ return_1, data = nyse, na.action = na.omit)
t1 <- coef(Reg1)["return_1"] / summary(Reg1)$coefficients["return_1", "Std. Error"]
t1

