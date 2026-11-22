# Exemplo 7.11
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo7")
library(lmtest)
library(car)

data(mlb1, package ='wooldridge')
dados = mlb1

Reg <- lm(
  lsalary ~ years + gamesyr + bavg + hrunsyr + rbisyr + runsyr +
    fldperc + allstar + black + hispan +
    black:percblck + hispan:perchisp,
  data = dados
)

summary(Reg)

linearHypothesis(Reg,
  c("black = 0","hispan = 0","black:percblck = 0","hispan:perchisp = 0"))