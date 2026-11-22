# Exemplo 7.6
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo7")
library(car)

data(wage1, package ='wooldridge')
dados = wage1

# Homem casado
dados$marrmale <- as.integer(dados$married == 1 & dados$female == 0)

# Mulher casada
dados$marrfem <- as.integer(dados$married == 1 & dados$female == 1)

# Mulher solteira
dados$singfem <- as.integer(dados$married == 0 & dados$female == 1)

Reg1 <- lm(lwage ~ marrmale + marrfem + singfem + educ + exper + expersq + tenure + tenursq, data = dados)
summary(Reg1)

L <- c("singfem" = 1, "marrfem" = -1)
b <- coef(Reg1)[names(L)]; V <- vcov(Reg1)[names(L), names(L)]
est <- sum(L * b); se <- sqrt(t(L) %*% V %*% L)
cat("Coeficiente:", est, "\nt:", est/se, "\n")
qt(0.975, df = df.residual(Reg1))