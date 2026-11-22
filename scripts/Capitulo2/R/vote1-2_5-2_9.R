# Exemplos 2.5 e 2.9
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo2")
library(readxl)
library(ggplot2)

dados <- read_excel("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap2/vote1.xls")

# 2.5
Reg1 <- lm(voteA ~ shareA, data = dados)
summary(Reg1)

#Gráfico 2.5
ggplot(dados, aes(x = shareA, y = voteA)) +
  geom_point(color = "darkgreen") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "% de votos vs % de gastos na campanha",
       x = "%gastos",
       y = "%votos")
ggsave("vote1-1.png") 

# 2.9
summary(Reg1)$r.squared
