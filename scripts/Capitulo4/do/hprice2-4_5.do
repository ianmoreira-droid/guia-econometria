**** CHAPTER 4

** EXAMPLE 4.5 

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap4"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using hprice24_5.log, replace

*Importando dados
import excel "hprice2.xls", clear
ds
rename (A-M) (price crime nox rooms dist radial proptax stratio lowstat lprice lnox lproptax ldist)

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

*Sumário
summarize

*Regressão 1 - eststo salva resultados
eststo ex4_2: reg lprice lnox ldist rooms stratio

esttab ex4_2 using "tab4_5.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

display e(r2)
di (_b[lnox]+1)/_se[lnox]
/*
		lprice
lnox	 -0.954***
	     (0.117)
	
ldist	 -0.134***
	     (0.0431)
	
rooms	 0.255***
	     (0.0185)
	 
stratio	-0.0525***
	    (0.00590)
	
_cons	11.08***
	    (0.318)
Obs.	506
R2	    0.584
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01


df = n - k - 1 = 506 - 4 - 1 = 501

Testando Beta_lnox = -1
H_1 Beta_lnox != -1
estatística t para lnox
t = (-0.954 + 1)/0.117 = 0.393 (.39797448) o ultimo foi calculado pelo Stata
Para valores baixos de t, mesmo com altos níveis de significância, 
há pouca evidência estatística que Beta_lnox != -1
*/

log close
