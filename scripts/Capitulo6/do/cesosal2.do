** CAPITULO 6

***EXEMPLO 6.7 e 6.8

clear all
set more off

capture log close 

cd "C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap6"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using ex6_78.log, replace

*Importando dados
import excel "ceosal2.xls", firstrow clear

summarize

**6.7
*Regressão - eststo salva resultados
eststo ex6_7: reg lsalary lsales lmktval ceoten

esttab ex6_7 using "tabela6_7.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	

display 4.504 + .163*ln(5000) + .109*ln(10000) + .0117*10
display exp(7.013)

predict u_chap, resid
gen smear = exp(u_chap)
summ smear

scalar s = r(mean)

display exp(7.013)*s
/*
		(1)
		lsalary
lsales	0.163***
		(0.0392)
	
lmktval	0.109**
		(0.0496)
	
ceoten	0.0117**
		(0.00533)
	
_cons	4.504***
		(0.257)
Obs.	177
R2		0.318
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

tem o valor predito [4.504 + .163*ln(5000) + .109*ln(10000) + .0117*10]
mas quer se estimar o y não o log(y) ou seja queremos o salário
pelo valor predito, salário = 1110.983

Pelo estimador smearing de Duan, o termo alfa0 =~ 1.136
o valor predito seria exp(7.013)*s = 1261.6998
esse estimador serve para corrigir o viés de predição quando a variável
dependente está em log
	
*/

**6.8
*Regressão - eststo salva resultados
eststo ex6_8: reg salary sales mktval ceoten

esttab ex6_8 using "tabela6_8.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

eststo ex6_81: reg lsalary sales mktval ceoten

predict lsalary_hat, xb
predict se_salary, stdf

gen lower_log = lsalary_hat - invttail(e(df_r),0.025)*se_salary
gen upper_log = lsalary_hat + invttail(e(df_r),0.025)*se_salary

gen lower_y = exp(lower_log)
gen upper_y = exp(upper_log)
display lower_log
display upper_log

display lower_y
display upper_y
/*
	(1)
		salary
sales	0.0190*
		(0.0101)
	
mktval	0.0234**
		(0.00948)
	
ceoten	12.70**
		(5.618)
	
_cons	613.4***
		(65.24)
Obs.	177
R2		0.201
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01
t(0.025)= 1.96
se(ê) = 
Aqui queremos um intervalo de predição para 95%(em nível)
valor sup = log(sal)_chapeu + 1.96*se(ê) = 3264.2212
valor inf = log(sal)_chapeu - 1.96*se(ê) = 337.98624
há uma diferença do valor desse código pro valor do Wooldridge pelo 
exemplo numérico que ele usa

*/
log close
