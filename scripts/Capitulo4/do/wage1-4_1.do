**** CHAPTER 4

** EXAMPLE 4.1 

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap4"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using wage1_41.log, replace

*Importando dados
import excel "wage1.xls", firstrow clear

*Sumário
summarize

*Regressão - eststo salva resultados
eststo ex4_1: reg lwage educ exper tenure


***** TABELA COM O RESULTADO  - SAlVA O ARQUIVO NO SEU DIRETORIO
esttab ex4_1 using "tab4_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

display e(r2)
di _b[exper]/_se[exper]
/*
	    lwage
educ	0.0920***
	   (0.00733)
	
exper	0.00412**
	    (0.00172)
	
tenure	0.0221***
	    (0.00309)
	
_cons	0.284***
	   (0.104)

Obs.	526
R2	    0.316
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

df = n - k - 1 = 526 - 3 - 1 = 522

valor critico c a 1% e 522 df
c = 2.326
estatística t para exper
t = 0.00412/ 0.00172 = 2.395
2.395 > 2.326
logo, rejeita H_0 a 1%
*/


log close
