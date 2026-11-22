# Exemplo 4.9
import statsmodels.api as sm
from wooldridge import data

# Base de dados
bwght = data('bwght')

# Regressão
X = sm.add_constant(bwght[['cigs', 'parity', 'faminc', 'motheduc', 'fatheduc']])
y = bwght['bwght']

Reg = sm.OLS(y, X, missing='drop').fit()
print(Reg.summary())

# Teste F conjunto
teste_F = Reg.f_test("motheduc = 0, fatheduc = 0")

print("Estatística F:", teste_F.fvalue)