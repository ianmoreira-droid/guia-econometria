## Exemplo 10.2 - Regressão de i3 sobre inf e def
import statsmodels.api as sm
from wooldridge import data

# Carregar a base
intdef = data("intdef")

# Regressão
X = intdef[["inf", "def"]]
X = sm.add_constant(X)

y = intdef["i3"]

Reg10_2 = sm.OLS(y, X).fit()

# Resultados
print(Reg10_2.summary())