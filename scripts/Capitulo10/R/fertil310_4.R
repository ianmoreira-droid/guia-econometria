# Exemplo 10.4
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo10")
library(wooldridge)
library(multcomp)
#Regressão
Reg1 <- lm(gfr ~ pe + ww2 + pill, data = fertil3)

summary(Reg1)

Reg2 <- lm(gfr ~ pe + + pe_1 + pe_2 +  ww2 + pill, data = fertil3)

summary(Reg2)

propensao_lp <- glht(Reg2, linfct = "pe + pe_1 + pe_2 = 0")
summary(propensao_lp)
confint(propensao_lp)