# Exemplo 9.10
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo9")

data(infmrt, package ='wooldridge')
dados = infmrt

Reg1 <- lm(infmort ~ lpcinc + lphysic + lpopul,
          data = dados,
          subset = d90 == 1)
summary(Reg1)

Reg2 <- lm(infmort ~ lpcinc + lphysic + lpopul,
           data = dados,
           subset = d90 == 1 & DC == 0)
summary(Reg2)