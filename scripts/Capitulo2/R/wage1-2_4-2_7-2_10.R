## Exemplos 2.4, 2.7 e 2.10
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo2")
library(ggplot2)

data(wage1, package ='wooldridge')
dados = wage1

# 2.4
Reg1 <- lm(wage ~ educ, data = dados)

summary(Reg1)

# Gráfico
ggplot(dados, aes(x = educ, y = wage)) +
  geom_point(color = "darkgreen") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Salário vs Anos de educação",
       x = "Educação (anos)",
       y = "Salário")
ggsave("wage1-1.png") 

# 2.7
predict(Reg1, newdata = data.frame(educ = mean(dados$educ)))

# 2.10
Reg2 <- lm(lwage ~ educ, data = dados)
summary(Reg2)
ggplot(dados, aes(x = educ, y = lwage)) +
  geom_point(color = "darkgreen") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Salário vs Anos de educação",
       x = "Educação (anos)",
       y = "Logsalário")
ggsave("wage1-2.png")