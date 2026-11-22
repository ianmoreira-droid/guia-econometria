# Exemplo 10.8
import wooldridge as woo
import statsmodels.formula.api as smf

data = woo.dataWoo('fertil3')

# Regressão
model1 = smf.ols('gfr ~ pe + ww2 + pill + t', data=data).fit()
print(model1.summary())

model2 = smf.ols('gfr ~ pe + ww2 + pill + t + tsq', data=data).fit()
print(model2.summary())