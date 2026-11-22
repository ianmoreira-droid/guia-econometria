# Exemplo 8.2
import wooldridge
import statsmodels.formula.api as smf

# Carregar os dados
dados = wooldridge.data('gpa3')

# 1° Reg
Reg = smf.ols(
    'cumgpa ~ sat + hsperc + tothrs + female + black + white',
    data=dados[dados['spring'] == 1]
).fit()

print(Reg.summary())

# Teste conjunto: black = 0 e white = 0
print(Reg.f_test('black = 0, white = 0'))

# 2° Reg com erros-padrão robustos
Reg1 = smf.ols(
    'cumgpa ~ sat + hsperc + tothrs + female + black + white',
    data=dados[dados['spring'] == 1]
).fit(cov_type='HC1')

# Estatísticas t robustas
variaveis = ['sat', 'hsperc', 'tothrs', 'female', 'black', 'white']

for v in variaveis:
    print(f'{v} t = {Reg1.tvalues[v]}')

# Teste conjunto com erros-padrão robustos
print(Reg1.f_test('black = 0, white = 0'))