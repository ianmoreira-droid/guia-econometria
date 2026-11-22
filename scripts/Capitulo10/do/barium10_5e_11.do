**** CHAPTER 10

** EXAMPLE 10.5 e 10.11

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap10"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using barium_10_5.log, replace

*Importando dados
import excel "barium.xls", firstrow clear

*Sumário
summarize

** Regressão - eststo salva resultados - No conjunto restrito de variáveis
eststo ex10_5: reg lchnimp lchempi lgas lrtwex befile6 affile6 afdec6
display e(r2)

esttab ex10_5 using "barium10_5.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

display 100*[exp(_b[afdec6])-1]
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

o afdec6 mostra uma queda na importação de Bario da China
após uma decisão favoravel a industria americana
o efeito é de 100[exp(-0.565)-1] =~ -43.2
*/

*Exemplo 10.11

*Regressão com dummies dos meses
eststo ex10_11: reg lchnimp befile6 affile6 afdec6 ///
    feb mar apr may jun jul aug sep oct nov dec
display e(r2)

esttab ex10_11 using "barium10_11.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

*Testar a significancia conjunta
testparm feb-dec

/*
	(1)
	lchnimp
befile6	0.182
	(0.307)
	
affile6	0.248
	(0.308)
	
afdec6	-0.0684
	(0.308)
	
feb	-0.316
	(0.313)
	
mar	0.0433
	(0.313)
	
apr	-0.442
	(0.314)
	
may	0.0261
	(0.317)
	
jun	-0.193
	(0.317)
	
jul	-0.000985
	(0.317)
	
aug	-0.129
	(0.317)
	
sep	-0.0271
	(0.317)
	
oct	0.142
	(0.316)
	
nov	-0.217
	(0.313)
	
dec	0.114
	(0.313)
	
_cons	6.242***
	(0.231)
Obs.	131
R2	0.0658
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01
Não só o R^2 deu muito baixo como as dummies não tem significancia estatistica
*/
log close
