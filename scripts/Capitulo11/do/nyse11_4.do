**** CHAPTER 11

** EXAMPLE 11.4

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap11"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using nyse_11_4.log, replace

*Importando dados
import excel "nyse.xls", firstrow clear

*Sumário
summarize
destring return_1 return price_1 price_2 cprice cprice_1, replace
summarize

** Regressão - eststo salva resultados - No conjunto restrito de variáveis
eststo ex11_4: reg return return_1
display e(r2)

esttab ex11_4 using "nyse11_4.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))



/*
			return
return_1	0.0589
			(0.0380)
	
_cons		0.180**
			(0.0807)
Obs.		689
R2			0.00348
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01
Beta1 = 0 não pode ser rejeitada nem a 10%, apesar de não ser forte
não da garantia de rejeição da hipótese de mercados eficientes 

*/



log close
