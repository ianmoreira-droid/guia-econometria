**** CHAPTER 7

** EXAMPLE 7.11

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap7"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using mlb1_71.log, replace

*Importando dados
import excel "mlb1.xls", firstrow clear

*Sumário
destring percblck perchisp, replace
summarize

*Regressões 7.11
eststo ex7_11: reg lsalary years gamesyr bavg hrunsyr rbisyr runsyr fldperc allstar black hispan c.black#c.percblck c.hispan#c.perchisp

esttab ex7_11 using "tab7_11-1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
*Teste de significância conjunta
test black hispan c.black#c.percblck c.hispan#c.perchisp
/*
				lsalary
years			0.0673***
				(0.0129)
	
gamesyr			0.00888***
				(0.00338)
	
bavg			0.000945
				(0.00151)
	
hrunsyr			0.0146
				(0.0165)
	
rbisyr			0.00449
				(0.00757)
	
runsyr			0.00720
				(0.00457)
	
fldperc			0.00109
				(0.00212)
	
allstar			0.00753***
				(0.00287)
	
black			-0.198
				(0.125)
	
hispan			-0.190
				(0.153)
	
c.black#c.percblck	0.0125**
					(0.00496)
	
c.hispan#c.perchisp	0.0201**
					(0.00979)
	
_cons			10.34***
				(2.183)
Obs.			330
R2				0.638
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Quanto ao teste de significancia conjunta, passa em 5%, mas não em 1%

com os efeitos estimados, o efeito de ser negro aumenta de -0,198
conforme a porcentagem de nergros aumenta em cada cidade, sendo menor
a desvantagem comparado com brancos

para hispanicos de forma similar, se a porcentagem da população na 
cidade for maior que 9,45% eles ganham mais que brancos
*/

log close
