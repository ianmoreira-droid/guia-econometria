# Exemplo 12.4
import wooldridge
import pandas as pd
import numpy as np
import statsmodels.api as sm
from statsmodels.regression.linear_model import GLSAR
import os

# Dados
os.chdir("C:\\Users\\ianpm\\Desktop\\Ian\\Faculdade\\UFBA\\PIBIC\\Python\\Exemplos\\Cap12")
barium = pd.read_excel("barium.xls")

# Regressão OLS
X = sm.add_constant(
    barium[['lchempi', 'lgas', 'lrtwex', 'befile6', 'affile6', 'afdec6']]
)
y = barium['lchnimp']

Reg = sm.OLS(y, X).fit()

print(Reg.summary())

# Estatística t de afdec6
print(Reg.tvalues['afdec6'])

# Ordenar os dados pelo tempo
barium = barium.sort_values('t').reset_index(drop=True)

y = barium['lchnimp'].to_numpy()

X = sm.add_constant(
    barium[['lchempi', 'lgas', 'lrtwex',
            'befile6', 'affile6', 'afdec6']]
).to_numpy()

# Regressão Prais-Winsten (AR(1))
# Estimar rho inicial
uhat = Reg.resid
rho = np.sum(uhat[1:] * uhat[:-1]) / np.sum(uhat[:-1]**2)

# Iterações Prais-Winsten
for i in range(1000):
    # Transformar a primeira observação
    fator = np.sqrt(1 - rho**2)

    y_pw = np.empty_like(y)
    X_pw = np.empty_like(X)

    y_pw[0] = fator * y[0]
    X_pw[0] = fator * X[0]

    # Transformar as observações seguintes
    y_pw[1:] = y[1:] - rho * y[:-1]
    X_pw[1:] = X[1:] - rho * X[:-1]

    # Estimar regressão transformada
    Reg2 = sm.OLS(y_pw, X_pw).fit()

    # Resíduos na escala original
    uhat = y - X @ Reg2.params

    # Atualizar rho
    rho_novo = (
        np.sum(uhat[1:] * uhat[:-1])
        / np.sum(uhat[:-1]**2)
    )

    if abs(rho_novo - rho) < 1e-6:
        rho = rho_novo
        break

    rho = rho_novo

print(Reg2.summary())
print("rho =", rho)
print("Estatística t de afdec6 =", Reg2.tvalues[-1])
