#Exemplo 3.1 e 3.4
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo3")
library(ggplot2)

data(gpa1, package ='wooldridge')
dados = gpa1

#Regressão
GPAregress <- lm(colGPA ~ hsGPA + ACT, data = dados)

summary(GPAregress)

# 3.4
summary(GPAregress)$r.squared

save(GPAregress, dados, file = "gpa1.RData")
