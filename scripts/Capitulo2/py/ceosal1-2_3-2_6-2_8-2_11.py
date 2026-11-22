# Exemplos 2.3, 2.6, 2.8, 2.11
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.formula.api as smf
import wooldridge

# Importar base de dados
dados = wooldridge.data('ceosal1')

# 2.3
Reg1 = smf.ols('salary ~ roe', data=dados).fit()
print(Reg1.summary())

dados['salary_pred'] = Reg1.predict(dados)

# Gráfico 2.3
plt.figure(figsize=(8, 5))
plt.scatter(dados['roe'], dados['salary_pred'], color='darkgreen')

x = np.linspace(dados['roe'].min(), dados['roe'].max(), 100)
y = Reg1.params['Intercept'] + Reg1.params['roe'] * x

plt.plot(x, y, color='red')
plt.title('Salário do CEO vs ROE')
plt.xlabel('ROE (%)')
plt.ylabel('Salário Predito')
plt.tight_layout()
plt.savefig('CEOSal1-1.png')
plt.show()

# 2.6
resultado = pd.DataFrame({
    'salary': dados['salary'],
    'roe': dados['roe'],
    'salaryhat': Reg1.fittedvalues,
    'uhat': Reg1.resid
})

print(resultado.head(15))

# 2.8
print(Reg1.rsquared)

# 2.11
Reg2 = smf.ols('lsalary ~ lsales', data=dados).fit()
print(Reg2.summary())

dados['lsalary_pred'] = Reg2.predict(dados)

# Gráfico 2.11
plt.figure(figsize=(8, 5))
plt.scatter(dados['lsales'], dados['lsalary_pred'], color='darkgreen')

x = np.linspace(dados['lsales'].min(), dados['lsales'].max(), 100)
y = Reg2.params['Intercept'] + Reg2.params['lsales'] * x

plt.plot(x, y, color='red')
plt.title('Log do Salário do CEO vs Log das vendas')
plt.xlabel('Log(sales)')
plt.ylabel('Log(Salário) Predito')
plt.tight_layout()
plt.savefig('CEOSal1-2.png')
plt.show()