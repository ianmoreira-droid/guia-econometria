#Exemplo 12.5
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo12")
library(dplyr)
library(car)
library(prais)
data(phillips, package ='wooldridge')

#Regressão 10.1
Reg <- lm(inf ~ unem, 
          data = phillips, 
          subset = year <= 1996)

summary(Reg)

ts(phillips, start = min(phillips$year), frequency = 1)

uhat <- residuals(Reg)
Luhat <- dplyr::lag(uhat)

Reg1_2 <- lm(uhat ~ Luhat)
summary(Reg1_2)

# Regressão PW
Reg2 <- prais_winsten(inf ~ unem, data = phillips, index = "year", subset = year <= 1996)

summary(Reg2)