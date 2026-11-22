# Exemplo 5.3
import statsmodels.api as sm
from wooldridge import data

# Carregar dados
crime1 = data('crime1')

# Regressão 1
X = sm.add_constant(crime1[['pcnv', 'ptime86', 'qemp86']])
y = crime1['narr86']

Reg = sm.OLS(y, X, missing='drop').fit()
print(Reg.summary())

# Resíduos
util = Reg.resid

# Regressão 2
df2 = crime1.copy()
df2['util'] = util

vars_reg2 = ['util', 'pcnv', 'avgsen', 'tottime', 'ptime86', 'qemp86']
df2 = df2[vars_reg2].dropna()

X2 = sm.add_constant(df2[['pcnv', 'avgsen', 'tottime', 'ptime86', 'qemp86']])
y2 = df2['util']

Reg2 = sm.OLS(y2, X2).fit()
print(Reg2.summary())

# LM = N * R²
LM = int(Reg.nobs) * Reg2.rsquared
print(LM)

# LM2 = N * R² arredondado para 4 casas decimais
LM2 = int(Reg.nobs) * round(Reg2.rsquared, 4)
print(LM2)