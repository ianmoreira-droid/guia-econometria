# Exemplo 8.9
import pandas as pd
import statsmodels.formula.api as smf

# Importar base de dados
dados = pd.read_excel(
    r"C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap8/gpa1.xls"
)

# Primeira regressão
Reg1 = smf.ols(
    "PC ~ hsGPA + ACT + parcoll",
    data=dados
).fit()

print(Reg1.summary())

# Valores previstos
dados["phat"] = Reg1.predict(dados)

# Estimar variância condicional
dados["hhat"] = dados["phat"] * (1 - dados["phat"])

# Criar pesos
dados["w"] = 1 / dados["hhat"]

# Segunda regressão: erros-padrão robustos
Reg2 = smf.ols(
    "PC ~ hsGPA + ACT + parcoll",
    data=dados
).fit(cov_type="HC1")

# Exibir erros-padrão robustos
variaveis = ["hsGPA", "ACT", "parcoll"]

for v in variaveis:
    print(f"{v}  se = {Reg2.bse[v]}")

# Terceira regressão: MQGF por WLS
Reg3 = smf.wls(
    "PC ~ hsGPA + ACT + parcoll",
    data=dados,
    weights=dados["w"]
).fit()

print(Reg3.summary())