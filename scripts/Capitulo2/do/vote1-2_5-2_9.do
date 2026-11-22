**** CHAPTER 2

** EXAMPLE 2.5 e 2.9

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap2"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using vote1_Cap2.log, replace

*Importando dados
import excel "vote1.xls", firstrow clear

*Sumário
summarize

*Regressão - eststo salva resultados
eststo ex2_5: reg voteA shareA 

esttab ex2_5 using "tab2_5.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
	    voteA
shareA	 6.506***
	    (0.628)
	
_cons	17.81***
	    (3.313)

Obs.	173
R2  	0.385
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

** FAZER O VOTO PREDITO PELO MODELO LINEAR - NA SEQUENCIA, O GRAFICO

predict voteA_pred, xb

twoway (scatter voteA_pred shareA), ytitle(Voto Predito) xtitle(Porcentagem dos gastos candA) title(Regressao Linear - Exemplo 2.5) 
graph save "Graph" "graph_ex_2_5.gph"

** Exemplo 2.9: ressaltar o R^2 da regressão

display e(r2)


log close
