# Exemplo 8.4
import wooldridge
import statsmodels.formula.api as smf
from scipy.stats import chi2

# Carregar os dados
dados = wooldridge.data('hprice1').copy()

# REG1
Reg1 = smf.ols(
    'price ~ lotsize + sqrft + bdrms',
    data=dados
).fit()

print(Reg1.summary())

# Resíduos e resíduos ao quadrado
dados['u'] = Reg1.resid
dados['u2'] = dados['u'] ** 2

# Regressão auxiliar do LM
Reg1_1 = smf.ols(
    'u2 ~ lotsize + sqrft + bdrms',
    data=dados
).fit()

# Estatística F
print("Estatística F Reg1_1:", Reg1_1.fvalue)

# Teste LM
LM1 = Reg1_1.nobs * Reg1_1.rsquared
pvalor1 = chi2.sf(LM1, df=3)

print("LM1 =", LM1)
print("p-valor1 =", pvalor1)

# REG2
Reg2 = smf.ols(
    'lprice ~ llotsize + lsqrft + bdrms',
    data=dados
).fit()

print(Reg2.summary())

# Resíduos e resíduos ao quadrado
dados['uhat'] = Reg2.resid
dados['uhat2'] = dados['uhat'] ** 2

# Regressão auxiliar do LM
Reg2_1 = smf.ols(
    'uhat2 ~ llotsize + lsqrft + bdrms',
    data=dados
).fit()

# Estatística F
print("Estatística F Reg2_1:", Reg2_1.fvalue)

# Teste LM
LM2 = Reg2_1.nobs * Reg2_1.rsquared
pvalor2 = chi2.sf(LM2, df=3)

print("LM2 =", LM2)
print("p-valor2 =", pvalor2)