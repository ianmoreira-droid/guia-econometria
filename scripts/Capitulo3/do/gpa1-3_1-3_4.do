**** CHAPTER 3

** EXAMPLE 3.1 e 3.4

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap3"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using gpa1_3.log, replace

*Importando dados
import excel "gpa1.xls", firstrow clear

*Sumário
summarize

*Regressão - eststo salva resultados
eststo ex3_1: reg colGPA hsGPA ACT

esttab ex3_1 using "gpa1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
	    colGPA
hsGPA	 0.453***
	     (0.0958)
	
ACT  	 0.00943
	    (0.0108)
	
_cons	1.286***
	    (0.341)

Obs.	141
R2  	0.176
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01


*/
** Exemplo 3.4: ressaltar o R^2 da regressão

display e(r2)


log close
