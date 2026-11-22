# Exemplos 2.5 e 2.9
import pandas as pd
import statsmodels.api as sm
import matplotlib.pyplot as plt

# Importar dados
dados = pd.read_excel(
    r"C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap2/vote1.xls"
)

# 2.5
X = sm.add_constant(dados['shareA'])
Reg1 = sm.OLS(dados['voteA'], X).fit()

print(Reg1.summary())

# Gráfico 2.5
plt.scatter(dados['shareA'], dados['voteA'], color='darkgreen')
plt.plot(dados['shareA'], Reg1.predict(X), color='red')
plt.title('% de votos vs % de gastos na campanha')
plt.xlabel('%gastos')
plt.ylabel('%votos')
plt.savefig('vote1-1.png', dpi=300, bbox_inches='tight')
plt.show()

# 2.9
print(Reg1.rsquared)