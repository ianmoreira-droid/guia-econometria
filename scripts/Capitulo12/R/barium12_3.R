# Exemplo 12.3
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo12")
library(wooldridge)
library(dplyr)
library(car)

#Regressão
Reg <- lm(lchnimp ~ lchempi + lgas + lrtwex + befile6 + affile6 + afdec6, data = barium)

summary(Reg)

uhat <- residuals(Reg)
barium <- barium %>%
  arrange(t) %>%
  mutate(
    L1_uhat = lag(uhat, 1),
    L2_uhat = lag(uhat, 2),
    L3_uhat = lag(uhat, 3)
  )

Reg2 <- lm(
  uhat ~ lchempi + lgas + lrtwex + befile6 + affile6 + afdec6 + 
    L1_uhat + L2_uhat + L3_uhat, 
  data = barium
  )

summary(Reg2)
names(coef(Reg2))
car::linearHypothesis(
  Reg2,
  c("L1_uhat = 0", "L2_uhat = 0", "L3_uhat = 0")
)