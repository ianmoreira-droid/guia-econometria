**** CHAPTER 7

** EXAMPLE 7.4

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap7"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using hprice1_7.log, replace

*Importando dados
import excel "hprice1.xls", firstrow clear

*Sumário
summarize

*Regressões 7.4
eststo ex7_4: reg lprice llotsize lsqrft bdrms colonial

esttab ex7_4 using "tab7_4.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
			lprice
llotsize	0.168***
			(0.0382)
	
lsqrft		0.707***
			(0.0928)
	
bdrms		0.0268
			(0.0287)
	
colonial	0.0538
			(0.0448)
	
_cons		-1.350**
			(0.651)
Obs.		88
R2			0.649
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Pela estimação a casa tendo estilo colonial aumenta o preço em
~5.4%
*/

log close
