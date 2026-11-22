**** CHAPTER 2

** EXAMPLE 2.4, 2.7 e 2.10

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap2"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using wage1_Cap2.log, replace

*Importando dados
import excel "wage1.xls", firstrow clear

*Sumário
summarize

*Regressão 2.4
eststo ex2_4: reg wage educ 

esttab ex2_4 using "tab2_4.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
twoway (scatter wage educ, mcolor(darkgreen)) ///
       (lfit wage educ, lcolor(red)), ///
    title(Salario vs Anos de Educacao) ///
    xtitle(Educacao (anos)) ///
    ytitle(Salario)

graph export "wage1-1.png", replace
/*
		wage
educ	0.541***
		(0.0532)
	
_cons	-0.905
		(0.685)
Obs.	526
R2		0.165
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
* 2.7
summarize educ
local media = r(mean)
display _b[_cons] + _b[educ]*`media'

*Regressão 2.10
eststo ex2_10: reg lwage educ

esttab ex2_10 using "tab2_10.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
	lwage
educ	0.0827***
	(0.00757)
	
_cons	0.584***
	(0.0973)
Obs.	526
R2	0.186
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01


*/
twoway (scatter lwage educ, mcolor(darkgreen)) ///
       (lfit lwage educ, lcolor(red)), ///
    title(Salario vs Anos de educacao) ///
    xtitle(Educacao (anos)) ///
    ytitle(Logsalario)

graph export "wage1-2.png", replace


log close
