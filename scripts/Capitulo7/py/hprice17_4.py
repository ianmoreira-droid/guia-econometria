# Exemplo 7.4
import wooldridge
import statsmodels.formula.api as smf

dados = wooldridge.data('hprice1')

Reg = smf.ols('lprice ~ llotsize + lsqrft + bdrms + colonial', data=dados).fit()
print(Reg.summary())

# Efeito de ser colonial em %
print(Reg.params['colonial'] * 100)