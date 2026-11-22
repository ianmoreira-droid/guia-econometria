# Exemplo 9.1
import statsmodels.formula.api as smf
from wooldridge import data
from statsmodels.stats.anova import anova_lm

dados = data('crime1')

# Regressão 1
Reg1 = smf.ols(
    'narr86 ~ pcnv + avgsen + tottime + ptime86 + qemp86 + inc86 + black + hispan',
    data=dados
).fit()

print(Reg1.summary())

# Regressão 2
Reg2 = smf.ols(
    'narr86 ~ pcnv + pcnvsq + avgsen + tottime + ptime86 + pt86sq + qemp86 + inc86 + inc86sq + black + hispan',
    data=dados
).fit()

print(Reg2.summary())

# Teste conjunto dos coeficientes das variáveis quadráticas
teste = Reg2.f_test('pcnvsq = 0, pt86sq = 0, inc86sq = 0')
print(teste)

# Pontos críticos das variáveis quadráticas
ponto_pcnv = -Reg2.params['pcnv'] / (2 * Reg2.params['pcnvsq'])
ponto_ptime86 = -Reg2.params['ptime86'] / (2 * Reg2.params['pt86sq'])
ponto_inc86 = -Reg2.params['inc86'] / (2 * Reg2.params['inc86sq'])

print("Ponto crítico de pcnv:", ponto_pcnv)
print("Ponto crítico de ptime86:", ponto_ptime86)
print("Ponto crítico de inc86:", ponto_inc86)