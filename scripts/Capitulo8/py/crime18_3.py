# Exemplo 8.3
import wooldridge
import statsmodels.api as sm
import statsmodels.formula.api as smf
import numpy as np
from scipy.stats import chi2

# Carregar os dados
dados = wooldridge.data('crime1').copy()
dados['avgsensq'] = dados['avgsen'] ** 2

# Regressão
Reg = smf.ols(
    'narr86 ~ pcnv + avgsen + avgsensq + ptime86 + qemp86 + inc86 + black + hispan',
    data=dados
).fit()

print(Reg.summary())

# Teste conjunto: avgsen = avgsensq = 0
print(Reg.f_test('avgsen = 0, avgsensq = 0'))

# Erros-padrão robustos HC1
Reg_robusto = Reg.get_robustcov_results(cov_type='HC1')
print(Reg_robusto.summary())

# ==========================================
# TESTE LM USUAL
# ==========================================

# Regressão restrita
Reg1 = smf.ols(
    'narr86 ~ pcnv + ptime86 + qemp86 + inc86 + black + hispan',
    data=dados
).fit()

dados['u'] = Reg1.resid

# Regressão auxiliar
Reg2 = smf.ols(
    'u ~ pcnv + avgsen + avgsensq + ptime86 + qemp86 + inc86 + black + hispan',
    data=dados
).fit()

# Estatística LM = N * R²
LM_usual = Reg2.nobs * Reg2.rsquared
pvalor_usual = chi2.sf(LM_usual, df=2)

print('\nLM usual')
print('LM =', LM_usual)
print('p-valor =', pvalor_usual)

# ==========================================
# TESTE LM ROBUSTO
# ==========================================

# Resíduos da regressão restrita
dados['uhat'] = Reg1.resid

# Regressão auxiliar de avgsen
Reg3 = smf.ols(
    'avgsen ~ pcnv + ptime86 + qemp86 + inc86 + black + hispan',
    data=dados
).fit()

dados['r_avgsen'] = Reg3.resid

# Regressão auxiliar de avgsensq
Reg4 = smf.ols(
    'avgsensq ~ pcnv + ptime86 + qemp86 + inc86 + black + hispan',
    data=dados
).fit()

dados['r_avgsen2'] = Reg4.resid

dados['z1'] = dados['r_avgsen'] * dados['uhat']
dados['z2'] = dados['r_avgsen2'] * dados['uhat']
dados['one'] = 1.0

# Regressão sem constante
Z = dados[['z1', 'z2']]
Reg5 = sm.OLS(dados['one'], Z).fit()

# Estatística LM robusta = N - RSS
LM_robusto = Reg5.nobs - np.sum(Reg5.resid ** 2)
pvalor_robusto = chi2.sf(LM_robusto, df=2)

print('\nLM robusto')
print('LM =', LM_robusto)
print('p-valor =', pvalor_robusto)