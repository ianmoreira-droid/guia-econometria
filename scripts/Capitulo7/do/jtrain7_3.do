**** CHAPTER 7

** EXAMPLE 7.3 

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap7"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using jtrain7_3.log, replace

*Importando dados
import excel "jtrain.xlsx", firstrow clear

*Sumário
summarize

*Regressão 1 - eststo salva resultados
eststo ex7_3: reg hrsemp grant lsales lemploy if year == 1988

esttab ex7_3 using "tab7_3.rtf", replace ///
se star(* 0.10 ** 0.05 *** 0.01) ///   
stats(N r2, labels("Obs." "R2"))

display e(r2)
display _b[grant] / _se[grant]
display _b[lemploy] / _se[lemploy]
/*
		hrsemp
grant	26.25***
		(5.592)
	
lsales	-0.985
		(3.540)
	
lemploy	-6.070
		(3.883)
	
_cons	46.67
		(43.41)
Obs.	105
R2		0.237
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

tgrant = 4.6952074
tlemploy = -1.5632342
*/

log close
