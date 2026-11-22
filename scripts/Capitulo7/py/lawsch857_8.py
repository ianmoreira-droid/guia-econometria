# Exemplo 7.8
import wooldridge
import numpy as np
import statsmodels.formula.api as smf

dados = wooldridge.data('lawsch85')

dados['r61_100'] = np.where(
    (dados.iloc[:, 0] >= 61) & (dados.iloc[:, 0] <= 100), 1, 0
)

Reg = smf.ols(
    'lsalary ~ top10 + r11_25 + r26_40 + r41_60 + r61_100 + LSAT + GPA + llibvol + lcost',
    data=dados
).fit()

print(Reg.summary())

# Efeito de estar no top 10 em %
print(100 * (np.exp(Reg.params['top10']) - 1))