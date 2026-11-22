**** CHAPTER 10

** EXAMPLE 10.4 e 10.8

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap10"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using fertil_10_4_8.log, replace

*Importando dados
import excel "fertil3.xls", firstrow clear

*Sumário
destring pe_1 pe_2, replace
summarize

** Regressão 1
eststo ex10_41: reg gfr pe ww2 pill
display e(r2)

esttab ex10_41 using "fertil3-10_41.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

	
/*
			(1)
			gfr
pe			0.0825***
			(0.0296)
	
ww2			-24.24***
			(7.458)
	
pill		-31.59***
			(4.081)
	
_cons		98.68***
			(3.208)
Obs.		72
R2			0.473
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01


*/

** Regressão 2
eststo ex10_42: reg gfr pe pe_1 pe_2 ww2 pill
display e(r2)

esttab ex10_42 using "fertil3-10_42.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
* Propensão de longo prazo
lincom pe + pe_1 + pe_2
/*
			(1)
			gfr
pe			0.0727
			(0.126)
	
pe_1		-0.00578
			(0.156)
	
pe_2		0.0338
			(0.126)
	
ww2			-22.13**
			(10.73)
	
pill		-31.30***
			(3.982)
	
_cons		95.87***
			(3.282)
Obs.		70
R2			0.499
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

agora é necessário estimar a propensão de longo prazo somando
os coeficientes de pe + pe_1 + pe_2 =~ 0.101
sendo ele significante a um intervalo de confiança(95%):
[.041 ; .160]
*/

* Exemplo 10.8
*Regressão 1
eststo ex10_81: reg gfr pe ww2 pill t
display e(r2)

esttab ex10_81 using "fertil3-10_81.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
/*
		gfr
pe		0.279***
		(0.0400)
	
ww2		-35.59***
		(6.297)
	
pill	0.997
		(6.262)
	
t		-1.150***
		(0.188)
	
_cons	111.8***
		(3.358)
Obs.	72
R2		0.662
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/	
*Regressão 2
eststo ex10_82: reg gfr pe ww2 pill t tsq
display e(r2)

esttab ex10_82 using "fertil3-10_82.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
		gfr
pe		0.348***
		(0.0403)
	
ww2		-35.88***
		(5.708)
		
pill	-10.12
		(6.336)
	
t		-2.531***
		(0.389)
	
tsq		0.0196***
		(0.00497)
	
_cons	124.1***
		(4.361)
Obs.	72
R2		0.727
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
log close
