# Exemplo 4.8
import pandas as pd
import statsmodels.api as sm
from wooldridge import data

# Base de dados
dados = data('rdchem')

# Regressão
X = dados[['lsales', 'profmarg']]
X = sm.add_constant(X)

Reg = sm.OLS(dados['lrd'], X).fit()

print(Reg.summary())

# Intervalo de confiança de 95% para lsales
print(Reg.conf_int().loc['lsales'])

# Intervalo de confiança de 95% para profmarg
print(Reg.conf_int().loc['profmarg'])