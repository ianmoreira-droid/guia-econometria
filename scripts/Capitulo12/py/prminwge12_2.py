# Exemplo 12.2
import wooldridge
import pandas as pd
import statsmodels.api as sm

# Dados
prminwge = wooldridge.data('prminwge')

# Regressão
Reg = sm.OLS(
    prminwge['lprepop'],
    sm.add_constant(prminwge[['lmincov', 'lusgnp', 'lprgnp', 't']])
).fit()

print(Reg.summary())

uhat = Reg.resid

# Defasagem temporal
prminwge['uhat'] = uhat
prminwge['Luhat'] = prminwge['uhat'].shift(1)

# Segunda regressão
Reg2 = sm.OLS(
    prminwge['uhat'],
    sm.add_constant(
        prminwge[['lmincov', 'lusgnp', 'lprgnp', 't', 'Luhat']]
    ),
    missing='drop'
).fit()

print(Reg2.summary())