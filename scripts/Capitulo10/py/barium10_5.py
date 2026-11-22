# Exemplo 10.5
import wooldridge as woo
import numpy as np
import statsmodels.formula.api as smf

data = woo.dataWoo('barium')

# Regressão
model = smf.ols('lchnimp ~ lchempi + lgas + lrtwex + befile6 + affile6 + afdec6', data=data).fit()

print(model.summary())

# Efeito percentual exato de afdec6
efeito_percentual = 100 * (np.exp(model.params['afdec6']) - 1)
print(f"Efeito percentual exato de afdec6: {efeito_percentual:.2f}%")