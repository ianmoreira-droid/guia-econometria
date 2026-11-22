# Exemplo 6.2
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo6")
library(wooldridge)
library(ggplot2)

dados <- read_excel("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap6/hprice2.xls")

#Regressão
Reg <- lm(lprice ~ lnox + ldist + rooms + I(rooms^2) + stratio, data = dados)
summary(Reg)

# Gráfico log(price) e rooms
b <- coef(Reg)
dados$lnprice2 <- b[1] + b["rooms"]*dados$rooms + b["I(rooms^2)"]*dados$rooms^2

png("Exemplo6_2.png", width = 1200, height = 800)
plot(dados$rooms, dados$lnprice2, type = "l",
     main = "Figure 6.1 log(price) as a quadratic function of rooms",
     xlab = "rooms", ylab = "lnprice2", ylim = c(6, 18),
     xaxt = "n")
axis(1, at = 4.4)
dev.off()

# Valor ótimo de quartos
abs(coef(Reg)["rooms"]) / (2 * coef(Reg)["I(rooms^2)"])

# Efeitos marginais para 5, 6 e 7 quartos
b["rooms"] + 2*b["I(rooms^2)"]*c(5, 6, 7)