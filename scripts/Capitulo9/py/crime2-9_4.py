# Exemplo 9.4
import pandas as pd
import wooldridge
import statsmodels.formula.api as smf

# Base de dados
dados = wooldridge.data('crime2')

# Reg1
Reg1 = smf.ols(
    'lcrmrte ~ unem + llawexpc',
    data=dados[dados['d87'] == 1]
).fit()

print(Reg1.summary())

# Reg2
Reg2 = smf.ols(
    'lcrmrte ~ unem + llawexpc + lcrmrt_1',
    data=dados[dados['year'] == 87]
).fit()

print(Reg2.summary())