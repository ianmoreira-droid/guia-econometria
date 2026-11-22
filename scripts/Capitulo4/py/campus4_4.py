# Exemplo 4.4
import wooldridge as woo
import statsmodels.formula.api as smf

dados = woo.dataWoo('campus')

# Regressão
Reg = smf.ols('lcrime ~ lenroll', data=dados).fit()

print(Reg.summary())

# Estatística t para H0: beta_lenroll = 1
t = (Reg.params['lenroll'] - 1) / Reg.bse['lenroll']

print(t)