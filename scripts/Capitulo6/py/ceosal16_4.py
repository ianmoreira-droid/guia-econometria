# Exemplo 6.4
import wooldridge
import statsmodels.formula.api as smf

# Carregar os dados
dados = wooldridge.data('ceosal1')

# 1° Reg
Reg1 = smf.ols('salary ~ sales + roe', data=dados).fit()
print(Reg1.summary())

# 2° Reg
Reg2 = smf.ols('lsalary ~ lsales + roe', data=dados).fit()
print(Reg2.summary())

# Soma dos quadrados de salary
media = dados['salary'].mean()
dados['dev2'] = (dados['salary'] - media)**2

TSS = dados['dev2'].sum()
print(TSS)

# Soma dos quadrados de lsalary
medialog = dados['lsalary'].mean()
dados['dev2log'] = (dados['lsalary'] - medialog)**2

TSSlog = dados['dev2log'].sum()
print(TSSlog)