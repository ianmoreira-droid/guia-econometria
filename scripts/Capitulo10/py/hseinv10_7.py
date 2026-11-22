# Exemplo 10.7
import wooldridge as woo
import statsmodels.formula.api as smf

data = woo.dataWoo('hseinv')

# Regressão
model = smf.ols('linvpc ~ lprice', data=data).fit()
print(model.summary())

model2 = smf.ols('linvpc ~ lprice + t', data=data).fit()
print(model2.summary())