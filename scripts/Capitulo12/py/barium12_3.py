# Exemplo 12.3
import wooldridge
import pandas as pd
import statsmodels.api as sm
from statsmodels.stats.anova import anova_lm

# Dados
barium = wooldridge.data('barium')

# Regressão
Reg = sm.OLS(
    barium['lchnimp'],
    sm.add_constant(
        barium[['lchempi', 'lgas', 'lrtwex', 'befile6', 'affile6', 'afdec6']]
    )
).fit()

print(Reg.summary())

# Resíduos
barium['uhat'] = Reg.resid

# Defasagens dos resíduos
barium = barium.sort_values('t').copy()

barium['L1_uhat'] = barium['uhat'].shift(1)
barium['L2_uhat'] = barium['uhat'].shift(2)
barium['L3_uhat'] = barium['uhat'].shift(3)

# Segunda regressão
Reg2 = sm.OLS(
    barium['uhat'],
    sm.add_constant(
        barium[['lchempi', 'lgas', 'lrtwex', 'befile6', 'affile6', 'afdec6',
                'L1_uhat', 'L2_uhat', 'L3_uhat']]
    ),
    missing='drop'
).fit()

print(Reg2.summary())

# Teste conjunto: H0: L1_uhat = L2_uhat = L3_uhat = 0
teste = Reg2.f_test('L1_uhat = 0, L2_uhat = 0, L3_uhat = 0')

print(teste)