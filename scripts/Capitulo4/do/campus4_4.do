**** CHAPTER 4

** EXAMPLE 4.4

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap4"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using campus4_4.log, replace

*Importando dados
import excel "campus.xls", firstrow clear

*Sumário
summarize

*Regressão - eststo salva resultados
eststo ex4_4: reg lcrime lenroll


***** TABELA COM O RESULTADO  - SAlVA O ARQUIVO NO SEU DIRETORIO
esttab ex4_4 using "tab4_4.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

di (_b[lenroll]-1)/_se[lenroll]
/*
			lcrime
lenroll  	1.270***
	        (0.110)
	
_cons   	-6.631***
	       (1.034)

Obs.	   97
R2  	   0.585
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

teste H_0: beta1 = 1 e H_1 beta1 > 1

df = n - k - 1 = 97 - 1 - 1 = 95

valor crítico a 5% de um lado só c = 1.66
valor crítico a 1% de um lado só c = 2.37
estatística t = (1.270 - 1) / 0.110 = 2.45 (2.4573683 achado pelo stata) 
logo, rejeita que beta1 = 1 em favor de beta1 > 1, tanto em 5% como 1%
*/
log close
