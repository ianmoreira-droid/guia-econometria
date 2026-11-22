# Exemplo 8.6
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo8")
library(lmtest)
library(sandwich)
library(car)
library(estimatr)
library(readxl)

dados <- read_excel("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap8/401ksubs.xls")
dados <- subset(dados, fsize == 1)
dados$age25_2 <- (dados$age - 25)^2

# Primeira Reg
Reg1 <- lm_robust(nettfa ~ inc, data = dados, se_type = "stata")
summary(Reg1)
dados$uhat1 <- residuals(Reg1)
dados$uhat1_2 <- dados$uhat1^2
Reg1_1 <- lm(uhat1_2 ~ inc, data = dados)

display <- coef(Reg1_1)["inc"] / sqrt(vcov(Reg1_1)["inc", "inc"])
cat("t de inc =", display, "\n")

# Segunda Reg
Reg2 <- lm(nettfa ~ inc, data = dados, weights = 1/inc)
summary(Reg2)
r2_r <- summary(Reg2)$r.squared

# Terceira Reg
Reg3 <- lm_robust(nettfa ~ inc + age25_2 + male + e401k, data = dados, se_type = "stata")
summary(Reg3)

# Quarta Reg
Reg4 <- lm(nettfa ~ inc + age25_2 + male + e401k, data = dados, weights = 1/inc)
summary(Reg4)
r2_ur <- summary(Reg4)$r.squared
linearHypothesis(Reg4, c("age25_2 = 0", "male = 0", "e401k = 0"))

# Teste F da 2 e 4
F <- ((r2_ur - r2_r)/3) / ((1 - r2_ur)/2012)

cat("F =", F, "\n")
cat("p-valor =", pf(F, 3, 2012, lower.tail = FALSE), "\n")