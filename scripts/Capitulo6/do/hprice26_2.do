** CAPITULO 6

***EXEMPLO 6.2

clear all
set more off

capture log close 

cd "C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap6"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using ex6_2.log, replace

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



*Regressão - eststo salva resultados
eststo ex6_2: reg lprice lnox ldist rooms c.rooms#c.rooms stratio

esttab ex6_2 using "tabela6_2test.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

gen double lnprice2 =  _b[_cons]  + _b[rooms]*rooms + _b[c.rooms#c.rooms]*rooms^2 

* Gráfico logprice e rooms
twoway (line lnprice2 rooms), ///
    title("Figure 6.1 log(price) as a quadratic function of rooms") ///
    ylabel(6(3)18) xlabel(4.4) 
graph export "Exemplo6_2.png", replace

*Valor ótimo de quartos
display abs(_b[rooms])/(2*_b[c.rooms#c.rooms])


*Margens
margins, dydx(rooms) at(rooms=(5 6 7))
matrix list r(table)
/*
					(1)
					lprice
lnox				-0.902***
					(0.115)
		
ldist				-0.0868**
					(0.0433)
	
rooms				-0.545***
					(0.165)
	
c.rooms#c.rooms		0.0623***
					(0.0128)
	
stratio				-0.0476***
					(0.00585)
	
_cons				13.39***
					(0.566)
Obs.				506
R2					0.603
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

por derivação a quantidade otima de quartos será:
-0.545 + 2*0.0623rooms = 0
rooms = 4.3776283 ~= 4.4

para mostrar a variação na margem, como economista usa-se margins
para rooms = 5, variação de 7,7%
para rooms = 6, variação de 20,2%
para rooms = 7, variação de 32,6%
resultados diferentes dado a aproximação que Wooldridge fez
*/


log close
