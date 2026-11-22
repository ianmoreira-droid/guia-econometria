# Exemplo 8.6
import pandas as pd
import statsmodels.api as sm
import statsmodels.formula.api as smf
from scipy.stats import f as f_dist

# Importar base de dados
dados = pd.read_excel(
    r"C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap8/401ksubs.xls"
)

# Manter apenas fsize == 1
dados = dados.loc[dados["fsize"] == 1].copy()

# Criar variável (age - 25)^2
dados["age25_2"] = (dados["age"] - 25)**2

# Primeira regressão: OLS com erros-padrão robustos
Reg1 = smf.ols("nettfa ~ inc", data=dados).fit(cov_type="HC1")
print(Reg1.summary())

# Resíduos e resíduos ao quadrado
dados["uhat1"] = Reg1.resid
dados["uhat1_2"] = dados["uhat1"]**2

# Regressão auxiliar
Reg1_1 = smf.ols("uhat1_2 ~ inc", data=dados).fit()
print(Reg1_1.summary())

t_inc = Reg1_1.tvalues["inc"]
print("t de inc =", t_inc)

# Segunda regressão: WLS com pesos 1/inc
Reg2 = smf.wls(
    "nettfa ~ inc",
    data=dados,
    weights=1/dados["inc"]
).fit()

print(Reg2.summary())

r2_r = Reg2.rsquared

# Terceira regressão: OLS com erros-padrão robustos
Reg3 = smf.ols(
    "nettfa ~ inc + age25_2 + male + e401k",
    data=dados
).fit(cov_type="HC1")

print(Reg3.summary())


# Quarta regressão: WLS com pesos 1/inc
Reg4 = smf.wls(
    "nettfa ~ inc + age25_2 + male + e401k",
    data=dados,
    weights=1/dados["inc"]
).fit()

print(Reg4.summary())

r2_ur = Reg4.rsquared

# Teste conjunto: age25_2 = male = e401k = 0
teste = Reg4.f_test(
    "age25_2 = 0, male = 0, e401k = 0"
)

print("F do teste conjunto =", float(teste.fvalue))
print("p-valor =", float(teste.pvalue))

# Teste F manual das regressões 2 e 4
F = ((r2_ur - r2_r)/3) / ((1 - r2_ur)/2012)

p_valor = f_dist.sf(F, 3, 2012)

print("F =", F)
print("p-valor =", p_valor)