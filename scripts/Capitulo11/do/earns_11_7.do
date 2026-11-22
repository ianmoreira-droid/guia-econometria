**** CHAPTER 11

** EXAMPLE 11.7

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap11"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using earns_11_7.log, replace

*Importando dados
import excel "earns.xls", firstrow clear

*Sumário
summarize
destring ghrwage goutphr ghrwge_1 goutph_1 goutph_2, replace
summarize

** Regressão - eststo salva resultados - No conjunto restrito de variáveis
eststo ex11_71: reg lhrwage loutphr t
display e(r2)

esttab ex11_71 using "earns11_71.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

*Calculando coeficiente de autocorrelação
reg lhrwage t
predict u_hrwage, resid

reg loutphr t
predict u_outphr, resid

tsset t

corr u_hrwage L.u_hrwage
corr u_outphr L.u_outphr
*L.u_lhrwage é a estimativa de pchapeu1, mesmo vale para L.u_outphr
/*
			lhrwage
loutphr		1.640***
			(0.0933)
	
t			-0.0182***
			(0.00175)
	
_cons		-5.328***
			(0.374)
Obs.		41
R2			0.971
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

p1chapeu[lhrwage] = 0.967
p1chapeu[loutphr] = 0.945
*/
* Regressão 2
eststo ex11_72: reg ghrwage goutphr 
display e(r2)

esttab ex11_72 using "earns11_72.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
			ghrwage
goutphr		0.809***
			(0.173)
	
_cons		-0.00366
			(0.00422)
Obs.		40
R2			0.364
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
log close
