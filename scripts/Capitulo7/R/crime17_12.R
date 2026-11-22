# Exemplo 7.12
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo7")
library(car)
library(readxl)

dados <- read_excel("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap7/crime1.xls")

Reg <- lm(arr86 ~ pcnv + avgsen + tottime + ptime86 + qemp86, data = dados)
summary(Reg)

linearHypothesis(Reg, c("avgsen = 0", "tottime = 0"))