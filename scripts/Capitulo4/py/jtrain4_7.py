# Exemplo 4.7
import wooldridge
import statsmodels.formula.api as smf
from scipy import stats
import numpy as np

dados = wooldridge.data('jtrain')

# Regressão
Reg = smf.ols(
    formula='lscrap ~ hrsemp + lsales + lemploy',
    data=dados.query('year == 1987 & union == 0')
).fit()

print(Reg.summary())

# Efeito de 5 horas adicionais
print(100 * 5 * Reg.params['hrsemp'])

# Estatística t
print(Reg.params['hrsemp'] / Reg.bse['hrsemp'])

# p-valor unilateral
print(stats.t.sf(
    abs(Reg.params['hrsemp'] / Reg.bse['hrsemp']),
    df=Reg.df_resid
))