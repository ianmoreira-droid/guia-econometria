# Exemplo 10.6
import wooldridge as woo
import statsmodels.formula.api as smf

data = woo.dataWoo('fair')

# Regressão (amostra restrita a anos anteriores a 1996)
model = smf.ols('demvote ~ partyWH + incum + pWHgnews + pWHinf',
                 data=data,
                 subset=data['year'] < 1996).fit()

print(model.summary())

# Prever valor em 1996
data['demvote_hat'] = model.predict(data)

print(data.loc[data['year'] == 1996, ['year', 'demvote', 'demvote_hat']])