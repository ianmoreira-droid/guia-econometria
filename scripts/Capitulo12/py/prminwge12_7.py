#Exemplo 12.7
import numpy as np
import pandas as pd
import statsmodels.api as sm
import statsmodels.formula.api as smf
import wooldridge as woo
import patsy

prminwge = woo.dataWoo("prminwge").sort_values("year").reset_index(drop=True)

for v in ["prepop", "mincov", "prgnp", "usgnp"]:
    if "l" + v not in prminwge.columns:
        prminwge["l" + v] = np.log(prminwge[v])

if "t" not in prminwge.columns:
    prminwge["t"] = prminwge["year"] - 1949

# Passos 1 e 2
Reg = smf.ols("lprepop ~ lmincov + lusgnp + lprgnp + t", data=prminwge).fit()
print(Reg.summary())
Reg1 = smf.ols("lmincov ~ lusgnp + lprgnp + t", data=prminwge).fit()

uhat, rhat1 = Reg.resid, Reg1.resid
sigma, se1 = np.sqrt(Reg.mse_resid), Reg.bse["lmincov"]

# Passos 3, 4 e 5
a, g = rhat1 * uhat, 2
nhat = np.sum(a**2)

for h in range(1, g + 1):
    nhat += 2 * (1 - h / (g + 1)) * (a * a.shift(h)).sum()

se_robust = (se1 / sigma)**2 * np.sqrt(nhat)
print("n_hat =", nhat, "\nSE robusto =", se_robust)
print(-0.212 / 0.04260487)

# Prais-Winsten iterativo
def prais_winsten_stata(formula, data, max_iter=100, tol=1e-6):
    y, X = patsy.dmatrices(formula, data, return_type="dataframe")
    y = y.iloc[:, 0]

    def rho_est(u):
        u = np.asarray(u)
        return np.dot(u[1:], u[:-1]) / np.dot(u[:-1], u[:-1])

    beta = sm.OLS(y, X).fit().params
    rho = rho_est(y - X @ beta)

    for i in range(max_iter):
        r = np.sqrt(max(0, 1 - rho**2))
        yp, Xp = y.copy(), X.copy()
        yp.iloc[0] *= r
        Xp.iloc[0, :] *= r
        yp.iloc[1:] = y.iloc[1:].to_numpy() - rho * y.iloc[:-1].to_numpy()
        Xp.iloc[1:] = X.iloc[1:].to_numpy() - rho * X.iloc[:-1].to_numpy()

        resultado = sm.OLS(yp, Xp).fit()
        rho_novo = rho_est(y - X @ resultado.params)
        if abs(rho_novo - rho) < tol:
            rho = rho_novo
            break
        rho = rho_novo

    resultado.rho, resultado.iterations = rho, i + 1
    return resultado

Reg2 = prais_winsten_stata(
    "lprepop ~ lmincov + lusgnp + lprgnp + year", prminwge
)
print(Reg2.summary())

# R² calculado na escala dos dados usados pelo modelo
y, X = Reg2.model.endog, Reg2.model.exog
r2_original = 1 - np.sum((y - X @ Reg2.params)**2) / np.sum((y - y.mean())**2)
print("R² reportado:", Reg2.rsquared, "\nR² calculado:", r2_original)