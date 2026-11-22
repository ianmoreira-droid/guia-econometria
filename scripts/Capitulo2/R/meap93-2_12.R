# Exemplo 2.12
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo2")
library(ggplot2)

data(meap93, package ='wooldridge')
dados = meap93

#Regressão
Math10regress <- lm(math10 ~ lnchprg, data = dados)

summary(Math10regress)
summary(Math10regress)$r.squared

save(Math10regress, dados, file = "meap93.RData")
