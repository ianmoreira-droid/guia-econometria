# Exemplo 6.8 
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo6")
library(wooldridge)

data(ceosal2)
dados <- ceosal2

Reg <- lm(salary ~ sales + mktval + ceoten, data = dados)
summary(Reg)


Reg1 <- lm(lsalary ~ sales + mktval + ceoten, data = dados)

# Predição e intervalo de predição de 95%
p <- predict(Reg1, se.fit = TRUE)

lsalary_hat <- p$fit[1]
se_salary <- sqrt(sigma(Reg1)^2 + p$se.fit[1]^2)

critico <- qt(0.975, df.residual(Reg1))

lower_log <- lsalary_hat - critico * se_salary
upper_log <- lsalary_hat + critico * se_salary

lower_y <- exp(lower_log)
upper_y <- exp(upper_log)

lower_log
upper_log
lower_y
upper_y
