** CAPITULO 6

***EXEMPLO 6.5 e 6.6

clear all
set more off

capture log close 

cd "C:/Users/ianpm/Desktop/Ian/Faculdade/UFBA/PIBIC/Stata/ExemplosWooldridge/Cap6"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using gpa2.log, replace

*Importando dados
import excel "gpa2.xls", firstrow clear

summarize

**6.5.1
*Regressão - eststo salva resultados
eststo ex6_51: reg colgpa sat hsperc hsize hsizesq

esttab ex6_51 using "tabela6_51.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 r2_a rmse, ///
          labels("Obs." "R²" "R² Ajustado" "σ̂"))

*Printando o valor predito
margins, at(sat=1200 hsperc=30 hsize=5 hsizesq=25)
*y =  2.700075

* Gerando variáveis para facilitar obter IC
gen sat0 = sat - 1200
gen hsperc0 = hsperc - 30
gen hsize0 = hsize - 5
gen hsizesq0 = hsizesq - 25

**6.5.2
*Regressão - eststo salva resultados
eststo ex6_52: reg colgpa sat0 hsperc0 hsize0 hsizesq0

esttab ex6_52 using "tabela6_52.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 r2_a rmse, ///
          labels("Obs." "R²" "R² Ajustado"  "σ̂"))
		  
display _b[_cons] - 1.96*_se[_cons]
display _b[_cons] + 1.96*_se[_cons]
/*
				(1)
				colgpa
sat				0.00149***
				(0.0000652)
	
hsperc			-0.0139***
				(0.000561)
	
hsize			-0.0609***
				(0.0165)
	
c.hsize#c.hsize	0.00546**
				(0.00227)
	
_cons			1.493***
				(0.0753)
Obs.			4137
R²				0.278
R² Ajustado		0.277
σ̂				0.560
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01


			(2)
			colgpa
sat0		0.00149***
			(0.0000652)
	
hsperc0		-0.0139***
			(0.000561)
	
hsize0		-0.0609***
			(0.0165)
	
hsizesq0	0.00546**
			(0.00227)
	
_cons		2.700***
			(0.0199)
Obs.		4137
R²			0.278
R² Ajustado	0.277
σ̂			0.560
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

A diferença nas 2 equações é o intercepto, na equação debaixo 2.7, exatamente
o valor predito pela primeira regressão 

para fazer o intervalo de confiança a 95% de nível de confiança:
LI = 2.700 - 1.96*0.02 = 2.66 (2.6611149)
LS = 2.700 + 1.96*0.02 = 2.739 ~ 2.74 (2.7390361)

*/

* 6.6 
display sqrt(_se[_cons]^2 + e(rmse)^2)
/*
Outra forma de fazer o intervalo de confiança é:
usar o erro padrão do y predito e o desvio padrão estimado do erro do modelo
se(y^) = 0.0199 ~ 0.02
σ̂	   = 0.560
fazendo se(e^) = [0.02^2 + 0.560^2]^1/2 =~ 0,560
IC a 95%:
LI = 2.7 - 1.96*0,560 = 1.6
LS = 2.7 + 1.96*0,560 =~ 3.8
*/
log close
