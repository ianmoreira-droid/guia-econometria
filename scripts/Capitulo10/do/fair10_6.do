**** CHAPTER 10

** EXAMPLE 10.6

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap10"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using fair_10_6.log, replace

*Importando dados
import excel "fair.xls", firstrow clear

*Sumário
summarize

** Regressão - eststo salva resultados - No conjunto restrito de variáveis
eststo ex10_6: reg demvote partyWH incum pWHgnews pWHinf if year < 1996
display e(r2)

esttab ex10_6 using "fair10_6.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

*Prever valor em 1996
predict demvote_hat
list year demvote demvote_hat if year==1996
/*
			demvote
partyWH		-0.0435
			(0.0405)
	
incum		0.0544**
			(0.0234)
	
pWHgnews	0.0108**
			(0.00413)
	
pWHinf		-0.00770**
			(0.00326)
	
_cons		0.481***
			(0.0123)
Obs.		20
R2			0.663
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

valor predito em 1996 0.5012655
valor de fato em 1996 0.5465
*/



log close
