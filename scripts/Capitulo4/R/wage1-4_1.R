## Exemplos 4.1
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo4")
library(ggplot2)

data(wage1, package ='wooldridge')
dados = wage1

# Regressão
Reg <- lm(lwage ~ educ + exper + tenure, data = dados)

summary(Reg)

# Cálculo manual do teste t
coef <- coef(Reg)["exper"]
se <- summary(Reg)$coefficients["exper", "Std. Error"]

t <- coef / se
t

save(Reg, dados, file = "wage1-4_1.RData")