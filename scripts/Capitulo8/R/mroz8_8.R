# Exemplo 8.8
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo8")
library(lmtest)
library(sandwich)
library(car)
library(estimatr)

data(mroz, package ='wooldridge')
dados = mroz

# Primeira regressão
Reg1 <- lm(inlf ~ nwifeinc + educ + exper + expersq + age + kidslt6 + kidsge6, data = dados)
summary(Reg1)

# Regressão com erro padrão robusto
Reg2 <- lm_robust(inlf ~ nwifeinc + educ + exper + expersq + age + kidslt6 + kidsge6, data = dados, se_type = "stata")
summary(Reg2)
variaveis <- c("nwifeinc", "educ", "exper", "expersq",
               "age", "kidslt6", "kidsge6")

for (v in variaveis) {
  cat(v, " t =", coef(Reg2)[v] / sqrt(vcov(Reg2)[v, v]), "\n")
}