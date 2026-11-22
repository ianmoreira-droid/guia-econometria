# Exemplo 2.12
import wooldridge
import statsmodels.api as sm

# Carregar os dados
dados = wooldridge.data('meap93')

# Regressão
X = sm.add_constant(dados['lnchprg'])
y = dados['math10']

Math10regress = sm.OLS(y, X).fit()

print(Math10regress.summary())

# R²
print(Math10regress.rsquared)