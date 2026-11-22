# Exemplo 8.8
import wooldridge as woo
import statsmodels.formula.api as smf

# Importar base de dados
dados = woo.data("mroz")

# Primeira regressão: OLS convencional
Reg1 = smf.ols(
    "inlf ~ nwifeinc + educ + exper + expersq + age + kidslt6 + kidsge6",
    data=dados
).fit()

print(Reg1.summary())

# Segunda regressão: erros-padrão robustos
Reg2 = smf.ols(
    "inlf ~ nwifeinc + educ + exper + expersq + age + kidslt6 + kidsge6",
    data=dados
).fit(cov_type="HC1")

print(Reg2.summary())

# Estatísticas t com erros-padrão robustos
variaveis = [
    "nwifeinc", "educ", "exper", "expersq",
    "age", "kidslt6", "kidsge6"
]

for v in variaveis:
    t = Reg2.params[v] / Reg2.bse[v]
    print(f"{v}  t = {t}")