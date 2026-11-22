**** CHAPTER 4

** EXAMPLE 4.2 

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap4"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using meap93_4_2.log, replace

*Importando dados
import excel "meap93.xls", firstrow clear

*Sumário
summarize

*Regressão 1 - eststo salva resultados
eststo ex4_2: reg math10 totcomp staff enroll

esttab ex4_2 using "tab4_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

display e(r2)
/*
			math10
totcomp   0.000459***
	     (0.000100)
	 
staff	  0.0479
	     (0.0398)
	
enroll 	 -0.000198
	     (0.000215)
	
_cons	  2.274
	     (6.114)

Obs.	408
R2	    0.0541
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

df = n - k - 1 = 408 - 3 - 1 = 404

valor critico c a 5% e 404 df
c = -1.65
estatística t para enroll
t = -0.00020/0.00022  = -0.91
-0.91 > -1.65
logo, não rejeita H_0 a 5%, pois nesse caso, é um teste de 1 cauda do lado esquerdo,
ou seja, t < -c, então o enroll não é estatísticamente significante a 5%
já que estamos testando se ele é menor do que zero
*/

*Regressão 2 - eststo salva resultados
eststo ex4_2: reg math10 ltotcomp lstaff lenroll

esttab ex4_2 using "tab4_2_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
			math10
ltotcomp	21.15***
	       (4.056)
	
lstaff	    3.980
	       (4.190)
	
lenroll	   -1.268*
	       (0.693)
	
_cons	   -207.7***
	       (48.70)

Obs.	408
R2	    0.0654
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

df = n - k - 1 = 408 - 3 - 1 = 404

valor critico c a 5% e 404 df
c = -1.65
estatística t para lenroll
t = -1.268/ 0.693 = -1.828
-1.828 < -1.65
logo, rejeita H_0 a 5%


*/

log close
