# Exemplo 10.5
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo10")
library(wooldridge)
library(car)

#Regressão
Reg <- lm(lchnimp ~ befile6 + affile6 + afdec6 +
            feb + mar + apr + may + jun + jul + aug + sep + oct + nov + dec,
          data = barium)

summary(Reg)
linearHypothesis(Reg, c("feb", "mar", "apr", "may", "jun", 
                             "jul", "aug", "sep", "oct", "nov", "dec"))