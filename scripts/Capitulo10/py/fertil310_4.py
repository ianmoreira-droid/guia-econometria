#Exemplo 10.4
from wooldridge import data
import statsmodels.api as sm
import numpy as np

# Carregar a base
fertil3 = data("fertil3")

# Variáveis da regressão
vars_reg2 = ["gfr", "pe", "pe_1", "pe_2", "ww2", "pill"]

# Eliminar observações com valores ausentes
fertil3_reg2 = fertil3[vars_reg2].dropna()

# Regressão 1
X1 = fertil3[["pe", "ww2", "pill"]]
X1 = sm.add_constant(X1)

y = fertil3["gfr"]

Reg1 = sm.OLS(y, X1).fit()

print(Reg1.summary())

# Regressão 2
X2 = fertil3_reg2[["pe", "pe_1", "pe_2", "ww2", "pill"]]
X2 = sm.add_constant(X2)
y2 = fertil3_reg2["gfr"]
Reg2 = sm.OLS(y2, X2).fit()

print(Reg2.summary())

# Teste conjunto:
# H0: beta_pe + beta_pe_1 + beta_pe_2 = 0
propensao_lp = Reg2.wald_test("pe + pe_1 + pe_2 = 0")

# Intervalo de confiança da combinação linear
R = np.array([[0, 1, 1, 1, 0, 0]])

resultado = Reg2.t_test(R)

print(resultado)
print(resultado.conf_int())