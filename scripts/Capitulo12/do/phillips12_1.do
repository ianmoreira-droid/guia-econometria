**** CHAPTER 12

** EXAMPLE 12.1

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap12"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using phillips_12_1.log, replace

*Importando dados
import excel "phillips.xls", firstrow clear

*Sumário
summarize
destring unem_1 inf_1 unem_2 inf_2 cunem cinf cunem_1 cinf_1, replace
summarize

** Regressão - eststo salva resultados - No conjunto restrito de variáveis
eststo ex12_1: reg inf unem
display e(r2)

esttab ex12_1 using "phillips12_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

predict uhat, resid
tsset year
gen Luhat = L.uhat
reg uhat Luhat
/*
		(1)
		inf
unem	0.468
	   (0.289)
	
_cons	1.424
	   (1.719)
Obs.	49
R2		0.0527
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

pchapeu = .5729695
t = 4.93
p-valor = 0 
Evidencia forte de autocorrelação serial positiva 
de primeira ordem 
(pchapeu é o beta1 da regressão uhat Luhat
*/


* Regressão da 11.5:
eststo ex12_1_1: reg cinf unem
display e(r2)

esttab ex12_1_1 using "phillips12_11.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

predict uhat2, resid
tsset year
gen Luhat2 = L.uhat2
reg uhat2 Luhat2
/*
		cinf
unem	-0.543**
		(0.230)
	
_cons	3.031**
		(1.377)
Obs.	48
R2		0.108
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

pchapeu = -.0355928 
t =  -0.29
p-valor = 0.775 
Não há evidência de autocorrelação forte, indicando 
que esse modelo é melhor
*/

log close
