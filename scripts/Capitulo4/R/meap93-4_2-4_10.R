# Exemplos 4.2 e 4.10
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo4")
library(ggplot2)

data(meap93, package ='wooldridge')
dados = meap93

dados$b_s <- dados$benefits / dados$salary

# Exemplo 4.2
Regress4_2 <- lm(math10 ~ totcomp + staff + enroll, data = dados)

summary(Regress4_2)
summary(Regress4_2)$r.squared
coef(summary(Regress4_2))["enroll", "t value"]

Regress4_2_1 <- lm(math10 ~ ltotcomp + lstaff + lenroll, data = dados)
summary(Regress4_2_1)
coef(summary(Regress4_2_1))["lenroll", "t value"]


# Exemplo 4.10 
Regress4_10 <- lm(lsalary ~ b_s, data = dados)
summary(Regress4_10)

# teste t manual 
# H0: Beta1 = -1
coef <- coef(Regress4_10)["b_s"]
se <- summary(Regress4_10)$coefficients["b_s", "Std. Error"]
t <- (coef-(-1))/se
t
# Adendo o resultado deu diferente do Stata pois o se no Stata foi arredondado
# para 0.200, e aqui não foi, mas a estatistica passa nos testes assim como no Stata

Regress4_10_1 <- lm(lsalary ~ b_s + lenroll + lstaff + droprate + gradrate, data = dados)
summary(Regress4_10_1)

Regress4_10_2 <- lm(lsalary ~ b_s + lenroll + lstaff, data = dados)
summary(Regress4_10_2)

(coef(summary(Regress4_10_2))["b_s", "Estimate"] + 1) /
  coef(summary(Regress4_10_2))["b_s", "Std. Error"]

save(Regress4_2, Regress4_2_1, Regress4_10, Regress4_10_1, Regress4_10_2, dados, file = "meap93.RData")