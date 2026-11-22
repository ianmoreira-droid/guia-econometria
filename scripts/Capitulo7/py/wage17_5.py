# Exemplo 7.5
import numpy as np
import wooldridge as woo
import statsmodels.formula.api as smf

dados = woo.dataWoo("wage1")

Reg1 = smf.ols(
    formula="lwage ~ female + educ + exper + expersq + tenure + tenursq",
    data=dados
).fit()
print(Reg1.summary())

# Efeito percentual de ser mulher
print(100 * (np.exp(Reg1.params["female"]) - 1))