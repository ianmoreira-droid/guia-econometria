# Exemplo 4.1
import pandas as pd
import statsmodels.formula.api as smf
import wooldridge

dados = wooldridge.data('wage1')

# Regressão
Reg = smf.ols('lwage ~ educ + exper + tenure', data=dados).fit()

print(Reg.summary())

# Cálculo manual do teste t
coef = Reg.params['exper']
se = Reg.bse['exper']

t = coef / se
print(t)