**** CHAPTER 2

** EXAMPLE 2.3, 2.6, 2.8 e 2.11

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap2"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using ceosal1_Cap2.log, replace

*Importando dados
import excel "ceosal1.xls", firstrow clear

*Sumário
summarize

*Regressão - eststo salva resultados
eststo ex2_3: reg salary roe 

esttab ex2_3 using "tab2_3.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
		  salary
roe	      18.50*
	     (11.12)
	
_cons	  963.2***
	     (213.2)

Obs.	  209
R2	      0.0132
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
** FAZER O WAGE PREDITO PELO MODELO LINEAR - NA SEQUENCIA, O GRAFICO

predict salary_pred, xb

twoway (scatter salary_pred roe), ytitle(Salario Predito) xtitle(Retorno Sobre PL) title(Regressao Linear - Exemplo 2.3) 
graph save "Graph" "graph_ex_2_3.gph"

** Exemplo 2.6
predict salaryhat
predict uhat, residuals

list roe salary salaryhat uhat in 1/15
** Exemplo 2.8 R^2
display e(r2)

** Exemplo 2.11

eststo ex2_11: reg lsalary lsales

esttab ex2_11 using "tabela2_11.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
		lsalary
lsales	0.257***
		(0.0345)
	
_cons	4.822***
		(0.288)
Obs.	209
R2		0.211
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
predict lsalary_pred, xb

* Gráfico 2.11
twoway (scatter lsalary_pred lsales), ///
    ytitle(LogSalario Predito) ///
    xtitle(Log(Vendas)) ///
    title(Log do Salario do CEO vs Log das Vendas)
graph save "Graph" "graph_ex_2_11.gph"

log close
