#Exemplo 11.5
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo11")
library(wooldridge)
library(car)

#Regressão
Reg <- lm(cinf ~ unem, 
                      data = phillips, 
                      subset = year <= 1996)

summary(Reg)
resultado <- deltaMethod(Reg, "-(Intercept) / unem")

resultado$Estimate
resultado$`2.5 %`
resultado$`97.5 %`