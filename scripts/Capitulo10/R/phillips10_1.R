#Exemplo 10.1
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo10")


data(phillips, package ='wooldridge')

#Regressão
Phillipsregress <- lm(inf ~ unem, 
                      data = phillips, 
                      subset = year <= 1996)
## se deixar sem a restrição do ano, vai ter mais observações e resultado será
## diferente
summary(Phillipsregress)

