# Exemplo 8.1
import wooldridge
import statsmodels.formula.api as smf

# Carregar os dados
dados = wooldridge.data('wage1')

# Criar variáveis
dados['marrmale'] = ((dados['married'] == 1) & (dados['female'] == 0)).astype(int)
dados['marrfem'] = ((dados['married'] == 1) & (dados['female'] == 1)).astype(int)
dados['singfem'] = ((dados['married'] == 0) & (dados['female'] == 1)).astype(int)

# Reg
Reg = smf.ols(
    'lwage ~ marrmale + marrfem + singfem + educ + exper + expersq + tenure + tenursq',
    data=dados
).fit()

print(Reg.summary())

# Reg com erros-padrão robustos
Reg1 = Reg.get_robustcov_results(cov_type='HC1')

# Estatísticas t robustas
variaveis = ['marrmale', 'marrfem', 'singfem', 'educ',
             'exper', 'expersq', 'tenure', 'tenursq']

for v in variaveis:
    i = Reg.model.exog_names.index(v)
    print(f'{v} t = {Reg1.tvalues[i]}')