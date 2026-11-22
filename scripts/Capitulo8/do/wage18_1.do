**** CHAPTER 8

** EXAMPLE 8.1

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap8"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using wage1_8_1.log, replace

*Importando dados
import excel "wage1.xls", firstrow clear

*Sumário
summarize

*Exemplo 8.1

* Homem casado
gen marrmale = (married==1 & female==0)

* Mulher casada
gen marrfem = (married==1 & female==1)

* Mulher solteira
gen singfem = (married==0 & female==1)

*Regressão 7.6
eststo ex8_1: reg lwage marrmale marrfem singfem educ exper expersq tenure tenursq

esttab ex8_1 using "tab8_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
			lwage
marrmale	0.213***
			(0.0554)
			[.0571]
	
marrfem		-0.198***
			(0.0578)
			[.0587]
	
singfem		-0.110**
			(0.0557)
			[.0571163]
	
educ		0.0789***
			(0.00669)
			[.0074147]
	
exper		0.0268***
			(0.00524)
			[.0051391]
	
expersq		-0.000535***
			(0.000110)
			[.0001063]
	
tenure		0.0291***
			(0.00676)
			[.0069409]
	
tenursq		-0.000533**
			(0.000231)
			[.0002437]
			
_cons		0.321***
			(0.100)
			[.109469]
Obs.		526
R2			0.461
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Quem é estatisticamente significante com t usual segue
significante com t robusto[Nesse caso, não tem decisão importante alterada]
Erros padrões robustos podem ser maiores ou menores que os usuais
*/

*Regressão Com Erro padrão robusto
reg lwage marrmale marrfem singfem educ exper expersq tenure tenursq, vce(robust)

foreach v in marrmale marrfem singfem educ exper expersq tenure tenursq {
    di "`v'  t = " _b[`v']/_se[`v']
}
log close
