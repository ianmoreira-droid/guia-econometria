# Exemplo 4.6
import statsmodels.formula.api as smf
from scipy import stats
import pandas as pd

dados = pd.read_excel(
    r"C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap4/401k.xls"
)

# Regressão
Reg = smf.ols('prate ~ mrate + age + totemp', data=dados).fit()

print(Reg.summary())

# Teste t e seu p-valor
t = Reg.params['totemp'] / Reg.bse['totemp']
pvalor = 2 * stats.t.sf(abs(t), df=Reg.df_resid)

print(t)
print(pvalor)