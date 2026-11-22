**** CHAPTER 8

** EXAMPLE 8.9

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap8"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using gpa1_8_9.log, replace

*Importando dados
import excel "gpa1.xls", firstrow clear

*Sumário
summarize

*Regressões 8.9
eststo ex8_9: reg PC hsGPA ACT parcoll

esttab ex8_9 using "tab8_9.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

reg PC hsGPA ACT parcoll
reg PC hsGPA ACT parcoll, vce(robust)

foreach v in hsGPA ACT parcoll {
    di "`v'  se = " _se[`v']
}
/*
			PC
hsGPA		0.0654
			(0.137)
			[.1414868]
	
ACT			0.000565
			(0.0155)
			[.0160709]
	
parcoll		0.221**
			(0.0930)
		   [.08803776]
	
_cons		-0.000432
			(0.491)
			[.4958802]
Obs.		141
R2			0.0415
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Os erros padrões robustos são levemente diferentes 
pois o Stata aplica uma correção, se dividir o que encontramos
com o resultado do livro, veremos a constante de correção, pode usar 
qualquer erro padrão para fazer o teste
*/

quietly reg PC hsGPA ACT parcoll
*Armazenar para o MQGF
predict phat            // fitted values (não resíduos!)
gen hhat = phat*(1-phat)
gen w = 1/hhat

*MQGF
eststo ex8_91: reg PC hsGPA ACT parcoll [aw=w]

esttab ex8_91 using "tab8_91.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
/*
			PC
hsGPA		0.0327
			(0.130)
	
ACT			0.00427
			(0.0155)
	
parcoll		0.215**
			(0.0863)
	
_cons		0.0262
			(0.477)
Obs.		141
R2			0.0464
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
log close
