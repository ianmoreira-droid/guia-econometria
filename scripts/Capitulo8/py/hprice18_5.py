# Exemplo 8.5
import wooldridge
import statsmodels.formula.api as smf
from scipy.stats import chi2

# Carregar os dados
dados = wooldridge.data('hprice1').copy()

# Reg1
Reg1 = smf.ols(
    'lprice ~ llotsize + lsqrft + bdrms',
    data=dados
).fit()

print(Reg1.summary())

# Valores ajustados e resíduos
dados['lpricehat'] = Reg1.predict(dados)
dados['lpricehat2'] = dados['lpricehat'] ** 2
dados['uhat'] = Reg1.resid
dados['uhat2'] = dados['uhat'] ** 2

# Reg2: regressão auxiliar
Reg2 = smf.ols(
    'uhat2 ~ lpricehat + lpricehat2',
    data=dados
).fit()

# Teste LM
LM = Reg2.nobs * Reg2.rsquared
pvalor = chi2.sf(LM, df=2)

print("LM =", LM)
print("p-valor =", pvalor)