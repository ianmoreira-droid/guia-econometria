**** CHAPTER 3

** EXAMPLE 3.3

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap3"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using k401cap3.log, replace

*Importando dados
import excel "401k.xls", firstrow clear


*Sumário
summarize

*Regressão - eststo salva resultados
eststo ex3_3: reg prate mrate age


***** TABELA COM O RESULTADO  - SAlVA O ARQUIVO NO SEU DIRETORIO
esttab ex3_3 using "tab401k.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*	
		prate
mrate	5.521***
     	(0.526)
	
age	   0.243***
	    (0.0447)
	
_cons	80.12***
	   (0.779)
Obs.	1534
R2		0.0922
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01
*/
eststo ex3_31: reg prate mrate 
esttab ex3_31 using "tab401k1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
		prate
mrate	5.861***
		(0.527)
	
_cons	83.08***
		(0.563)
Obs.	1534
R2		0.0747
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

corr mrate age = 0.1188
*/
corr mrate age


log close
