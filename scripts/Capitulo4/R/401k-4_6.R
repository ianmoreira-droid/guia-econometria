# Exemplo 4.6
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo4")
library(ggplot2)

data(k401k, package ='wooldridge')
dados = k401k

Reg <- lm(prate ~mrate + age + totemp, data = dados)
summary(Reg)

# Teste t e seu p-valor
t <- coef(Reg)["totemp"] / summary(Reg)$coefficients["totemp", "Std. Error"]
2 * pt(-abs(t), df = df.residual(Reg))
t