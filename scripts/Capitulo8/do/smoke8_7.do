**** CHAPTER 8

** EXAMPLE 8.7

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap8"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using smoke8_7.log, replace

*Importando dados
import excel "smoke.xls", firstrow clear

*Sumário
summarize

*Regressão 1
eststo ex8_7: reg cigs lincome lcigpric educ age agesq restaurn

esttab ex8_7 using "tab8_7.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
*Teste Breusch-Pagan
estat hettest

/*
			cigs
lincome		0.880
			(0.728)
	
lcigpric	-0.751
			(5.773)
	
educ		-0.501***
			(0.167)
	
age			0.771***
			(0.160)
	
agesq		-0.00902***
			(0.00174)
	
restaurn	-2.825**
			(1.112)
	
_cons		-3.640
			(24.08)
Obs.		807
R2			0.0527
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Teste Breush-Pagan
LM deu alto, e p-valor baixo indicando forte evidência
heterocedasticidade
A diferença do LM do Wooldridge, é que o comando 
estat hettest calcula de forma levemente diferente,
mas há equivalência assintótica e o resultado é mesmo
*/

predict uhat, resid
gen uhat2 = uhat^2
gen luhat2 = ln(uhat2)
reg luhat2 lincome lcigpric educ age agesq restaurn
*é o valor estimado da função que modela o logaritmo da variância do erro.
* ghat = ln(sigma^2)
predict ghat
gen w = exp(-ghat)
*Regressão 2(MQGF)
eststo ex8_71: reg cigs lincome lcigpric educ age agesq restaurn [aw=w]

esttab ex8_71 using "tab8_71.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
			cigs
lincome		1.295***
			(0.437)
	
lcigpric	-2.940
			(4.460)
	
educ		-0.463***
			(0.120)
	
age			0.482***
			(0.0968)
	
agesq		-0.00563***
			(0.000939)
	
restaurn	-3.461***
			(0.796)
	
_cons		5.635
			(17.80)
Obs.		807
R2			0.113
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

A vantagem do MQGF é pesar a observação pelo inverso
da variância, eliminando heterocedasticidade
Com os resultados estimados, é possível ver maior
significancia estatistica pelo MQGF
*/

log close
