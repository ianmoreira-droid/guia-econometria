# Exemplos 2.4, 2.7 e 2.10
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.formula.api as smf
import wooldridge

# Importar base de dados
dados = wooldridge.data('wage1')

# 2.4
Reg1 = smf.ols('wage ~ educ', data=dados).fit()
print(Reg1.summary())

# Gráfico
plt.figure(figsize=(8, 5))

plt.scatter(dados['educ'], dados['wage'], color='darkgreen')

x = np.linspace(dados['educ'].min(), dados['educ'].max(), 100)
y = Reg1.params['Intercept'] + Reg1.params['educ'] * x

plt.plot(x, y, color='red')
plt.title('Salário vs Anos de educação')
plt.xlabel('Educação (anos)')
plt.ylabel('Salário')
plt.tight_layout()
plt.savefig('wage1-1.png')
plt.show()

# 2.7
media = dados['educ'].mean()

salario_pred = Reg1.predict(pd.DataFrame({'educ': [media]}))
print(salario_pred)

# 2.10
Reg2 = smf.ols('lwage ~ educ', data=dados).fit()
print(Reg2.summary())

# Gráfico
plt.figure(figsize=(8, 5))

plt.scatter(dados['educ'], dados['lwage'], color='darkgreen')

x = np.linspace(dados['educ'].min(), dados['educ'].max(), 100)
y = Reg2.params['Intercept'] + Reg2.params['educ'] * x

plt.plot(x, y, color='red')
plt.title('Salário vs Anos de educação')
plt.xlabel('Educação (anos)')
plt.ylabel('Logsalário')
plt.tight_layout()
plt.savefig('wage1-2.png')
plt.show()