**** CHAPTER 8

** EXAMPLE 8.6

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap8"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using subs401k_8_6.log, replace

*Importando dados
import excel "401ksubs.xls", firstrow clear

*Sumário
summarize
gen age25_2 = (age - 25)^2
keep if fsize == 1
*Regressões 8.6
* Primeira reg 
eststo ex8_6_1: reg nettfa inc, vce(robust)

esttab ex8_6_1 using "tab8_6_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
predict uhat1, resid
gen uhat1_sq = uhat1^2
reg uhat1_sq inc
display "t de inc = " _b[inc]/_se[inc]
/*
		nettfa
inc		0.821***
		(0.104)
	
_cons	-10.57***
		(2.530)
Obs.	2017
R2		0.0827
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

* Segunda reg
eststo ex8_6_2: reg nettfa inc [aw=1/inc]

esttab ex8_6_2 using "tab8_6_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
scalar r2_r = e(r2)
/*
		nettfa
inc		0.787***
		(0.0635)
	
_cons	-9.581***
		(1.653)
Obs.	2017
R2		0.0709
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

* Terceira reg
eststo ex8_6_3: reg nettfa inc age25_2 male e401k, vce(robust)

esttab ex8_6_3 using "tab8_6_3.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
		nettfa
inc		0.771***
		(0.0996)
	
age25_2	0.0251***
		(0.00434)
	
male	2.478
		(2.058)
	
e401k	6.886***
		(2.287)
	
_cons	-20.98***
		(3.495)
Obs.	2017
R2		0.128
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
	
* Quarta reg
eststo ex8_6_4: reg nettfa inc age25_2 male e401k [aw=1/inc]

esttab ex8_6_4 using "tab8_6_4.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
scalar r2_ur = e(r2)
test age25_2 male e401k
/*
		nettfa
inc		0.740***
		(0.0643)
	
age25_2	0.0175***
		(0.00193)
	
male	1.841
		(1.564)
	
e401k	5.188***
		(1.703)
	
_cons	-16.70***
		(1.958)
Obs.	2017
R2		0.112
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
* Tabela conjunta
esttab ex8_6_1 ex8_6_2 ex8_6_3 ex8_6_4 using "tab8_6.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2")) ///
    mtitles("(1) MQO" "(2) MQP" "(3) MQO" "(4) MQP")
* Teste F da 2 e 4
scalar F = ((r2_ur - r2_r)/3) / ((1 - r2_ur)/2012)
display "F = " F
display "p-valor = " Ftail(3, 2012, F)
log close
