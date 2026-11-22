#Exemplo 12.9
import wooldridge
import pandas as pd
import statsmodels.formula.api as smf

nyse = wooldridge.data('nyse')

# Regressão
Reg = smf.ols('Q("return") ~ return_1', data=nyse).fit()
print(Reg.summary())

uhat = Reg.resid
uhat2 = uhat**2

# Defasagens dos resíduos
nyse['uhat'] = uhat
nyse['uhat2'] = uhat2
nyse['luhat'] = nyse['uhat'].shift(1)
nyse['luhat2'] = nyse['uhat2'].shift(1)

# Regressão dos resíduos ao quadrado
Reg1 = smf.ols('uhat2 ~ luhat2', data=nyse).fit()
print(Reg1.summary())

t1 = Reg1.params['luhat2'] / Reg1.bse['luhat2']
print(t1)

# Regressão dos resíduos
Reg2 = smf.ols('uhat ~ luhat', data=nyse).fit()
print(Reg2.summary())

t2 = Reg2.params['luhat'] / Reg2.bse['luhat']
print(t2)