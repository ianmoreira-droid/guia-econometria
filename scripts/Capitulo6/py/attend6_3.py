# Exemplo 6.3
import wooldridge
import statsmodels.formula.api as smf

# Carregar os dados
dados = wooldridge.data('attend')

# Regressão
Reg = smf.ols(
    formula='stndfnl ~ atndrte + priGPA + ACT + I(priGPA**2) + I(ACT**2) + priGPA:atndrte',
    data=dados
).fit()

print(Reg.summary())

# Efeito parcial de atndrte para priGPA = 2.59
efeito_parcial = (
    Reg.params['atndrte']
    + Reg.params['priGPA:atndrte'] * 2.59
)

print(efeito_parcial)