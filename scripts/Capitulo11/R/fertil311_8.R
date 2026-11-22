# Exemplo 11.8
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo11")
library(wooldridge)
library(multcomp)

#Regressão
Reg1 <- lm(cgfr ~ cpe + cpe_1 + cpe_2 + cgfr_1, data = fertil3)

summary(Reg1)