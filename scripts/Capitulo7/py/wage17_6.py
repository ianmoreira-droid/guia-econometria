# Exemplo 7.6
import wooldridge as woo
import statsmodels.formula.api as smf
import numpy as np
from scipy.stats import t

dados = woo.dataWoo("wage1")

# Homem casado
dados["marrmale"] = ((dados["married"] == 1) & (dados["female"] == 0)).astype(int)

# Mulher casada
dados["marrfem"] = ((dados["married"] == 1) & (dados["female"] == 1)).astype(int)

# Mulher solteira
dados["singfem"] = ((dados["married"] == 0) & (dados["female"] == 1)).astype(int)

Reg1 = smf.ols(
    formula="lwage ~ marrmale + marrfem + singfem + educ + exper + expersq + tenure + tenursq",
    data=dados
).fit()
print(Reg1.summary())

# Diferença entre os coeficientes: singfem - marrfem
L = np.zeros(len(Reg1.params))
L[Reg1.params.index.get_loc("singfem")] = 1
L[Reg1.params.index.get_loc("marrfem")] = -1

est = L @ Reg1.params
V = Reg1.cov_params()
se = np.sqrt(L @ V @ L)
print("Coeficiente:", est, "\nt:", est / se)

# Valor crítico t para intervalo de confiança de 95%
print(t.ppf(0.975, df=Reg1.df_resid))