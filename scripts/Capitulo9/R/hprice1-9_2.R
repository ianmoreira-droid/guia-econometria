# Exemplo 9.2
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo9")
library(car)

data(hprice1, package ='wooldridge')
dados = hprice1

Reg1 <- lm(price ~ lotsize + sqrft + bdrms, data = dados)
summary(Reg1)

# Teste RESET de Ramsey
# Previsões
dados$yhat <- predict(Reg1)

dados$yhat2 <- dados$yhat^2
dados$yhat3 <- dados$yhat^3

Reg1_1 <- lm(price ~ lotsize + sqrft + bdrms + yhat2 + yhat3, data = dados)
linearHypothesis(Reg1_1, c("yhat2 = 0", "yhat3 = 0"))


Reg2 <- lm(lprice ~ llotsize + lsqrft + bdrms, data = dados)
summary(Reg2)

# Teste RESET de Ramsey
# Previsões
dados$lyhat <- predict(Reg2)

dados$lyhat2 <- dados$lyhat^2
dados$lyhat3 <- dados$lyhat^3

Reg2_1 <- lm(lprice ~ llotsize + lsqrft + bdrms + lyhat2 + lyhat3, data = dados)
linearHypothesis(Reg2_1, c("lyhat2 = 0", "lyhat3 = 0"))