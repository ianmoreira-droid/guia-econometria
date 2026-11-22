import pandas as pd
import statsmodels.api as sm
from wooldridge import data

# Carregar a base
phillips = data("phillips")

# Selecionar apenas observações até 1996
phillips_1996 = phillips[phillips["year"] <= 1996]

# Regressão
X = phillips_1996["unem"]
X = sm.add_constant(X)

y = phillips_1996["inf"]

Phillipsregress = sm.OLS(y, X).fit()

# Resultados
print(Phillipsregress.summary())