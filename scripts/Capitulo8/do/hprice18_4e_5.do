**** CHAPTER 8

** EXAMPLE 8.4 e 8.5

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap8"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using hprice1_8_4e5.log, replace

*Importando dados
import excel "hprice1.xls", firstrow clear

*Sumário
summarize

*** Exemplo 8.4

*Regressão 1
eststo ex8_4: reg price lotsize sqrft bdrms

esttab ex8_4 using "tab8_4.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

predict uhat, resid
gen uhat2 = uhat^2
* Regressão auxiliar teste LM
reg uhat2 lotsize sqrft bdrms
display e(r2)
* Estatística F
display e(F)
* LM e seu p-valor
display e(N)*e(r2)
display chi2tail(3, e(N)*e(r2))
/*
		price
lotsize	0.00207***
		(0.000642)
	
sqrft	0.123***
		(0.0132)
	
bdrms	13.85
		(9.010)
	
_cons	-21.77
		(29.48)
Obs.	88
R2		0.672
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

R2(uhat2) = .16014076
F = 5.3389198
LM = 14.092386
p-valor(LM)= .00278206
*/

*Regressão 2
eststo ex8_42: reg lprice llotsize lsqrft bdrms

esttab ex8_42 using "tab8_42.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

predict uhat_1, resid
gen uhat2_1 = uhat_1^2
reg uhat2_1 llotsize lsqrft bdrms
display e(r2)
* Estatística F
display e(F)
* LM e seu p-valor
display e(N)*e(r2)
display chi2tail(3, e(N)*e(r2))
/*
			lprice
llotsize	0.168***
			(0.0383)
	
lsqrft		0.700***
			(0.0929)
	
bdrms		0.0370
			(0.0275)
	
_cons		-1.297**
			(0.651)
Obs.		88
R2			0.643
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

R2(uhat2_1) = .04799136
F =  1.4114978
LM = 4.2232396
p-valor(LM)= .23834543
Com isso, nota-se uma heterocedasticidade menor com variáveis
em log
*/	

*** Exemplo 8.5
*Regressão 
eststo ex8_5: reg lprice llotsize lsqrft bdrms

esttab ex8_5 using "tab8_5.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
predict lpricehat, xb
*_5 indica que é do exemplo 8.5
predict uhat_5, resid
gen uhat2_5 = uhat_5^2
gen lpricehat2 = lpricehat^2
* Regressão auxiliar
reg uhat2_5 lpricehat lpricehat2
* LM e p-valor
display e(N)*e(r2)
display chi2tail(2, e(N)*e(r2))
/*
			lprice
llotsize	0.168***
			(0.0383)
	
lsqrft		0.700***
			(0.0929)
	
bdrms		0.0370
			(0.0275)
	
_cons		-1.297**
			(0.651)
Obs.		88
R2			0.643
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

R2(uhat2_5)= 0.0392
LM = 3.4472201
p-valor = .17842088
Rejeita hipótese de Homocedasticidade, apesar
de ter mais evidência que o teste Breusch-Pagan
*/
log close
