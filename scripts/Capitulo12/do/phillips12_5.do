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

log using phillips_12_5.log, replace

*Importando dados
import excel "phillips.xls", firstrow clear

*Sumário
summarize
destring unem_1 inf_1 unem_2 inf_2 cunem cinf cunem_1 cinf_1, replace
summarize

** Regressão 10.1
eststo ex12_5: reg inf unem
display e(r2)

esttab ex12_5 using "phillips12_51.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

predict uhat, resid
tsset year
gen Luhat = L.uhat
reg uhat Luhat

** Regressão PW
eststo ex12_52: prais inf unem

esttab ex12_52 using "phillips12_52_pw.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 rho, ///
          labels("Obs." "R²" "Rho"))
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

pchapeu = .5729695 (reg uhat luhat)
t = 4.93
p-valor = 0 
Evidencia forte de autocorrelação serial positiva 
de primeira ordem 
*/

/*
Segunda Regressão
		inf
unem	-0.716**
		(0.313)
	
_cons	8.296***
		(2.231)
Obs.	49
R²		0.136
Rho		0.781
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01
*/
log close
