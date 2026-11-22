#Exemplo 12.1
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo12")
library(dplyr)

data(phillips, package ='wooldridge')

#Regressão 10.1
Reg <- lm(inf ~ unem, 
                      data = phillips, 
                      subset = year <= 1996)

summary(Reg)

uhat <- residuals(Reg)
Luhat <- dplyr::lag(uhat)

Reg1_2 <- lm(uhat ~ Luhat)
summary(Reg1_2)

#Regressão 11.5
Reg2 <- lm(cinf ~ unem, 
          data = phillips, 
          subset = year <= 1996)

summary(Reg2)

uhat2 <- residuals(Reg2)
Luhat2 <- dplyr::lag(uhat2)

Reg2_2 <- lm(uhat2 ~ Luhat2)

summary(Reg2_2)