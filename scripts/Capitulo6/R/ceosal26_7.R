# Exemplo 6.7 
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo6")
library(wooldridge)

data(ceosal2)
dados <- ceosal2

Reg <- lm(lsalary ~ lsales + lmktval + ceoten, data = dados)
summary(Reg)

# Calculando o valor predito em log
4.504 + .163*log(5000) + .109*log(10000) + .0117*10

# Convertendo para o nível original
exp(7.013)

# Resíduos da regressão
dados$u_chap <- residuals(Reg)

# Fator de correção de smearing
dados$smear <- exp(dados$u_chap)
mean(dados$smear, na.rm = TRUE)

# Aplicando a correção
s <- mean(dados$smear, na.rm = TRUE)
exp(7.013)*s