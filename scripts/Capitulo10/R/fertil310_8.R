# Exemplo 10.8
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo10")
library(wooldridge)
library(multcomp)
#Regressão
Reg1 <- lm(gfr ~ pe + ww2 + pill + t, data = fertil3)

summary(Reg1)

Reg2 <- lm(gfr ~ pe + ww2 + pill + t + tsq, data = fertil3)

summary(Reg2)