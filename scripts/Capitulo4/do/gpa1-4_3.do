**** CHAPTER 4

** EXAMPLE 4.3

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap4"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using gpa14_3.log, replace

*Importando dados
import excel "gpa1.xls", firstrow clear

*Sumário
summarize

*Regressão - eststo salva resultados
eststo ex4_3: reg colGPA hsGPA ACT skipped

esttab ex4_3 using "tab4_3.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

* Estatísticas t
di _b[hsGPA]/_se[hsGPA]
di _b[skipped]/_se[skipped]
di _b[ACT]/_se[ACT]
/*
	colGPA
hsGPA	    0.412***
	       (0.0937)
	 
ACT	        0.0147
	       (0.0106)
	
skipped	  -0.0831***
	       (0.0260)
	
_cons	   1.390***
	      (0.332)

Obs.	141
R2   	0.234
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

** Teste t

/* 
estatítica t para skipped
t = -0.0831/ 0.0260
|t| = 3.19
valor crítico c a 1% e 137 graus de liberdade
c = 2.58
logo, rejeita H_0 a 1%

Segue a mesma lógica para os outros
t(hsGPA) = 4.3962592
t(ACT) = 1.3933188
*/
log close
