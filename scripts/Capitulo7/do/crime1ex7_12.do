**** CHAPTER 7

** EXAMPLE 7.12

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap7"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using crime1_7.log, replace

*Importando dados
import excel "crime1.xls", firstrow clear

*Sumário
summarize

*Regressões 7.12 Modelo de Probabilidade Linear
eststo ex7_12: reg arr86 pcnv avgsen tottime ptime86 qemp86

esttab ex7_12 using "tab7_12.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
test avgsen tottime
/*
		arr86
pcnv		-0.162***
			(0.0212)
	
avgsen		0.00611
			(0.00645)
	
tottime		-0.00226
			(0.00498)
	
ptime86		-0.0220***
			(0.00463)
	
qemp86		-0.0428***
			(0.00540)
	
_cons		0.441***
			(0.0172)
Obs.		2725
R2			0.0474
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

O Beta0 = 0.441 singifica que probabilidade prevista de prisão 
para um indivíduo com todas as variáveis explicativas 
iguais a zero é 44,1%

Logicamente ptime86, mede o tempo na prisão em meses, quanto maior for
menor a chance de você ser preso(você já está lá), 6 meses a mais reduz
em 13,2 a chance de ser preso

Teste F em avgsen e tottime deu p-valor 0.3467, ou seja, conjuntamente
não são significativas

Ter um emprego reduz as chances de ser preso de forma significante
*/

log close
