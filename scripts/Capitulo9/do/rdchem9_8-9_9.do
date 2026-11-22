**** CHAPTER 9

** EXAMPLE 9.8 e 9.9

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap9"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using rdchem_9_8_9.log, replace

*Importando dados
import excel "rdchem.xls", firstrow clear

destring _all, replace force
*Sumário
summarize

*** Exemplo 9.8

*Regressão 1
eststo ex9_81: reg rdintens sales profmarg

esttab ex9_81 using "tab9_8_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
			rdintens
sales		0.0000535
			(0.0000441)
		
profmarg	0.0447
			(0.0462)
	
_cons		2.623***
			(0.585)
Obs.		32
R2			0.0765
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

*Regressão 2
eststo ex9_82: reg rdintens sales profmarg if sales < 20000

esttab ex9_82 using "tab9_8_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
			rdintens
sales		0.000186**
			(0.0000842)
	
profmarg	0.0480
			(0.0445)
	
_cons		2.294***
			(0.592)
Obs.		31
R2			0.173
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/	
twoway ///
    (scatter rdintens sales) ///
    (pcarrowi 5.6 34500 3.8 39000, lcolor(black)) ///
    , ///
    text(6.1 34500 "possible" "outlier", justification(center)) ///
    xtitle("firm sales (in millions of dollars)") ///
    ytitle("R&D as a percentage of sales") ///
    xlabel(0 10000 20000 30000 40000) ///
    ylabel(0 4 5 10) ///
    legend(off) ///
    graphregion(color(white)) ///
    plotregion(color(white))
graph export "figura9_8.png", as(png) replace

*** Exemplo 9.9
*Regressão 1
eststo ex9_91: reg lrd lsales profmarg

esttab ex9_91 using "tab9_9_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
			lrd
lsales		1.084***
			(0.0602)
	
profmarg	0.0217
			(0.0128)
	
_cons		-4.378***
			(0.468)
Obs.		32
R2			0.918
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/	
*Regressão 2
eststo ex9_92: reg lrd lsales profmarg if sales < 20000

esttab ex9_92 using "tab9_9_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
			lrd
lsales		1.088***
			(0.0671)
	
profmarg	0.0218
			(0.0130)
	
_cons		-4.404***
			(0.511)
Obs.		31
R2			0.904
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Pra você responder:
Por que, que se testar a hipótese nula H0 = 1 
contra H1 > 1, não se rejeita H0?
*/
log close
