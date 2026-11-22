# Exemplo 3.2 e 3.6
import statsmodels.api as sm
import wooldridge

# Carregar os dados
dados = wooldridge.data('wage1')

# Regressão 3.2
X = dados[['educ', 'exper', 'tenure']]
X = sm.add_constant(X)
y = dados['lwage']

Wagregress = sm.OLS(y, X).fit()

print(Wagregress.summary())
print("R²:", Wagregress.rsquared)

# Regressão 3.6
X2 = sm.add_constant(dados[['educ']])
y2 = dados['lwage']

Wagregress2 = sm.OLS(y2, X2).fit()

print(Wagregress2.summary())
print("R²:", Wagregress2.rsquared)

