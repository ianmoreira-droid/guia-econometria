**** CHAPTER 11

** EXAMPLE 11.5

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap11"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using phillips_11_5.log, replace

*Importando dados
import excel "phillips.xls", firstrow clear

*Sumário
summarize
destring unem_1 inf_1 unem_2 inf_2 cunem cinf cunem_1 cinf_1, replace
summarize

** Regressão - eststo salva resultados - No conjunto restrito de variáveis
eststo ex11_5: reg cinf unem
display e(r2)

esttab ex11_5 using "phillips11_5.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))


nlcom (-_b[_cons]/_b[unem])
/*
		(1)
		cinf
unem	-0.543**
		(0.230)
	
_cons	3.031**
		(1.377)
Obs.	48
R2		0.108
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

No exemplo segue o mi_0(desemprego natural) = beta0/(-beta1) = 5.5854288
dentro do intervalo comumente sugerido de 5 a 6%
e intervalo de confiança a 95% de 4.29 a 6.87
*/



log close
