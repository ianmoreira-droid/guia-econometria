# Exemplo 3.1 e 3.4
import statsmodels.api as sm
import wooldridge
import pickle

# Carregar os dados
dados = wooldridge.data('gpa1')

# Regressão
X = dados[['hsGPA', 'ACT']]
X = sm.add_constant(X)
y = dados['colGPA']

GPAregress = sm.OLS(y, X).fit()

print(GPAregress.summary())

# 3.4 — R²
print(GPAregress.rsquared)

# Salvar o modelo e os dados
with open('gpa1.pkl', 'wb') as arquivo:
    pickle.dump({'GPAregress': GPAregress, 'dados': dados}, arquivo)