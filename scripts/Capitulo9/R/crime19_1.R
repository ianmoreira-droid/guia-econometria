# Exemplo 9.1
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo9")
library(car)

data(crime1, package ='wooldridge')
dados = crime1

Reg1 <- lm(narr86 ~ pcnv + avgsen + tottime + ptime86 +
            qemp86 + inc86 + black + hispan, data = dados)

summary(Reg1)

Reg2 <- lm(narr86 ~ pcnv + pcnvsq + avgsen + tottime +
            ptime86 + pt86sq + qemp86 + inc86 + inc86sq +
            black + hispan, data = dados)

summary(Reg2)
# Teste conjunto
linearHypothesis(Reg2, c("pcnvsq = 0", "pt86sq = 0", "inc86sq = 0"))

# Ponto crítico das variáveis ao quadrado
-coef(Reg2)["pcnv"] / (2 * coef(Reg2)["pcnvsq"])

-coef(Reg2)["ptime86"] / (2 * coef(Reg2)["pt86sq"])

-coef(Reg2)["inc86"] / (2 * coef(Reg2)["inc86sq"])