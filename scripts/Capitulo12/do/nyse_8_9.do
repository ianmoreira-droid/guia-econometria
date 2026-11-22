**** CHAPTER 12

** EXAMPLE 12.8 e 9 

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap12"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using nyse_12_8_9.log, replace

*Importando dados
import excel "nyse.xls", firstrow clear

*Sumário
summarize
destring return_1 return price_1 price_2 cprice cprice_1, replace
summarize

** Regressão - eststo salva resultados - No conjunto restrito de variáveis
eststo ex12_8: reg return return_1
display e(r2)

esttab ex12_8 using "nyse12_8.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

di _b[return_1]/_se[return_1]
predict uhat, resid
gen uhat2 = uhat^2

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

t = 1.5490182
*/
* Regressão 2
eststo ex12_81: reg uhat2 return_1
display e(r2)

esttab ex12_81 using "nyse12_81.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

di _b[return_1]/_se[return_1]

/*
			uhat2
return_1	-1.104***
			(0.201)
	
_cons		4.657***
			(0.428)
Obs.		689
R2			0.0419
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01
t = -5.482206, há evidencia forte de heterocedasticidade

*/
*Exemplo 9
tsset t
gen luhat2 = L.uhat2
gen luhat = L.uhat
eststo ex12_9: reg uhat2 luhat2

esttab ex12_9 using "nyse12_9.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

di _b[luhat2]/_se[luhat2]
/*
			uhat2
luhat2		0.337***
			(0.0359)
	
_cons		2.947***
			(0.440)
Obs.		688
R2			0.114
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

t = 9.3767009
*/
reg uhat luhat
di _b[luhat]/_se[luhat]
/*
Coef(rho) =  .0014048
t = .03679676
*/
log close
