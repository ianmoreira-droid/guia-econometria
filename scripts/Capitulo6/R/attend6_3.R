# Exemplo 6.3 
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo6")
library(wooldridge)

data(attend)
dados <- attend

Reg <- lm(stndfnl ~ atndrte + priGPA + ACT + I(priGPA^2) + I(ACT^2) + priGPA:atndrte, data = dados)
summary(Reg)

efeito_parcial <- coef(Reg)["atndrte"] +
  coef(Reg)["atndrte:priGPA"] * 2.59

efeito_parcial


