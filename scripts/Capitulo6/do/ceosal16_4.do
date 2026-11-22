** CAPITULO 6

***EXEMPLO 6.4

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\PIBIC\Stata\ExemplosWooldridge\Cap6"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using ex6_4.log, replace

*Importando dados
import excel "ceosal1.xls", firstrow clear

summarize

**6.4.1
*Regressão - eststo salva resultados
eststo ex6_41: reg salary sales roe

esttab ex6_41 using "tabela6_41.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
**6.4.2
*Regressão - eststo salva resultados
eststo ex6_42: reg lsalary lsales roe

esttab ex6_42 using "tabela6_42.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
** Somando o quadrado de salary e lasalary
sum salary
gen dev2 = (salary - r(mean))^2
egen TSS = total(dev2)
display TSS

sum lsalary
gen dev2log = (lsalary - r(mean))^2
egen TSSlog = total(dev2log)
display TSSlog
/*
		(1)
		salary
sales	0.0163*
		(0.00887)
	
roe		19.63*
		(11.08)
	
_cons	830.6***
		(223.9)
Obs.	209
R2		0.0292
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01


		(2)
		lsalary
lsales	0.275***
		(0.0333)
	
roe		0.0179***
		(0.00396)
	
_cons	4.362***
		(0.294)
Obs.	209
R2		0.282
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Pelo R^2 o modelo debaixo parece melhor, mas pela soma dos quadrados 
percebe-se que também há menos a ser explicado, para definir qual modelo
é melhor é necessário uma comparação válida de adequação do ajuste.

Soma dos quadrados: 
do salario = 391,732,982 (na notação americana isso 391 milhões e segue)
do log(salario) = 66.722176


*/
log close
