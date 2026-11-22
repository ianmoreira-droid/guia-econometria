# Exemplo 7.11
import statsmodels.formula.api as smf
from wooldridge import data
import pandas as pd

dados = data('mlb1')

Reg = smf.ols(
    formula='lsalary ~ years + gamesyr + bavg + hrunsyr + rbisyr + runsyr + '
            'fldperc + allstar + black + hispan + '
            'black:percblck + hispan:perchisp',
    data=dados
).fit()

print(Reg.summary())

# Teste conjunto
teste = Reg.f_test(
    'black = 0, hispan = 0, black:percblck = 0, hispan:perchisp = 0'
)

print(teste)