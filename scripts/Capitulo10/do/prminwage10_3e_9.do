**** CHAPTER 10

** EXAMPLE 10.3 e 10.9

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap10"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using prminwge_10_3.log, replace

*Importando dados
import excel "prminwge.xls", firstrow clear

*Sumário
summarize

** Regressão - eststo salva resultados - No conjunto restrito de variáveis
eststo ex10_3: reg lprepop lmincov lusgnp
display e(r2)

esttab ex10_3 using "tabelaprmingwge10_3.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 F, labels("Obs." "R²" "Estatística F"))

	
/*
			(1)
			lprepop
lmincov		-0.154**
			(0.0649)
	
lusgnp		-0.0122
			(0.0885)
	
_cons		-1.054
			(0.765)
Obs.			38
R²				0.660
Estatística F	34.04
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

*Exemplo 10.9
*Regressão 
eststo ex10_9: reg lprepop lmincov lusgnp t
display e(r2)

esttab ex10_9 using "tabelaprmingwge10_9.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 F, labels("Obs." "R²" "Estatística F"))

/*
		lprepop
lmincov	-0.169***
		(0.0442)
	
lusgnp	1.057***
		(0.177)
	
t		-0.0324***
		(0.00502)
	
_cons	-8.696***
		(1.296)
Obs.	38
R²		0.847
Estatística F	62.78
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

incluir a tendencia alteoru o beta de lusgnp para positivo
e estatísticamente significante
*/
log close
