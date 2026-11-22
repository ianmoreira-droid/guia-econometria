# Exemplo 7.2
import wooldridge
import statsmodels.formula.api as smf

dados = wooldridge.data('gpa1')

Reg = smf.ols('colGPA ~ PC + hsGPA + ACT', data=dados).fit()
print(Reg.summary())

# Valor t
print(Reg.params['PC'] / (Reg.cov_params().loc['PC', 'PC'] ** 0.5))

# Regressão para teste de PC
reg1 = smf.ols('colGPA ~ PC', data=dados).fit()

print(reg1.params['PC'])
print(reg1.cov_params().loc['PC', 'PC'] ** 0.5)
print(reg1.params['PC'] / (reg1.cov_params().loc['PC', 'PC'] ** 0.5))