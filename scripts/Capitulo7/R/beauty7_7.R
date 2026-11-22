# Exemplo 7.7
rm(list = ls())
setwd("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Arquivos R/ExWooldridge/Capitulo7")
library(car)

dados <- read.csv("C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap7/beauty.csv")

dados$ordem <- ave(dados$female == 0, dados$female,
                   FUN = cumsum)
Reg1 <- lm(lwage ~ belavg + abvavg + educ + exper + expersq + married + black + union + goodhlth + south + bigcity + smllcity + service,
           data = dados, subset = female == 0 & ordem <= 700)
summary(Reg1)

dados$ordem2 <- ave(dados$female == 1, dados$female,
                    FUN = cumsum)
Reg2 <- lm(lwage ~ belavg + abvavg + educ + exper + expersq + married + black + union + goodhlth + south + bigcity + smllcity + service,
           data = dados, subset = female == 1 & ordem2 <= 409)
summary(Reg2)