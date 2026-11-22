# Exemplo 9.10
import wooldridge
import statsmodels.formula.api as smf

dados = wooldridge.data("infmrt")

Reg1 = smf.ols(
    formula="infmort ~ lpcinc + lphysic + lpopul",
    data=dados[dados["d90"] == 1]
).fit()

print(Reg1.summary())

Reg2 = smf.ols(
    formula="infmort ~ lpcinc + lphysic + lpopul",
    data=dados[(dados["d90"] == 1) & (dados["DC"] == 0)]
).fit()

print(Reg2.summary())