# Exemplo 7.7
import pandas as pd
import statsmodels.formula.api as smf

dados = pd.read_csv(
    r"C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap7\beauty.csv"
)

# Selecionar as primeiras 700 observações de homens
dados["ordem"] = dados.groupby("female").cumcount() + 1

Reg1 = smf.ols(
    formula="lwage ~ belavg + abvavg + educ + exper + expersq + married + black + union + goodhlth + south + bigcity + smllcity + service",
    data=dados[dados["female"].eq(0) & dados["ordem"].le(700)]
).fit()

print(Reg1.summary())

# Selecionar as primeiras 409 observações de mulheres
dados["ordem2"] = dados.groupby("female").cumcount() + 1

Reg2 = smf.ols(
    formula="lwage ~ belavg + abvavg + educ + exper + expersq + married + black + union + goodhlth + south + bigcity + smllcity + service",
    data=dados[dados["female"].eq(1) & dados["ordem2"].le(409)]
).fit()

print(Reg2.summary())