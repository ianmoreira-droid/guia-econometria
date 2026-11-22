# Exemplo 6.5 e 6.6
import pandas as pd
import statsmodels.formula.api as smf
from wooldridge import data

dados = data('gpa2')

# 6.5
# Reg 1.0
Reg = smf.ols('colgpa ~ sat + hsperc + hsize + hsizesq', data=dados).fit()
print(Reg.summary())

print(Reg.predict(pd.DataFrame({
    'sat': [1200], 'hsperc': [30],
    'hsize': [5], 'hsizesq': [25]
})))

# Reg 1.1: centralizando as variáveis
dados['sat0'] = dados['sat'] - 1200
dados['hsperc0'] = dados['hsperc'] - 30
dados['hsize0'] = dados['hsize'] - 5
dados['hsizesq0'] = dados['hsizesq'] - 25

Reg1 = smf.ols('colgpa ~ sat0 + hsperc0 + hsize0 + hsizesq0', data=dados).fit()
print(Reg1.summary())

# IC de 95% da média predita
b = Reg1.params['Intercept']
se = Reg1.bse['Intercept']
print(b + pd.Series([-1, 1]) * 1.96 * se)

# Intervalo de predição individual (Ex. 6.6)
z = (se**2 + Reg1.mse_resid)**0.5
print(b - 1.96 * z)
print(b + 1.96 * z)