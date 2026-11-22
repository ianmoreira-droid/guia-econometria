#Exemplo 3.3
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo3")
data(k401k, package ='wooldridge')
dados = k401k

#Regressão
Pensionregress <- lm(prate ~ mrate + age, data = dados)

summary(Pensionregress)
summary(Pensionregress)$r.squared


Reg2 <- lm(prate ~ mrate, data = dados)

summary(Reg2)
cor(dados$mrate, dados$age)
