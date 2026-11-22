# Exemplo 4.5
import pandas as pd
import statsmodels.formula.api as smf

# Importar base de dados
dados = pd.read_excel(
    "C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap4/hprice2.xls"
)

# Regressão
Reg = smf.ols(
    formula='lprice ~ lnox + ldist + rooms + stratio',
    data=dados
).fit()

print(Reg.summary())

# Estatística t
print((Reg.params['lnox'] + 1) / Reg.bse['lnox'])