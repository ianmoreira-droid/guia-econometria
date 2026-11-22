# Exemplo 10.9
import wooldridge as woo
import statsmodels.formula.api as smf

data = woo.dataWoo('prminwge')

# Regressão
model = smf.ols('lprepop ~ lmincov + lusgnp + t', data=data).fit()
print(model.summary())