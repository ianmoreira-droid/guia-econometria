**** CHAPTER 12

** EXAMPLE 12.2

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap12"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using prminwge_12_2.log, replace

*Importando dados
import excel "prminwge.xls", firstrow clear

*Sumário
summarize


*Regressão do Exemplo 10.9 
eststo ex12_2: reg lprepop lmincov lusgnp lprgnp t
display e(r2)

esttab ex12_2 using "tabelaprmingwge12_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 F, labels("Obs." "R²" "Estatística F"))
/*
		lprepop
lmincov	-0.212***
		(0.0402)
	
lusgnp	0.486**
		(0.222)
	
lprgnp	0.285***
		(0.0805)
	
t		-0.0267***
		(0.00463)
	
_cons	-6.663***
		(1.258)
Obs.	38
R²		0.889
Estat F	66.23
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
predict uhat, resid
tsset year
gen Luhat = L.uhat
reg uhat Luhat

eststo ex12_21: reg uhat lmincov lprgnp lusgnp t L.uhat
esttab ex12_21 using "tabelaprmingwge12_21.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R²"))

/*
			uhat
lmincov		0.0375
			(0.0352)
	
lprgnp		-0.0785
			(0.0705)
	
lusgnp		0.204
			(0.195)
	
t			-0.00347
			(0.00407)
	
L.uhat		0.481***
			(0.166)
	
_cons		-0.851
			(1.093)
Obs.		37
R²			0.242
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

a estatística t dessa regressão é  2.89, indica que o parametros
estimados da primeira regressão não são bons para inferência

o rho da ultima regressão é 0.417 e t = 2.63
*/

log close
