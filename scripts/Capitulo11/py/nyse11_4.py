# Exemplo 11.4
import pandas as pd
import statsmodels.formula.api as smf
from wooldridge import data

# Carregar banco NYSE
nyse = data("nyse")

# Regressão
Reg1 = smf.ols("Q('return') ~ Q('return_1')", data=nyse).fit()

print(Reg1.summary())