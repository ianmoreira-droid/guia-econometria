**** CHAPTER 4

** EXAMPLE 4.7 

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap4"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using jtrain4_7.log, replace

*Importando dados
import excel "jtrain.xlsx", firstrow clear

*Sumário
summarize

*Regressão 1 - eststo salva resultados
eststo ex4_7: reg lscrap hrsemp lsales lemploy if !missing(lscrap, hrsemp, lsales, lemploy) & (year == 1987 & union == 0)

esttab ex4_7 using "tab4_7.rtf", replace ///
se star(* 0.10 ** 0.05 *** 0.01) ///   
stats(N r2, labels("Obs." "R2"))

display e(r2)
* Efeito de 5 horas adicionais
display 100 * 5 * (_b[hrsemp])

* Estatistica t e pvalor
display _b[hrsemp] / _se[hrsemp]
display ttail(25, abs(_b[hrsemp] / _se[hrsemp]))
/*
		lscrap
hrsemp	-0.0293
		(0.0228)
	
lsales	-0.962**
		(0.453)
	
lemploy	0.761*
		(0.407)
	
_cons	12.46**
		(5.687)
Obs.	29
R2		0.262
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01


df = n - k - 1 = 29 - 3 - 1 = 25
c = -1,316
estatística t para 
t = -1.2834529
pvalor = .10555162

valores obtidos são diferentes do que o wooldridge 
apresentada dada a não aproximação do dados pelo Stata
*/

log close
