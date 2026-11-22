# Exemplo 12.4
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo12")
library(wooldridge)
library(dplyr)
library(car)
library(prais)

#Regressão
Reg <- lm(lchnimp ~ lchempi + lgas + lrtwex + befile6 + affile6 + afdec6, data = barium)

summary(Reg)

coef(summary(Reg))["afdec6", "t value"]

ts(barium, start = min(barium$t), frequency = 1)

Reg2 <- prais_winsten(
  lchnimp ~ lchempi + lgas + lrtwex + befile6 + affile6 + afdec6,
  data = barium,
  index = "t"
)

summary(Reg2)
coef(summary(Reg2))["afdec6", "t value"]
