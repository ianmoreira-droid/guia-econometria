# Exemplo 5.2
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo5")

data(bwght, package ='wooldridge')

#Regressão
Reg <- lm(lbwght ~ cigs + lfaminc, data = bwght)

summary(Reg)

Reg2 <- lm(lbwght ~ cigs + lfaminc, data = bwght, subset = 1:694)

summary(Reg2)

# Erros-padrão dos coeficientes
se_totaln <- summary(Reg)$coefficients["cigs", "Std. Error"]
se_n2 <- summary(Reg2)$coefficients["cigs", "Std. Error"]

# Razão entre os erros-padrão (Amostral) 
# Deu diferente do Stata pois a base aqui tem uma observação a mais
# não sendo uma diferença grande
se_totaln / se_n2

# Razão teórica (Populacional)
sqrt(1/2)