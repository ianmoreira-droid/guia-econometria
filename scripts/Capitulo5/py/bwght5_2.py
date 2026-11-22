# Exemplo 5.2
import numpy as np
import statsmodels.api as sm
from wooldridge import data

# Carregar dados
bwght = data('bwght')

# Regressão com a amostra completa
X = sm.add_constant(bwght[['cigs', 'lfaminc']])
y = bwght['lbwght']

Reg = sm.OLS(y, X, missing='drop').fit()
print(Reg.summary())

# Regressão até a observação 694
bwght_sub = bwght.iloc[:694].copy()

X2 = sm.add_constant(bwght_sub[['cigs', 'lfaminc']])
y2 = bwght_sub['lbwght']

Reg2 = sm.OLS(y2, X2, missing='drop').fit()
print(Reg2.summary())

# Erros-padrão do coeficiente de cigs
se_totaln = Reg.bse['cigs']
se_n2 = Reg2.bse['cigs']

# Razão entre os erros-padrão (amostral)
print(se_totaln / se_n2)

# Razão teórica (populacional)
print(np.sqrt(1/2))