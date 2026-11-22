**** CHAPTER 9

** EXAMPLE 9.1

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap9"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using crime19_1.log, replace

*Importando dados
import excel "crime1.xls", firstrow clear

*Sumário
summarize

** Regressão - eststo salva resultados
eststo ex9_11: reg narr86 pcnv avgsen tottime ptime86 qemp86 inc86 black hispan

esttab ex9_11 using "tab9_1_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
/*
		narr86
pcnv	-0.133***
		(0.0404)
	
avgsen	-0.0113
		(0.0122)
	
tottime	0.0120
		(0.00944)
	
ptime86	-0.0408***
		(0.00881)
	
qemp86	-0.0505***
		(0.0144)
	
inc86	-0.00149***
		(0.000341)
		
black	0.327***
		(0.0454)
	
hispan	0.194***
		(0.0397)
	
_cons	0.569***
		(0.0360)
Obs.	2725
R2		0.0723
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
	
eststo ex9_12: reg narr86 pcnv pcnvsq avgsen tottime ptime86 pt86sq qemp86 inc86 inc86sq black hispan

esttab ex9_12 using "tab9_1_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

* Teste conjunto da variáveis ao quadrado
test pcnvsq pt86sq inc86sq	
* Ponto onde o efeito muda de sinal
display -_b[pcnv]/(2*_b[pcnvsq])

display -_b[ptime86]/(2*_b[pt86sq])

display -_b[inc86]/(2*_b[inc86sq])
/*
		narr86
pcnv	0.553***
		(0.154)
	
pcnvsq	-0.730***
		(0.156)
	
avgsen	-0.0170
		(0.0121)
	
tottime	0.0120
		(0.00928)
	
ptime86	0.287***
		(0.0443)
	
pt86sq	-0.0296***
		(0.00386)
		
qemp86	-0.0141
		(0.0174)
	
inc86	-0.00342***
		(0.000804)
	
inc86sq	0.00000719***
		(0.00000256)
	
black	0.292***
		(0.0448)
	
hispan	0.164***
		(0.0395)
	
_cons	0.505***
		(0.0368)
Obs.	2725
R2		0.103
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Mudança do sinal do efeito
pcnv = .37833099
ptime86 = 4.8540553
inc86 = 237.63107
*/
log close
