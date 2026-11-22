# Exemplo 11.6
import statsmodels.formula.api as smf
from wooldridge import data
import os

os.chdir("C:\\Users\\ianpm\\Desktop\\Ian\\Faculdade\\UFBA\\PIBIC\\Python\\Exemplos\\Cap11")
fertil3 = data("fertil3")

# Regressão
Reg1 = smf.ols(
    "cgfr ~ cpe + cpe_1 + cpe_2 + cgfr_1",
    data=fertil3
).fit()

print(Reg1.summary())