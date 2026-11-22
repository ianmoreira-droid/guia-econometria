**** CHAPTER 9

** EXAMPLE 9,2

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap9"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using hprice1_9_2.log, replace

*Importando dados
import excel "hprice1.xls", firstrow clear

*Sumário
summarize

*** Exemplo 9.2

*Regressão 1
eststo ex9_21: reg price lotsize sqrft bdrms

* Teste RESET de Ramsey
predict yhat

gen yhat2 = yhat^2
gen yhat3 = yhat^3

reg price lotsize sqrft bdrms yhat2 yhat3

test yhat2 yhat3


esttab ex9_21 using "tab9_2_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
		price
lotsize	0.00207***
		(0.000642)
	
sqrft	0.123***
		(0.0132)
	
bdrms	13.85
		(9.010)
	
_cons	-21.77
		(29.48)
Obs.	88
R2		0.672
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

F =  4.67
p-valor = 0.0120
Rejeita H0, há evidência de erro de forma funcional
*/

*Regressão 2
eststo ex9_22: reg lprice llotsize lsqrft bdrms

* Teste RESET de Ramsey
predict yhat1

gen yhat1_2 = yhat1^2
gen yhat1_3 = yhat1^3

reg lprice llotsize lsqrft bdrms yhat1_2 yhat1_3

test yhat1_2 yhat1_3
esttab ex9_22 using "tab9_2_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))


/*
			lprice
llotsize	0.168***
			(0.0383)
	
lsqrft		0.700***
			(0.0929)
	
bdrms		0.0370
			(0.0275)
	
_cons		-1.297**
			(0.651)
Obs.		88
R2			0.643
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

F = 2.57
p-valor = 0.0831
Não rejeita H0 a 5%(mesmo rejeitando a 10%)
Esse modelo indica forma funcional mais adequada
*/	


log close
