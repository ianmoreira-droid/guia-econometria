# Exemplo 8.7
import wooldridge as woo
import statsmodels.api as sm
import statsmodels.formula.api as smf
from statsmodels.stats.diagnostic import het_breuschpagan
import numpy as np

# Importar base de dados
dados = woo.data("smoke")

# Primeira regressão
Reg1 = smf.ols(
    "cigs ~ lincome + lcigpric + educ + age + agesq + restaurn",
    data=dados
).fit()

print(Reg1.summary())

# Teste de Breusch-Pagan
bp = het_breuschpagan(
    Reg1.resid,
    Reg1.model.exog,
    robust=True
)

print("LM =", bp[0])
print("p-valor LM =", bp[1])
print("F =", bp[2])
print("p-valor F =", bp[3])

# Resíduos e resíduos ao quadrado
dados["u"] = Reg1.resid
dados["u2"] = dados["u"]**2
dados["lu2"] = np.log(dados["u2"])

# Regressão auxiliar para estimar ghat
Reg1_1 = smf.ols(
    "lu2 ~ lincome + lcigpric + educ + age + agesq + restaurn",
    data=dados
).fit()
dados["ghat"] = Reg1_1.predict(dados)

# Criar pesos: w = exp(-ghat)
dados["w"] = np.exp(-dados["ghat"])

# MQGF: regressão WLS
Reg2 = smf.wls(
    "cigs ~ lincome + lcigpric + educ + age + agesq + restaurn",
    data=dados,
    weights=dados["w"]
).fit()

print(Reg2.summary())