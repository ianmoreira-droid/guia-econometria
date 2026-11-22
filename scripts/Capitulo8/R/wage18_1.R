# Exemplo 8.1 
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo8")
library(wooldridge)
library(lmtest)
library(sandwich)

data("wage1")
dados <- wage1

# Homem casado
dados$marrmale <- as.integer(dados$married == 1 & dados$female == 0)

# Mulher casada
dados$marrfem <- as.integer(dados$married == 1 & dados$female == 1)

# Mulher solteira
dados$singfem <- as.integer(dados$married == 0 & dados$female == 1)

# Reg
Reg <- lm(lwage ~ marrmale + marrfem + singfem + educ + exper + expersq + tenure + tenursq, data = dados)
summary(Reg)

# Reg com erro-padrão robusto
Reg1 <- lm(lwage ~ marrmale + marrfem + singfem +
            educ + exper + expersq + tenure + tenursq,
          data = dados)

robustos <- coeftest(Reg1, vcov. = vcovHC(Reg1, type = "HC1"))
robustos[c("marrmale", "marrfem", "singfem", "educ",
           "exper", "expersq", "tenure", "tenursq"), "t value"]