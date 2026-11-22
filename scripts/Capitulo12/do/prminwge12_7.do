**** CHAPTER 12

** EXAMPLE 12.7

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap12"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using prminwge_12_7.log, replace

*Importando dados
import excel "prminwge.xls", firstrow clear

*Sumário
summarize


*Regressão do Exemplo 12.2 
* Passo 1 do procedimento para calcular o eta chapeu 
eststo ex12_7: reg lprepop lmincov lusgnp lprgnp t
display e(r2)

esttab ex12_7 using "tabelaprmingwge12_7.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 F, labels("Obs." "R²" "Estatística F"))

predict uhat, resid
scalar sigma  = e(rmse)
scalar se1    = _se[lmincov]

* Passo 2 regredir a variável de interesse nas demais controles e guardar reísduos
quietly reg lmincov lusgnp lprgnp t
predict rhat1, resid

* Passo 3: a_t = rhat1_t * uhat_t
gen a = rhat1 * uhat

* Passo 4: soma de a_t^2 + termos de autocovariância ponderados (g = 2)
local g = 2
gen a2 = a^2
quietly summarize a2
scalar nhat = r(sum)

sort t   // garanta que os dados estão ordenados pela variável de tempo

local g = 2
forvalues h = 1/`g' {
    quietly gen double a_lag`h' = a[_n-`h']
    quietly gen double prod`h'  = a * a_lag`h'
    quietly summarize prod`h'
    scalar w`h'  = 1 - `h'/(`g'+1)
    scalar nhat  = nhat + 2*w`h'*r(sum)
}
* Passo 5: erro-padrão robusto à correlação serial
scalar se_robust = (se1/sigma)^2 * sqrt(nhat)

di "n_hat = "      nhat
di "SE robusto = " se_robust
di -0.212/0.04260487
/*
		lprepop
lmincov	-0.212***
		(0.0402)
	
lusgnp	0.486**
		(0.222)
	
lprgnp	0.285***
		(0.0805)
	
t		-0.0267***
		(0.00463)
	
_cons	-6.663***
		(1.258)
Obs.	38
R²		0.889
Estat F	66.23
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

erro padrão da regressão =  .03277 
n_hat = .00080491
SE robusto = .04260487
t robust = -4.975957
*/

*PW(FGLS)
tsset year
eststo ex12_71: prais lprepop lmincov lusgnp lprgnp year

esttab ex12_71 using "tabelaprmingwge12_71.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 F, labels("Obs." "R²" "Estatística F"))
/*
			lprepop
lmincov			-0.148***
				(0.0458)
	
lusgnp			0.256
				(0.232)
	
lprgnp			0.251**
				(0.116)
	
year			-0.0205***
				(0.00586)
	
_cons			35.30***
				(10.22)
Obs.			38
R²				0.751
Estatística F	24.87
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01
*/

log close
