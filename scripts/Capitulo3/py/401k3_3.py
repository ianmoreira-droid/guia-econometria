# Exemplo 3.3
import statsmodels.api as sm
import wooldridge

# Carregar os dados
dados = wooldridge.data('401k')

# Regressão 1: prate ~ mrate + age
X = dados[['mrate', 'age']]
X = sm.add_constant(X)
y = dados['prate']

Pensionregress = sm.OLS(y, X).fit()

print(Pensionregress.summary())
print("R²:", Pensionregress.rsquared)


# Regressão 2: prate ~ mrate
X2 = sm.add_constant(dados[['mrate']])

Reg2 = sm.OLS(y, X2).fit()

print(Reg2.summary())
print("R²:", Reg2.rsquared)
print("Correlação entre mrate e age:", dados[['mrate', 'age']].corr().loc['mrate', 'age'])