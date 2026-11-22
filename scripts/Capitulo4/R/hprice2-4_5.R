# Exemplo 4.5
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo4")
library(wooldridge)
library(multcomp)
library(readxl)

dados <- read_excel("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap4/hprice2.xls")

# Regressão
Reg <- lm(lprice ~ lnox + ldist + rooms + stratio, data = dados)

summary(Reg)

# Estatistica t
(coef(Reg)["lnox"] + 1) / summary(Reg)$coefficients["lnox", "Std. Error"]