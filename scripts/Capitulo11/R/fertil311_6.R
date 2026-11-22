# Exemplo 11.6
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo11")
library(wooldridge)
library(multcomp)

# Calculando autocrrelação
fertil3 <- fertil3[order(fertil3$year), ]

cor(fertil3$gfr[-1], fertil3$gfr[-nrow(fertil3)])

cor(fertil3$pe[-1], fertil3$pe[-nrow(fertil3)])

#Regressão
Reg1 <- lm(cgfr ~ cpe, data = fertil3)

summary(Reg1)

Reg2 <- lm(cgfr ~ cpe + cpe_1 + cpe_2, data = fertil3)

summary(Reg2)