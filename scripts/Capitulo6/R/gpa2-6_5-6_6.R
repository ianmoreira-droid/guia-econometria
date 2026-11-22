# Exemplo 6.5 e 6.6
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo6")
library(wooldridge)

data(gpa2)
dados <- gpa2

#6.5
# Reg 1.0
Reg <- lm(colgpa ~ sat + hsperc + hsize + hsizesq, data = dados)
summary(Reg)
predict(Reg, newdata = data.frame(sat = 1200, hsperc = 30, hsize = 5, hsizesq = 25))

# Reg 1.1: centralizando as variáveis
dados$sat0 <- dados$sat - 1200
dados$hsperc0 <- dados$hsperc - 30
dados$hsize0 <- dados$hsize - 5
dados$hsizesq0 <- dados$hsizesq - 25

Reg1 <- lm(colgpa ~ sat0 + hsperc0 + hsize0 + hsizesq0, data = dados)
summary(Reg1)

# IC de 95% da média predita 
b <- coef(Reg1)["(Intercept)"]
se <- sqrt(vcov(Reg1)["(Intercept)", "(Intercept)"])
b + c(-1, 1) * 1.96 * se

# Intervalo de predição individual (Ex. 6.6)
z <- sqrt(
  summary(Reg1)$coefficients["(Intercept)", "Std. Error"]^2 +
    sigma(Reg1)^2
)
coef(Reg1)["(Intercept)"] - 1.96 *z
coef(Reg1)["(Intercept)"] + 1.96 *z