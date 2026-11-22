** CAPITULO 6

***EXEMPLO 6.3

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\PIBIC\Stata\ExemplosWooldridge\Cap6"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using ex6_3.log, replace

*Importando dados
import excel "attend.xls", firstrow clear

summarize

*Regressão - eststo salva resultados
eststo ex6_3: reg stndfnl atndrte priGPA ACT c.priGPA#c.priGPA ///
    c.ACT#c.ACT c.priGPA#c.atndrte

esttab ex6_3 using "tabela6_3.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
	(1)
			stndfnl
atndrte				-0.00671
					(0.0102)
	
priGPA				-1.629***
					(0.481)
	
ACT					-0.128
					(0.0985)
	
c.priGPA#c.priGPA	0.296***
					(0.101)
	
c.ACT#c.ACT			0.00453**
					(0.00218)
	
c.priGPA#c.atndrte	0.00559
					(0.00432)
	
_cons				2.050
					(1.360)
Obs.				680
R2					0.229
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

efeito parcial de atndrte(%de presença) em stndfnl[(Notaf-media)/sd]:
-0.00671 + 0.00559.priGPA
para obter algum valor é necessário fixar priGPA(nota cumulativa anterior)
exemplo: priGPA = 2.59
efeito ~= 0.0078, ou seja, um aumento de 10 na taxa de presença aumenta
stndfnl em 0.078 (a nota vai distar 0.078*sd da média)
sd = desvio-padrão	
*/

log close
