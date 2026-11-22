# Exemplo 11.7
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo11")
library(wooldridge)
library(multcomp)

#Regressão1
Reg <- lm(lhrwage ~ loutphr + t, data = earns)

summary(Reg)

# Autocorrelação
Reg1_1 <- lm(lhrwage ~ t, data = earns)
earns$u_hrwage <- residuals(Reg1_1)

Reg1_2 <- lm(loutphr ~ t, data = earns)
earns$u_outphr <- residuals(Reg1_2)

earns <- earns[order(earns$t), ]

cor(earns$u_hrwage, dplyr::lag(earns$u_hrwage), use = "complete.obs")

cor(earns$u_outphr, dplyr::lag(earns$u_outphr), use = "complete.obs")

#Regressão 2
Reg2 <- lm(ghrwage ~ goutphr, data = earns)

summary(Reg2)