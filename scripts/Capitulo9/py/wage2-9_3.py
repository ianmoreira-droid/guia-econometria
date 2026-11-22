# Exemplo 9.3
import pandas as pd
import wooldridge
import statsmodels.formula.api as smf

# Base de dados
dados = wooldridge.data('wage2')

# Reg1
Reg1 = smf.ols(
    'lwage ~ educ + exper + tenure + married + south + urban + black',
    data=dados
).fit()

print(Reg1.summary())

# Reg2
Reg2 = smf.ols(
    'lwage ~ educ + exper + tenure + married + south + urban + black + IQ',
    data=dados
).fit()

print(Reg2.summary())

# Reg3
Reg3 = smf.ols(
    'lwage ~ educ + exper + tenure + married + south + urban + black + IQ + IQ:educ',
    data=dados
).fit()

print(Reg3.summary())