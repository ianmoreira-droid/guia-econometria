**** CHAPTER 9

** EXAMPLE 9.4

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap9"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using crime2_9_4.log, replace

*Importando dados
import excel "crime2.xls", firstrow clear

destring _all, replace force

*Sumário
summarize

*** Exemplo 9.4

*Regressão 1
eststo ex9_41: reg lcrmrte unem llawexpc if d87 == 1

esttab ex9_41 using "tab9_4_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
			lcrmrte
unem		-0.0290
			(0.0323)
	
llawexpc	0.203
			(0.173)
	
_cons		3.343**
			(1.251)
Obs.		46
R2			0.0571
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

*Regressão 2
eststo ex9_42: reg lcrmrte unem llawexpc lcrmrt_1 if year == 87

esttab ex9_42 using "tab9_4_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))


/*
			lcrmrte
unem		0.00862
			(0.0195)
	
llawexpc	-0.140
			(0.109)
	
lcrmrt_1	1.194***
			(0.132)
	
_cons		0.0765
			(0.821)
Obs.		46
R2			0.680
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Incluir o crime em 82 aumenta bastante o tanto que é explicado
permitindo obtenção de uma estimativa mais adequada do efeito
ceteris paribus dos gastos com segurança sobre crime
*/	


log close
