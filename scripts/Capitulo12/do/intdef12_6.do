**** CHAPTER 12

** EXAMPLE 12.6

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap12"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using intdef_12_6.log, replace

*Importando dados
use "http://fmwww.bc.edu/ec-p/data/wooldridge/intdef.dta", clear

*Sumário
summarize
destring ci3 cinf cdef i3_1, replace
summarize

** Regressão 1
eststo ex12_6: reg i3 inf def
display e(r2)

esttab ex12_6 using "tabelaintdef12_6.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	

predict uhat, resid
tsset year
gen Luhat = L.uhat
reg uhat Luhat
/*
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

rho = .6225242
*/
eststo ex12_61: reg ci3 cinf cdef
display e(r2)

esttab ex12_61 using "tabelaintdef12_61.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

predict uhat2, resid
tsset year
gen Luhat2 = L.uhat2
reg uhat2 Luhat2
/*
		ci3
cinf	0.149
		(0.0922)
	
cdef	-0.181
		(0.148)
	
_cons	0.0418
		(0.171)
Obs.	55
R2		0.176
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

rho2 =  .071925
correlação i3 e i3_1 = 0.8845
*/
corr i3 i3_1

log close
