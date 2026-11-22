# Exemplo 4.3
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo4")
library(ggplot2)

data(gpa1, package ='wooldridge')
dados = gpa1

#Regressão
Reg <- lm(colGPA ~ hsGPA + ACT + skipped, data = dados)

summary(Reg)
summary(Reg)$r.squared

save(Reg, dados, file = "Exemplo4_3.RData")

# Estisticas t 
coef(Reg)["skipped"]/summary(Reg)$coefficients["skipped", "Std. Error"]
coef(Reg)["hsGPA"]/summary(Reg)$coefficients["hsGPA", "Std. Error"]
coef(Reg)["ACT"]/summary(Reg)$coefficients["ACT", "Std. Error"]