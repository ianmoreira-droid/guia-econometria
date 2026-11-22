# Exemplo 4.3
import pandas as pd
import statsmodels.formula.api as smf
from wooldridge import data

# Importar base de dados
dados = data('gpa1')

# Regressão
Reg = smf.ols(
    formula='colGPA ~ hsGPA + ACT + skipped',
    data=dados
).fit()

print(Reg.summary())

# R²
print(Reg.rsquared)

# Estatísticas t
print(Reg.tvalues['skipped'])
print(Reg.tvalues['hsGPA'])
print(Reg.tvalues['ACT'])