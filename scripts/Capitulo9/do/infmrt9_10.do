**** CHAPTER 9

** EXAMPLE 9.10

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap9"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using infmrt_9_10.log, replace

*Importando dados
import excel "infmrt.xls", firstrow clear

*Sumário
summarize

*** Exemplo 9.10

*Regressão 1
eststo ex9_101: reg infmort lpcinc lphysic lpopul if d90 == 1

esttab ex9_101 using "tab9_10_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
			infmort
lpcinc		-4.685*
			(2.604)
	
lphysic		4.153***
			(1.513)
	
lpopul		-0.0878
			(0.287)
	
_cons		33.86
			(20.43)
Obs.		51
R2			0.139
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01


*/

*Regressão 2
eststo ex9_102: reg infmort lpcinc lphysic lpopul if d90 == 1 & DC == 0

esttab ex9_102 using "tab9_10_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))


/*
			infmort
lpcinc		-0.567
			(1.641)
	
lphysic		-2.742**
			(1.191)
	
lpopul		0.629***
			(0.191)
	
_cons		23.95*
			(12.42)
Obs.		50
R2			0.273
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Retirar a observação de Washington DC, alterou os coeficientes
e sua relevância estatística, o que muda também as conclusões 
da regressão
*/	

log close
