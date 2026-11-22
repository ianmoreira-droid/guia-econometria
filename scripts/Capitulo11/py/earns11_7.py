# Exemplo 11.7
import statsmodels.formula.api as smf
from wooldridge import data
import os
os.chdir("C:\\Users\\ianpm\\Desktop\\Ian\\Faculdade\\UFBA\\PIBIC\\Python\\Exemplos\\Cap11")
# Base
earns = data("earns")

# Regressão 1
Reg = smf.ols("lhrwage ~ loutphr + t", data=earns).fit()

print(Reg.summary())

# Autocorrelação
Reg1_1 = smf.ols("lhrwage ~ t", data=earns).fit()
earns["u_hrwage"] = Reg1_1.resid

Reg1_2 = smf.ols("loutphr ~ t", data=earns).fit()
earns["u_outphr"] = Reg1_2.resid

# Ordenar por tempo
earns = earns.sort_values("t")

print(earns["u_hrwage"].corr(earns["u_hrwage"].shift(1)))

print(earns["u_outphr"].corr(earns["u_outphr"].shift(1)))

# Regressão 2
Reg2 = smf.ols("ghrwage ~ goutphr", data=earns).fit()

print(Reg2.summary())