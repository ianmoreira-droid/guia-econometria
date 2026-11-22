**** CHAPTER 4

** EXAMPLE 4.10

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap4"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear
ado dir esttab

log using meap93_4_10.log, replace

*Importando dados
import excel "meap93.xls", firstrow clear

*Sumário
summarize
eststo m1: reg lsalary b_s 

esttab m1 using "tabela4_10_1.rtf", replace ///
	se star(* 0.10 ** 0.05 *** 0.01) ///
	stats(N r2, labels("Obs." "R2"))
/*
		lsalary
b_s		-0.825***
		(0.200)
	
_cons	10.52***
		(0.0416)
Obs.	408
R2		0.0403
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01


*/

*Regressão - eststo salva resultados
eststo ex4_102: reg lsalary b_s lenroll lstaff droprate gradrate

esttab ex4_102 using "tabela4_10_2.rtf", replace ///
	se star(* 0.10 ** 0.05 *** 0.01) ///
	stats(N r2, labels("Obs." "R2"))

/*
		lsalary
b_s			-0.589***
			(0.165)
	
lenroll		0.0881***
			(0.00732)
	
lstaff		-0.218***
			(0.0500)
	
droprate	-0.000283
			(0.00161)
	
gradrate	0.000967
			(0.000663)
	
_cons		10.74***
			(0.258)
Obs.		408
R2			0.361
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
eststo ex4_103: reg lsalary b_s lenroll lstaff 

esttab ex4_103 using "tabela4_10_3.rtf", replace ///
	se star(* 0.10 ** 0.05 *** 0.01) ///
	stats(N r2, labels("Obs." "R2"))
/*
		lsalary
b_s		-0.605***
		(0.165)
		
lenroll	0.0874***
		(0.00735)
	
lstaff	-0.222***
		(0.0501)
	
_cons	10.84***
		(0.252)
Obs.	408
R2		0.353
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01


*/
** Teste t

/* 
H_0: beta1 = -1 
estatítica t para b/s na primeira regressão
t = (-0.825 + 1)/0.200 = 0.875 com isso falha em rejeitar H_0

t para a ultima regressão
t = 2.39 rejeita a 5%
*/
log close
