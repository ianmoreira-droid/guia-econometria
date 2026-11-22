#Exemplo 12.1
import pandas as pd
import statsmodels.api as sm
from wooldridge import data
import os

os.chdir("C:\\Users\\ianpm\\Desktop\\Ian\\Faculdade\\UFBA\\PIBIC\\Python\\Exemplos\\Cap12")

# Exemplo 12.1
phillips = data("phillips")

# Registrações somente até 1996
phillips_96 = phillips[phillips["year"] <= 1996].copy()

# Regressão 10.1
X = sm.add_constant(phillips_96["unem"])
Reg = sm.OLS(phillips_96["inf"], X).fit()

print(Reg.summary())

# Teste Reg1
uhat = Reg.resid
Luhat = uhat.shift(1)

dados = pd.DataFrame({"uhat": uhat, "Luhat": Luhat}).dropna()

X = sm.add_constant(dados["Luhat"])
Reg1_2 = sm.OLS(dados["uhat"], X).fit()

print(Reg1_2.summary())


# Regressão 11.5
dados2 = phillips_96.dropna(subset=["cinf", "unem"])

X = sm.add_constant(dados2["unem"])
Reg2 = sm.OLS(dados2["cinf"], X).fit()

print(Reg2.summary())

# Teste Reg2
uhat2 = Reg2.resid.dropna().reset_index(drop=True)
Luhat2 = uhat2.shift(1)
dados2 = pd.DataFrame({
    "uhat2": uhat2,
    "Luhat2": Luhat2
}).dropna()


X = sm.add_constant(dados2["Luhat2"])
Reg2_2 = sm.OLS(dados2["uhat2"], X).fit()

print(Reg2_2.summary())