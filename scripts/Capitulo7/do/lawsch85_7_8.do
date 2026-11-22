**** CHAPTER 7

** EXAMPLE 7.8

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap7"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using lawsch85_7.log, replace

*Importando dados
import excel "lawsch85.xls", firstrow clear

*Sumário
destring lsalary llibvol lcost LSAT GPA, replace
summarize

*Regressões 7.8
eststo ex7_8: reg lsalary top10 r11_25 r26_40 r41_60 r61_100 LSAT GPA llibvol lcost    

esttab ex7_8 using "tab7_8.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

*Efeito de ser top 10
display 100*(exp(_b[top10])-1)
/*
		lsalary
top10	0.700***
		(0.0535)
	
r11_25	0.594***
		(0.0394)
	
r26_40	0.375***
		(0.0341)
	
r41_60	0.263***
		(0.0280)
	
r61_100	0.132***
		(0.0210)
	
LSAT	0.00569*
		(0.00306)
	
GPA		0.0137
		(0.0742)
	
llibvol	0.0364
		(0.0260)
	
lcost	0.000842
		(0.0251)
	
_cons	9.165***
		(0.411)
Obs.	136
R2		0.911
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

pelo efeito estimado, estudar numa faculdade de direito dentro do top10
te leva a ganhar o dobro do salário de quem estuda em uma fora do top100
*/

log close
