# Exemplo 11.6
import statsmodels.api as sm
from wooldridge import data
import os

os.chdir("C:\\Users\\ianpm\\Desktop\\Ian\\Faculdade\\UFBA\\PIBIC\\Python\\Exemplos\\Cap11")

fertil3 = data("fertil3")

fertil3 = fertil3.sort_values("year")

# Autocorrelação
print(fertil3["gfr"].corr(fertil3["gfr"].shift(1)))
print(fertil3["pe"].corr(fertil3["pe"].shift(1)))

# Regressão
X1 = sm.add_constant(fertil3["cpe"])
Reg1 = sm.OLS(fertil3["cgfr"], X1, missing="drop").fit()

print(Reg1.summary())

# Segunda regressão
X2 = sm.add_constant(fertil3[["cpe", "cpe_1", "cpe_2"]])
Reg2 = sm.OLS(fertil3["cgfr"], X2, missing="drop").fit()

print(Reg2.summary())