# Exemplo 6.2
import wooldridge
import numpy as np
import statsmodels.api as sm
import matplotlib.pyplot as plt

# Importar os dados
dados = wooldridge.data('hprice2')

# Regressão
dados['lprice'] = np.log(dados['price'])
dados['lnox'] = np.log(dados['nox'])
dados['ldist'] = np.log(dados['dist'])

X = dados[['lnox', 'ldist', 'rooms', 'stratio']].copy()
X['rooms2'] = dados['rooms']**2
X = sm.add_constant(X)

Reg = sm.OLS(dados['lprice'], X).fit()
print(Reg.summary())

# Gráfico log(price) e rooms
b = Reg.params
dados['lnprice2'] = (
    b['const'] + b['rooms']*dados['rooms']
    + b['rooms2']*dados['rooms']**2
)

plt.plot(dados['rooms'], dados['lnprice2'])
plt.title('Figure 6.1 log(price) as a quadratic function of rooms')
plt.xlabel('rooms')
plt.ylabel('lnprice2')
plt.ylim(6, 18)
plt.xticks([4.4])
plt.savefig(
    r"C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Python/Exemplos/Cap6/hprice2-6_2.png"
)

plt.show()

# Valor ótimo de quartos
print(abs(b['rooms'] / (2*b['rooms2'])))

# Efeitos marginais para 5, 6 e 7 quartos
print(b['rooms'] + 2*b['rooms2']*np.array([5, 6, 7]))