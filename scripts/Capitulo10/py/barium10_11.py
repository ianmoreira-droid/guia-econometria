# Exemplo 10.11
import wooldridge as woo
import statsmodels.formula.api as smf

data = woo.dataWoo('barium')

# Regressão
model = smf.ols('lchnimp ~ befile6 + affile6 + afdec6 + '
                 'feb + mar + apr + may + jun + jul + aug + sep + oct + nov + dec',
                 data=data).fit()
print(model.summary())

# Teste F conjunto das dummies sazonais
hipotese = ['feb = 0', 'mar = 0', 'apr = 0', 'may = 0', 'jun = 0',
            'jul = 0', 'aug = 0', 'sep = 0', 'oct = 0', 'nov = 0', 'dec = 0']
teste_f = model.f_test(hipotese)
print(teste_f)