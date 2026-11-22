# Exemplo 10.5
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo10")
library(wooldridge)

#Regressão
Reg <- lm(lchnimp ~ lchempi + lgas + lrtwex + befile6 + affile6 + afdec6, data = barium)

summary(Reg)
100 * (exp(coef(Reg)["afdec6"]) - 1)