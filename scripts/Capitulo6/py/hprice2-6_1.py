# Exemplo 6.1
import wooldridge
import statsmodels.api as sm

# Importar os dados
dados = wooldridge.data('hprice2')

# Padronizando
variaveis = ['price', 'nox', 'crime', 'rooms', 'dist', 'stratio']

for var in variaveis:
    dados['z' + var] = (
        dados[var] - dados[var].mean()
    ) / dados[var].std()

# Regressão
X = dados[['znox', 'zcrime', 'zrooms', 'zdist', 'zstratio']]
X = sm.add_constant(X)
y = dados['zprice']

Reg = sm.OLS(y, X).fit()

print(Reg.summary())