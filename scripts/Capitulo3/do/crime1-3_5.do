**** CHAPTER 3

** EXAMPLE 3.5

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap3"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using crime1_3_5.log, replace

*Importando dados
import excel "crime1.xls", firstrow clear

*Sumário
summarize

* Parte 1 do exemplo
** Regressão - eststo salva resultados
eststo ex3_51: reg narr86 pcnv ptime86 qemp86

esttab ex3_51 using "tabcrime1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
	narr86
pcnv	-0.150***
	    (0.0409)
	
ptime86	-0.0344***
	    (0.00859)
	
qemp86	-0.104***
	    (0.0104)
	
_cons	0.712***
	    (0.0330)
Obs.	2725
R2	0.0413
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

* Parte 2 do exemplo
eststo ex3_52: reg narr86 pcnv avgsen ptime86 qemp86

esttab ex3_52 using "tabcrime1-2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
	narr86
pcnv	-0.151***
	    (0.0409)
	
avgsen	0.00744
	   (0.00473)
	
ptime86	-0.0374***
	    (0.00879)
	
qemp86	-0.103***
	    (0.0104)
	
_cons	0.707***
	   (0.0332)
Obs.	2725
R2	0.0422
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

log close
