#Exemplo 12.5
import numpy as np
import pandas as pd
import statsmodels.api as sm
from wooldridge import data

# Dados
phillips = data('phillips')
df = phillips.loc[phillips['year'] <= 1996].copy()
df = df.sort_values('year').reset_index(drop=True)

y = df['inf'].to_numpy()
X = sm.add_constant(df['unem']).to_numpy()

# Regressão 10.1
Reg = sm.OLS(
    df['inf'],
    sm.add_constant(df['unem'])
).fit()

print(Reg.summary())

# Resíduos da regressão
uhat = Reg.resid
Luhat = uhat.shift(1)
aux = pd.DataFrame({
    'uhat': uhat,
    'Luhat': Luhat
}).dropna()

Reg1_2 = sm.OLS(
    aux['uhat'],
    sm.add_constant(aux['Luhat'])
).fit()

print(Reg1_2.summary())

# Estimativa inicial por MQO
ols = sm.OLS(y, X).fit()
rho = np.corrcoef(ols.resid[1:], ols.resid[:-1])[0, 1]

# Iteração Prais-Winsten
for _ in range(1000):
    y_pw = y.copy()
    X_pw = X.copy()

    # Primeira observação: transformação Prais-Winsten
    fator = np.sqrt(1 - rho**2)
    y_pw[0] = fator * y[0]
    X_pw[0, :] = fator * X[0, :]

    # Demais observações: transformação AR(1)
    y_pw[1:] = y[1:] - rho * y[:-1]
    X_pw[1:, :] = X[1:, :] - rho * X[:-1, :]

    resultado = sm.OLS(y_pw, X_pw).fit()
    residuos = y - X @ resultado.params

    rho_novo = np.sum(residuos[1:] * residuos[:-1]) / np.sum(residuos[:-1]**2)

    if abs(rho_novo - rho) < 1e-10:
        rho = rho_novo
        break

    rho = rho_novo

# Recalcular com o rho final
fator = np.sqrt(1 - rho**2)
y_pw = y.copy()
X_pw = X.copy()

y_pw[0] = fator * y[0]
X_pw[0, :] = fator * X[0, :]
y_pw[1:] = y[1:] - rho * y[:-1]
X_pw[1:, :] = X[1:, :] - rho * X[:-1, :]

Reg2 = sm.OLS(y_pw, X_pw).fit()

print(Reg2.summary())
print(f'Rho: {rho:.3f}')