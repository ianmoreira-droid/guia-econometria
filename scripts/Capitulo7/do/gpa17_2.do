**** CHAPTER 7

** EXAMPLE 7.2

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap7"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using gpa1_7.log, replace

*Importando dados
import excel "gpa1.xls", firstrow clear

*Sumário
summarize

*Regressões 7.2
eststo ex7_2: reg colGPA PC hsGPA ACT

esttab ex7_2 using "tab7_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*

		colGPA
PC		0.157***
		(0.0573)
	
hsGPA	0.447***
		(0.0936)
	
ACT		0.00866
		(0.0105)
	
_cons	1.264***
		(0.333)
Obs.	141
R2		0.219
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
* teste individual em PC
display _b[PC]/_se[PC] 
/* 
t_PC=~2.75

se regredir colGPA em PC, o betaPC = .170
e sePC = .063, t_PC2 = 2.6984127, não muda muito da
primeira regressão
*/
display .170/.063
log close
