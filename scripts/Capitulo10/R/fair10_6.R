# Exemplo 10.6
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo10")
library(wooldridge)

#Regressão
Reg <- lm(demvote ~ partyWH + incum + pWHgnews + pWHinf, 
          data = fair, 
          subset = year < 1996)

summary(Reg)
# Prever valor em 1996
fair$demvote_hat <- predict(Reg, newdata = fair)

fair[fair$year == 1996, c("year", "demvote", "demvote_hat")]