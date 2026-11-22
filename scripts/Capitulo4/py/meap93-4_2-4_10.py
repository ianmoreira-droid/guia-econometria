# Exemplos 4.2 e 4.10
import pandas as pd
import statsmodels.formula.api as smf
import wooldridge

dados = wooldridge.data('meap93')

dados['b_s'] = dados['benefits'] / dados['salary']

# Exemplo 4.2
Regress4_2 = smf.ols('math10 ~ totcomp + staff + enroll', data=dados).fit()

print(Regress4_2.summary())
print(Regress4_2.rsquared)
print(Regress4_2.tvalues['enroll'])

Regress4_2_1 = smf.ols('math10 ~ ltotcomp + lstaff + lenroll', data=dados).fit()

print(Regress4_2_1.summary())
print(Regress4_2_1.tvalues['lenroll'])

# Exemplo 4.10
Regress4_10 = smf.ols('lsalary ~ b_s', data=dados).fit()

print(Regress4_10.summary())

# Teste t manual
# H0: Beta1 = -1
coef = Regress4_10.params['b_s']
se = Regress4_10.bse['b_s']

t = (coef - (-1)) / se
print(t)

Regress4_10_1 = smf.ols(
    'lsalary ~ b_s + lenroll + lstaff + droprate + gradrate',
    data=dados
).fit()

print(Regress4_10_1.summary())

Regress4_10_2 = smf.ols(
    'lsalary ~ b_s + lenroll + lstaff',
    data=dados
).fit()

print(Regress4_10_2.summary())

# Teste t para H0: Beta_b_s = -1
t = (Regress4_10_2.params['b_s'] + 1) / Regress4_10_2.bse['b_s']
print(t)