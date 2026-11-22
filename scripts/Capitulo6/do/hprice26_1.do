** CAPITULO 6

***EXEMPLO 6.1

clear all
set more off

capture log close 

cd "C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap6"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using ex6_1.log, replace

*Importando dados
import excel "hprice2.xls", firstrow clear

label variable price        " median housing price, $"
label variable crime        " crimes committed per capita"
label variable nox          " nitrous oxide, parts per 100 mill."
label variable rooms        " avg number of rooms per house"
label variable dist         " weighted dist. to 5 employ centers"
label variable radial       " accessibiliy index to radial hghwys"
label variable proptax      " property tax per $1000"
label variable stratio      " average student-teacher ratio"
label variable lowstat      " % of people 'lower status'"
label variable lprice       " log(price)"
label variable lnox         " log(nox)"
label variable lproptax     " log(proptax)"
label variable ldist        " log(dist)"

summarize

egen zprice = std(price)
egen znox = std(nox)
egen zcrime = std(crime)
egen zrooms = std(rooms)
egen zdist = std(dist)
egen zstratio = std(stratio)
/*
O comando egen cria variáveis usando funções
Poderia ser usado o comando gen, mas seria preciso 
definir as variáveis uma por uma, assim:
gen zx = (x - r(mean))/r(sd)
a função std já faz o lado direito da igualdade
*/
*Regressão - eststo salva resultados
eststo ex6_1: reg zprice znox zcrime zrooms zdist zstratio

esttab ex6_1 using "tabela6_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
	(1)
			zprice
znox		-0.340***
			(0.0445)
	
zcrime		-0.143***
			(0.0307)
	
zrooms		0.514***
			(0.0300)
	
zdist		-0.235***
			(0.0430)
	
zstratio	-0.270***
			(0.0300)
	
_cons		6.61e-09
			(0.0270)
Obs.		506
R2			0.636
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

log close
