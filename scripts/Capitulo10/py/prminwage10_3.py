#Exemplo 10.3
from wooldridge import data
import statsmodels.api as sm

# Carregar a base
prminwge = data("prminwge")

# Regressão
X = prminwge[["lmincov", "lusgnp"]]
X = sm.add_constant(X)

y = prminwge["lprepop"]

Reg = sm.OLS(y, X).fit()

# Resultados
print(Reg.summary())