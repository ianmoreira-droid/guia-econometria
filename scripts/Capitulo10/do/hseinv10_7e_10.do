**** CHAPTER 10

** EXAMPLE 10.7 e 10.10

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap10"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using hseinv_10_7.log, replace

*Importando dados
import excel "hseinv.xls", firstrow clear

*Sumário
summarize

** Regressão - eststo salva resultados - No conjunto restrito de variáveis
eststo ex10_71: reg linvpc lprice
display e(r2)

esttab ex10_71 using "hseinv10_71.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))


/*
		linvpc
lprice	1.241***
		(0.382)
	
_cons	-0.550***
		(0.0430)
Obs.	42
R2		0.208
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
*Segunda com tendencia
eststo ex10_72: reg linvpc lprice t
display e(r2)

esttab ex10_72 using "hseinv10_72.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
		linvpc
lprice	-0.381
		(0.679)
		
t		0.00983***
		(0.00351)
	
_cons	-0.913***
		(0.136)
Obs.	42
R2		0.341
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Incluir a tendencia mostrou que o efeito positivo o log preço 
tinha parte do efeito da tendencia
é possível ver que na segunda regressão o beta lprice
não é estatisticamente relevante
*/
*Exemplo 10.10

/*
Ter um R^2 alto pode ser enganoso quando se 
trata de tendência uma forma seria retirar a tendência
regredindo cada variável só em t e depois regredindo 
um resíduo no outro 
*/

*Tirando tendência
reg linvpc t
predict linvpc_dt, resid

reg lprice t
predict lprice_dt, resid

*Regressão final
eststo ex10_10: reg linvpc_dt lprice_dt

esttab ex10_10 using "hseinv10_10.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
			linvpc_dt
lprice_dt	-0.381
			(0.670)
	
_cons		-1.60e-10
			(0.0219)
Obs.		42
R2			0.00801
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Como é possível ver o R^2 reduz muito, além
da perda de significância estatística dos coeficientes

*/

log close
