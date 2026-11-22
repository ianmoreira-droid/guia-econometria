# Exemplo 6.7
import wooldridge
import numpy as np
import statsmodels.formula.api as smf

# Carregar os dados
dados = wooldridge.data('ceosal2')

# Regressão
Reg = smf.ols('lsalary ~ lsales + lmktval + ceoten', data=dados).fit()
print(Reg.summary())

# Calculando o valor predito em log
print(4.504 + 0.163 * np.log(5000) + 0.109 * np.log(10000) + 0.0117 * 10)

# Convertendo para o nível original
print(np.exp(7.013))

# Resíduos da regressão
dados['u_chap'] = Reg.resid

# Fator de correção de smearing
dados['smear'] = np.exp(dados['u_chap'])
print(dados['smear'].mean())

# Aplicando a correção
s = dados['smear'].mean()
print(np.exp(7.013) * s)