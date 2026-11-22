# Exemplo 7.1
import wooldridge as woo
import statsmodels.formula.api as smf

dados = woo.dataWoo("wage1")

Reg1 = smf.ols(
    formula="wage ~ female + educ + exper + tenure",
    data=dados
).fit()
print(Reg1.summary())

Reg2 = smf.ols(
    formula="wage ~ female",
    data=dados
).fit()
print(Reg2.summary())