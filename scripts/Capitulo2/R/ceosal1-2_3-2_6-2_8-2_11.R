# Exemplos 2.3, 2.6, 2.8, 2.11 
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo2")
library(ggplot2)

data(ceosal1, package ='wooldridge')

# 2.3
Reg1 <- lm(salary ~ roe, data = ceosal1)
summary(Reg1)

ceosal1$salary_pred <- predict(Reg1)

# Gráfico 2.3
ggplot(ceosal1, aes(x = roe, y = salary_pred)) +
  geom_point(color = "darkgreen") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Salário do CEO vs ROE",
       x = "ROE (%)",
       y = "Salário Predito")
ggsave("CEOSal1-1.png")

# 2.6
head(data.frame(
  salary = ceosal1$salary,
  roe = ceosal1$roe,
  salaryhat = fitted(Reg1),
  uhat = resid(Reg1)
), 15)

# 2.8
summary(Reg1)$r.squared

# 2.11
Reg2 <- lm(lsalary ~ lsales, data = ceosal1)
summary(Reg2)

ceosal1$lsalary_pred <- predict(Reg2)

# Gráfico 2.11
ggplot(ceosal1, aes(x = lsales, y = lsalary_pred)) +
  geom_point(color = "darkgreen") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Log do Salário do CEO vs log das vendas",
       x = "Log(sales)",
       y = "Log(Salário) Predito")
ggsave("CEOSal1-2.png")