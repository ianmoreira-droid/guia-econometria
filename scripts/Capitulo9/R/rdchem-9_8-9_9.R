# Exemplos 9.8 e 9.9
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo9")
library(car)
library(ggplot2)

data(rdchem, package ='wooldridge')
dados = rdchem

Reg1 <- lm(rdintens ~ sales + profmarg, data = dados)
summary(Reg1)

Reg2 <- lm(rdintens ~ sales + profmarg,
          data = dados,
          subset = sales < 20000)
summary(Reg2)

# Gráfico
Grafico <- ggplot(dados, aes(x = sales, y = rdintens)) +
  geom_point() +
  
  # Seta indicando o possível outlier
  annotate("segment",
           x = 34500, y = 5.6,
           xend = 39000, yend = 3.8,
           arrow = arrow(length = unit(0.2, "cm")),
           color = "black") +
  
  # Texto
  annotate("text",
           x = 34500, y = 6.1,
           label = "possible\noutlier",
           hjust = 0.5) +
  
  # Eixos
  scale_x_continuous(
    name = "firm sales (in millions of dollars)",
    breaks = c(0, 10000, 20000, 30000, 40000)
  ) +
  scale_y_continuous(
    name = "R&D as a percentage of sales",
    breaks = c(0, 5, 10)
  ) +
  
  # Aparência
  theme_classic() +
  theme(
    legend.position = "none",
    panel.background = element_rect(fill = "white"),
    plot.background = element_rect(fill = "white")
  )

Grafico

# Exportar
ggsave("figura9_8.png", plot = Grafico,
       width = 8, height = 6, dpi = 300)

#Exemplo 9.9
Reg3 <- lm(lrd ~ lsales + profmarg, data = dados)
summary(Reg3)

Reg4 <- lm(lrd ~ lsales + profmarg,
           data = dados,
           subset = sales < 20000)
summary(Reg4)