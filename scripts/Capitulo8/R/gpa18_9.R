# Exemplo 8.9
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo8")
library(estimatr)
library(readxl)

dados <- read_excel("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap8/gpa1.xls")

# Primeira regressão
Reg1 <- lm(PC ~ hsGPA + ACT + parcoll, data = dados)
summary(Reg1)

dados$phat <- predict(Reg1)
dados$hhat <- dados$phat*(1-dados$phat)
dados$w <- 1/dados$hhat

# Reg robusta, mostrando erro padrão
Reg2 <- lm_robust(PC ~ hsGPA + ACT + parcoll, 
                  data = dados, 
                  se_type = "stata")
variaveis <- c("hsGPA", "ACT", "parcoll")

for (v in variaveis) {
  cat(v, " se =", sqrt(vcov(Reg2)[v, v]), "\n")
}

# MQGF
Reg3 <- lm(PC ~ hsGPA + ACT + parcoll, 
           data = dados,
           weights = w)
summary(Reg3)