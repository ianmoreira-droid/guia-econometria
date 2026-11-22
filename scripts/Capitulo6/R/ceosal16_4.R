# Exemplo 6.4 
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo6")
library(wooldridge)

data("ceosal1")
dados <- ceosal1

# 1° Reg
Reg1 <- lm(salary ~ sales + roe, data = dados)
summary(Reg1)

# 2° Reg
Reg2 <- lm(lsalary ~ lsales + roe, data = dados)
summary(Reg2)

# Soma dos quadrados salary e lsalary
media <- mean(dados$salary)
dados$dev2 <- (dados$salary - media)^2

TSS <- sum(dados$dev2, na.rm = TRUE)

TSS

medialog <- mean(dados$lsalary)
dados$dev2log <- (dados$lsalary - medialog)^2

TSSlog <-sum(dados$dev2log, na.rm = TRUE)

TSSlog