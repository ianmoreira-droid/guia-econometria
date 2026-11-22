# Exemplos 9.8 e 9.9
import wooldridge as woo
import pandas as pd
import statsmodels.formula.api as smf
import matplotlib.pyplot as plt

# Importar base de dados
dados = woo.data('rdchem')

# Exemplo 9.8

Reg1 = smf.ols(
    formula='rdintens ~ sales + profmarg',
    data=dados
).fit()

print(Reg1.summary())


Reg2 = smf.ols(
    formula='rdintens ~ sales + profmarg',
    data=dados[dados['sales'] < 20000]
).fit()

print(Reg2.summary())

# Gráfico

plt.figure(figsize=(8, 6))

plt.scatter(dados['sales'], dados['rdintens'])

# Seta indicando o possível outlier
plt.annotate(
    '',
    xy=(39000, 3.8),
    xytext=(34500, 5.6),
    arrowprops=dict(arrowstyle='->', color='black')
)

# Texto
plt.text(
    34500, 6.1,
    'possible\noutlier',
    ha='center'
)

# Eixos
plt.xlabel('firm sales (in millions of dollars)')
plt.ylabel('R&D as a percentage of sales')

plt.xticks([0, 10000, 20000, 30000, 40000])
plt.yticks([0, 5, 10])

# Aparência
plt.legend([], [], frameon=False)
plt.gca().set_facecolor('white')
plt.gcf().set_facecolor('white')

plt.tight_layout()

# Exibir gráfico
plt.show()

# Exportar gráfico
plt.savefig('figura9_8.png', dpi=300, bbox_inches='tight')
plt.savefig(r'C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Python\Exemplos\Cap9\figura9_8.png',
            dpi=300, bbox_inches='tight')

# Exemplo 9.9
Reg3 = smf.ols(
    formula='lrd ~ lsales + profmarg',
    data=dados
).fit()

print(Reg3.summary())

Reg4 = smf.ols(
    formula='lrd ~ lsales + profmarg',
    data=dados[dados['sales'] < 20000]
).fit()

print(Reg4.summary())