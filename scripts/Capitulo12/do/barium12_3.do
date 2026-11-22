**** CHAPTER 12

** EXAMPLE 12.3

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap12"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using barium_12_3.log, replace

*Importando dados
import excel "barium.xls", firstrow clear

*Sumário
summarize

** Regressão 12.3
eststo ex12_3: reg lchnimp lchempi lgas lrtwex befile6 affile6 afdec6
display e(r2)

esttab ex12_3 using "barium12_3.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
predict uhat, resid
tsset t
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
eststo ex12_31: reg uhat lchempi lgas lrtwex befile6 afdec6 affile6 L(1/3).uhat
esttab ex12_31 using "barium12_31.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
testparm L(1/3).uhat	
/*
			uhat
lchempi		-0.143
			(0.472)	
lgas		0.623
			(0.886)
lrtwex		0.179
			(0.391)
befile6		-0.0859
			(0.251)
afdec6		-0.0668
			(0.274)
affile6		-0.122
			(0.255)
L.uhat		0.221**
			(0.0917)
L2.uhat		0.134
			(0.0922)
L3.uhat		0.126
			(0.0911)	
_cons		-14.37
			(20.66)
Obs.		128
R2			0.116
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

estatística F conjunta dos 3 lags =  5.12
p-valor = 0.0023
*/


log close
