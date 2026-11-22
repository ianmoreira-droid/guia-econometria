# Exemplo 8.2 
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo8")
library(wooldridge)
library(lmtest)
library(sandwich)
library(car)

data("gpa3")
dados <- gpa3

Reg <- lm(cumgpa ~ sat + hsperc + tothrs + female + black + white, 
          data = dados,
          subset = spring == 1)
summary(Reg)
linearHypothesis(Reg, c("black = 0", "white = 0"))


Reg1 <- lm(cumgpa ~ sat + hsperc + tothrs + female + black + white, 
          data = dados,
          subset = spring == 1)
robustos <- coeftest(Reg1, vcov. = vcovHC(Reg1, type = "HC1"))
robustos[c("sat", "hsperc", "tothrs", "female",
           "black", "white"), "t value"]
linearHypothesis(Reg1, c("black = 0", "white = 0"),
                 vcov. = vcovHC(Reg1, type = "HC1"))