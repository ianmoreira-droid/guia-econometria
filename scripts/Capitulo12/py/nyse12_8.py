# Exemplo 12.8
import statsmodels.formula.api as smf
import wooldridge as woo
import numpy as np
import pandas as pd

# Carregar dados
nyse = woo.dataWoo("nyse")

# Regressão
Reg = smf.ols('Q("return") ~ return_1', data=nyse).fit()

print(Reg.summary())

uhat = Reg.resid
uhat2 = uhat**2

t = Reg.tvalues["return_1"]
print(t)

# Alinhar os resíduos quadrados às observações originais
nyse["uhat2"] = np.nan
nyse.loc[Reg.resid.index, "uhat2"] = uhat2

# Defasagem de return
nyse["return_1"] = nyse["return"].shift(1)

Reg1 = smf.ols("uhat2 ~ return_1", data=nyse).fit()
print(Reg1.summary())
t1 = Reg1.tvalues["return_1"]
print(t1)