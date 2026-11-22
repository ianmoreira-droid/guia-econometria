# Exemplo 6.8
import wooldridge
import numpy as np
import statsmodels.formula.api as smf
from scipy.stats import t

# Carregar os dados
dados = wooldridge.data('ceosal2')

# Regressão
Reg = smf.ols('salary ~ sales + mktval + ceoten', data=dados).fit()
print(Reg.summary())

Reg1 = smf.ols('lsalary ~ sales + mktval + ceoten', data=dados).fit()

# Predição e intervalo de predição de 95%
lsalary_hat = Reg1.fittedvalues.iloc[0]

se_fit = Reg1.get_prediction().summary_frame()['mean_se'].iloc[0]
se_salary = np.sqrt(Reg1.mse_resid + se_fit**2)

critico = t.ppf(0.975, df=Reg1.df_resid)

lower_log = lsalary_hat - critico * se_salary
upper_log = lsalary_hat + critico * se_salary

lower_y = np.exp(lower_log)
upper_y = np.exp(upper_log)

print(lower_log)
print(upper_log)
print(lower_y)
print(upper_y)