# Exemplo 7.12
import pandas as pd
import statsmodels.formula.api as smf
from statsmodels.stats.anova import anova_lm

dados = pd.read_excel(
    r"C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap7/crime1.xls"
)

Reg = smf.ols(
    formula="arr86 ~ pcnv + avgsen + tottime + ptime86 + qemp86",
    data=dados
).fit()

print(Reg.summary())

# Teste conjunto: H0: avgsen = 0 e tottime = 0
teste = Reg.f_test("avgsen = 0, tottime = 0")
print(teste)