# Exemplo 12.6
import pandas as pd
import statsmodels.api as sm
from wooldridge import data

# Carregar dados
intdef = data('intdef')
intdef = intdef.sort_values('year').reset_index(drop=True)

# Regressão 1
Reg = sm.OLS(
    intdef['i3'],
    sm.add_constant(intdef[['inf', 'def']])
).fit()

print(Reg.summary())

# Resíduos e defasagem
uhat = Reg.resid
Luhat = uhat.shift(1)

aux1 = pd.DataFrame({
    'uhat': uhat,
    'Luhat': Luhat
}).dropna()

Reg1_2 = sm.OLS(
    aux1['uhat'],
    sm.add_constant(aux1['Luhat'])
).fit()

print(Reg1_2.summary())


# Regressão 2
df2 = intdef[['ci3', 'cinf', 'cdef']].dropna()

Reg2 = sm.OLS(
    df2['ci3'],
    sm.add_constant(df2[['cinf', 'cdef']])
).fit()

print(Reg2.summary())

# Resíduos e defasagem
uhat2 = Reg2.resid
Luhat2 = uhat2.shift(1)

aux2 = pd.DataFrame({
    'uhat2': uhat2,
    'Luhat2': Luhat2
}).dropna()

Reg2_2 = sm.OLS(
    aux2['uhat2'],
    sm.add_constant(aux2['Luhat2'])
).fit()

print(Reg2_2.summary())


# Correlação entre i3 e i3_1
print(intdef[['i3', 'i3_1']].corr().loc['i3', 'i3_1'])