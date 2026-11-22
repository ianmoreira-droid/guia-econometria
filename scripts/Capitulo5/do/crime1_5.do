**** CHAPTER 5

** EXAMPLE 5.3

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\PIBIC\Stata\ExemplosWooldridge\Cap5"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using crime1_5_3.log, replace

*Importando dados
import excel "crime1.xls", firstrow clear

*Sumário
summarize

* Parte 1 do exemplo
** Regressão - eststo salva resultados - No conjunto restrito de variáveis
eststo ex5_3: reg narr86 pcnv ptime86 qemp86
display e(r2)


predict util, resid 
esttab ex5_3 using "tabcrime5_3.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
eststo ex5_32: reg util pcnv avgsen tottime ptime86 qemp86	
display e(r2)

esttab ex5_32 using "tabcrime5_32.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
scalar LM =  `e(N)' * `e(r2)' 
display LM
scalar LM2 =  `e(N)' * round(`e(r2)',0.0001) 
display LM2
/*
LM2 = 4.0875, arredondando seguindo o Wooldridge

*/



log close
