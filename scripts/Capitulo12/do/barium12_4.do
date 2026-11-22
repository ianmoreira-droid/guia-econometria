**** CHAPTER 12

** EXAMPLE 12.4

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap12"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using barium_12_4.log, replace

*Importando dados
import excel "barium.xls", firstrow clear

*Sumário
summarize

** Regressão 12.4
eststo ex12_4: reg lchnimp lchempi lgas lrtwex befile6 affile6 afdec6
display e(r2)

esttab ex12_4 using "barium12_4.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
display _b[afdec6] / _se[afdec6]
/*
			lchnimp
lchempi		3.117***
			(0.479)
	
lgas		0.196
			(0.907)
	
lrtwex		0.983**
			(0.400)
	
befile6		0.0596
			(0.261)
	
affile6		-0.0324
			(0.264)
	
afdec6		-0.565*
			(0.286)
	
_cons		-17.80
			(21.05)
Obs.		131
R2			0.305
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
tsset t
eststo ex12_41: prais lchnimp lchempi lgas lrtwex befile6 affile6 afdec6


esttab ex12_41 using "barium12_41.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 rho, ///
          labels("Obs." "R²" "Rho"))
display _b[afdec6] / _se[afdec6]	  
/*
		lchnimp
lchempi	2.941***
		(0.633)
	
lgas	1.046
		(0.977)
	
lrtwex	1.133**
		(0.507)
	
befile6	-0.0165
		(0.319)
	
affile6	-0.0332
		(0.322)
	
afdec6	-0.577*
		(0.342)
	
_cons	-37.08
		(22.78)
Obs.	131
R²		0.202
Rho		0.293
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

tafdec6 = -1.686653
*/

log close
