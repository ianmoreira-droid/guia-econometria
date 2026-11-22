# Exemplo 3.5
import statsmodels.api as sm
import wooldridge

# Carregar os dados
dados = wooldridge.data('crime1')

# Regressão 1
X = dados[['pcnv', 'ptime86', 'qemp86']]
X = sm.add_constant(X)
y = dados['narr86']

Crimeregress = sm.OLS(y, X).fit()

print(Crimeregress.summary())
print("R²:", Crimeregress.rsquared)

# Regressão 2
X2 = dados[['pcnv', 'avgsen', 'ptime86', 'qemp86']]
X2 = sm.add_constant(X2)

Crimeregress2 = sm.OLS(y, X2).fit()

print(Crimeregress2.summary())
print("R²:", Crimeregress2.rsquared)

