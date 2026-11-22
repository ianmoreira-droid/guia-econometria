# Exemplo 10.10
import wooldridge as woo
import statsmodels.formula.api as smf

data = woo.dataWoo('hseinv')

# Detrending
reg_invpc_t = smf.ols('linvpc ~ t', data=data).fit()
data['linvpc_dt'] = reg_invpc_t.resid

reg_price_t = smf.ols('lprice ~ t', data=data).fit()
data['lprice_dt'] = reg_price_t.resid

# Regressão
model = smf.ols('linvpc_dt ~ lprice_dt', data=data).fit()
print(model.summary())