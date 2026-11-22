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

log using k401k4_6.log, replace

*Importando dados
import excel "401k.xls", firstrow clear

*Sumário
summarize

*Regressão 1 - eststo salva resultados
eststo ex4_6: reg prate mrate age totemp

esttab ex4_6 using "tab4_6.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

display e(r2)
* Teste t e seu p-valor
di _b[totemp]/_se[totemp]
display 2*ttail(e(df_r), abs(_b[totemp]/_se[totemp]))
/*
		prate
mrate	 5.441***
	    (0.524)
	
age	    0.269***
	    (0.0451)
	
totemp	-0.000130***
	    (0.0000367)
	
_cons	80.29***
	   (0.778)

Obs.	1534
R2	    0.0996
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

df = n - k - 1 = 1534 - 3 - 1 = 1530

estatística t para totemp
t = -0.000130/0.0000367 = -3.54  (-3.5345032)
p-valor = .0004207
no teste bicaudal, esse valor em módulo supera qualquer valor crítico 
mesmo os mais baixos

*/

log close
