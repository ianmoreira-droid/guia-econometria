# Exemplo 7.10
import wooldridge as woo
import statsmodels.formula.api as smf
import numpy as np
from scipy import stats

dados = woo.dataWoo("wage1")

Reg = smf.ols(
    formula="lwage ~ female + educ + female:educ + exper + expersq + tenure + tenursq",
    data=dados
).fit()
print(Reg.summary())

# Valor t
print(Reg.params["female:educ"] / Reg.bse["female:educ"])

# Teste conjunto
print(Reg.f_test(["female = 0", "female:educ = 0"]))

# Retorno de educação para as mulheres
print(Reg.params["educ"] + Reg.params["female:educ"])

# Centraliza educação em 12.5 anos
dados["educc"] = dados["educ"] - 12.5

Reg2 = smf.ols(
    formula="lwage ~ female + educ + educc:female + exper + expersq + tenure + tenursq",
    data=dados
).fit()

print(Reg2.params["female"])