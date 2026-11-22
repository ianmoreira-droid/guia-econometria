# Exemplo 6.1
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo6")
library(wooldridge)
library(multcomp)
library(readxl)

dados <- read_excel("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap6/hprice2.xls")

#Padronizando
dados$zprice <- (dados$price - mean(dados$price, na.rm = TRUE)) /
  sd(dados$price, na.rm = TRUE)

dados$znox <- (dados$nox - mean(dados$nox, na.rm = TRUE)) /
  sd(dados$nox, na.rm = TRUE)

dados$zcrime <- (dados$crime - mean(dados$crime, na.rm = TRUE)) /
  sd(dados$crime, na.rm = TRUE)

dados$zrooms <- (dados$rooms - mean(dados$rooms, na.rm = TRUE)) /
  sd(dados$rooms, na.rm = TRUE)

dados$zdist <- (dados$dist - mean(dados$dist, na.rm = TRUE)) /
  sd(dados$dist, na.rm = TRUE)

dados$zstratio <- (dados$stratio - mean(dados$stratio, na.rm = TRUE)) /
  sd(dados$stratio, na.rm = TRUE)

#Regressão
Reg <- lm(zprice ~ znox + zcrime + zrooms + zdist + zstratio, data = dados)

summary(Reg)

