**** CHAPTER 2

** EXAMPLE 2.12

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap2"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using meap93_2.log, replace

*Importando dados
import excel "meap93.xls", firstrow clear



*Sumário
summarize

*Regressão - eststo salva resultados
eststo ex2_12: reg math10 lnchprg

esttab ex2_12 using "tabela2_12.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
	(1)
			math10
lnchprg		-0.319***
			(0.0348)
		
_cons		32.14***
			(0.998)
Obs.		408
R2			0.171
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/



** Exemplo 2.12: ressaltar o R^2 da regressão

display e(r2)


log close
