# Exemplo 9.2
import pandas as pd
import statsmodels.api as sm
from statsmodels.stats.anova import anova_lm
from statsmodels.formula.api import ols

# Importar dados
dados = sm.datasets.get_rdataset('hprice1', 'wooldridge').data

# Reg1
Reg1 = ols('price ~ lotsize + sqrft + bdrms', data=dados).fit()
print(Reg1.summary())

# Teste RESET de Ramsey
# Previsões
dados['yhat'] = Reg1.predict(dados)

dados['yhat2'] = dados['yhat']**2
dados['yhat3'] = dados['yhat']**3

Reg1_1 = ols('price ~ lotsize + sqrft + bdrms + yhat2 + yhat3', data=dados).fit()

print(anova_lm(Reg1, Reg1_1))

# Reg2
Reg2 = ols('lprice ~ llotsize + lsqrft + bdrms', data=dados).fit()
print(Reg2.summary())

# Teste RESET de Ramsey
# Previsões
dados['lyhat'] = Reg2.predict(dados)

dados['lyhat2'] = dados['lyhat']**2
dados['lyhat3'] = dados['lyhat']**3

Reg2_1 = ols('lprice ~ llotsize + lsqrft + bdrms + lyhat2 + lyhat3', data=dados).fit()

print(anova_lm(Reg2, Reg2_1))