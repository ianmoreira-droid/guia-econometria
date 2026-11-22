#Exemplo 11.5
import numpy as np
import statsmodels.formula.api as smf
from wooldridge import data

phillips = data("phillips")
dados = phillips[phillips.year <= 1996]

Reg = smf.ols("cinf ~ unem", data=dados).fit()
print(Reg.summary())

b = Reg.params
V = Reg.cov_params()

est = -b["Intercept"] / b["unem"]

se = np.sqrt(
    V.loc["Intercept","Intercept"] / b["unem"]**2
    + b["Intercept"]**2 * V.loc["unem","unem"] / b["unem"]**4
    - 2*b["Intercept"] * V.loc["Intercept","unem"] / b["unem"]**3
)

print(est)
print(est - 1.96*se, est + 1.96*se)