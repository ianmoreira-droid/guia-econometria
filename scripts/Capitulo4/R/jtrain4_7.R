# Exemplo 4.7
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo4")
library(car)

data(jtrain, package ='wooldridge')
dados = jtrain

Reg <- lm(lscrap ~ hrsemp + lsales + lemploy,
          data = dados,
          subset = year == 1987 & union == 0)
summary(Reg)
# Efeito de 5 horas adicionais
100 * 5 * coef(Reg)["hrsemp"]

coef(Reg)["hrsemp"] / sqrt(vcov(Reg)["hrsemp", "hrsemp"])

pt(
  coef(Reg)["hrsemp"] / sqrt(vcov(Reg)["hrsemp", "hrsemp"]),
  df = df.residual(Reg)
)