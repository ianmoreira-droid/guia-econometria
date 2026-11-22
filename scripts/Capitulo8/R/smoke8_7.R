# Exemplo 8.7
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo8")
library(lmtest)
library(sandwich)
library(car)

data(smoke, package ='wooldridge')
dados = smoke

# Primeira Reg
Reg1 <- lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn, data = dados)
summary(Reg1)

# Teste Breush-Pagan
bptest(Reg1)

dados$u <- residuals(Reg1)
dados$u2 <- dados$u^2
dados$lu2 <- log(dados$u2)

Reg1_1 <- lm(lu2 ~ lincome + lcigpric + educ + age + agesq + restaurn,
          data = dados)
dados$ghat <- predict(Reg1_1)
dados$w <- exp(-dados$ghat) #w=1/e^ghat

# MQGF
Reg2 <- lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn, 
           data = dados,
           weights = w)
summary(Reg2)