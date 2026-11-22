**** CHAPTER 10

** EXAMPLE 10.2

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap10"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using intdef_10_2.log, replace

*Importando dados
use "http://fmwww.bc.edu/ec-p/data/wooldridge/intdef.dta", clear

*Sumário
summarize

** Regressão - eststo salva resultados - No conjunto restrito de variáveis
eststo ex10_2: reg i3 inf def
display e(r2)

esttab ex10_2 using "tabelaintdef10_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

	
/*
		(1)
		i3
inf		0.606***
		(0.0821)
	
def		0.513***
		(0.118)
	
_cons	1.733***
		(0.432)
Obs.	56
R2		0.602
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/



log close
