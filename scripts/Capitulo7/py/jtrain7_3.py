# Exemplo 7.3
import wooldridge as woo
import statsmodels.formula.api as smf

dados = woo.data('jtrain')

Reg = smf.ols(
    formula='hrsemp ~ grant + lsales + lemploy',
    data=dados[dados['year'] == 1988]
).fit()

print(Reg.summary())

print(Reg.tvalues['grant'])
print(Reg.tvalues['lemploy'])