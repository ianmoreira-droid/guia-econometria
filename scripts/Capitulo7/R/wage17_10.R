# Exemplo 7.10
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo7")
library(car)

data(wage1, package ='wooldridge')
dados = wage1

Reg <- lm(lwage ~ female + educ + female:educ + exper + expersq +
            tenure + tenursq, data = dados)
summary(Reg)

# Valor t
coef(Reg)["female:educ"] / sqrt(vcov(Reg)["female:educ", "female:educ"])

# Teste conjunto
linearHypothesis(Reg, c("female = 0", "female:educ = 0"))

# Retorno de educação para as mulheres
coef(Reg)["educ"] + coef(Reg)["female:educ"]

# Centraliza
dados$educc <- dados$educ - 12.5

Reg2 <- lm(lwage ~ female + educ + educc:female + exper + expersq +
            tenure + tenursq, data = dados)
coef(Reg2)["female"]