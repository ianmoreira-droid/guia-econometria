#Exemplo 12.7
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo12")
library(wooldridge)
library(dplyr)
library(prais)

#Regressão 12.2
# Passo 1
Reg <- lm(lprepop ~ lmincov + lusgnp + lprgnp + t, data = prminwge)

summary(Reg)

uhat <- residuals(Reg)
sigma <- summary(Reg)$sigma
se1 <- summary(Reg)$coefficients["lmincov", "Std. Error"]

# Passo 2
Reg1 <- lm(lmincov ~ lusgnp + lprgnp + t, data = prminwge)
rhat1 <- residuals(Reg1)

# Passo 3
a <- rhat1 * uhat

# Passo 4
g <- 2

ordem <- order(prminwge$t)
prminwge <- prminwge[ordem, ]
a <- a[ordem]

nhat <- sum(a^2, na.rm = TRUE)

for (h in 1:g) {
  a_lag <- dplyr::lag(a, n = h)
  prod <- a * a_lag
  
  w <- 1 - h / (g + 1)
  nhat <- nhat + 2 * w * sum(prod, na.rm = TRUE)
}
# Passo 5
se_robust <- (se1 / sigma)^2 * sqrt(nhat)

cat("n_hat =", nhat, "\n")
cat("SE robusto =", se_robust, "\n")

-0.212 / 0.04260487
# PW (FGLS)
ts(prminwge, start = min(prminwge$year), frequency = 1)
Reg2 <- prais_winsten(
  lprepop ~ lmincov + lusgnp + lprgnp + year,
  data = prminwge,
  index = "year"
)
summary(Reg2)