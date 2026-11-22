**** CHAPTER 10

** EXAMPLE 10.1

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap10"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using phillips_10_1.log, replace

*Importando dados
import excel "phillips.xls", firstrow clear

*Sumário
summarize
destring unem_1 inf_1 unem_2 inf_2 cunem cinf cunem_1 cinf_1, replace
summarize

** Regressão - eststo salva resultados - No conjunto restrito de variáveis
eststo ex10_1: reg inf unem
display e(r2)

esttab ex10_1 using "phillips10_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

	
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

Por macroeconomia, a relação entre inflação e desemprego é negativa
no curto prazo, como os dados estão em anos isso influencia 
no resultado mostrando um impacto positivo do desemprego na inflação
ao longo do tempo

*/



log close
