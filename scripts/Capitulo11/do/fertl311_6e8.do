**** CHAPTER 11

** EXAMPLE 11.4 e 10.8

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap11"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using fertil_11_6_8.log, replace

*Importando dados
import excel "fertil3.xls", firstrow clear

*Sumário
destring pe_1 pe_2 pe_3 pe_4 cgfr cpe cpe_1 cpe_2 cpe_3 cpe_4 gfr_1 cgfr_1 cgfr_2 cgfr_3 cgfr_4 gfr_2, replace
summarize

*Calculando autocorrelação sem detrending
tsset year
corr gfr L.gfr if !missing(L.gfr)
corr pe L.pe if !missing(L.pe)

** Regressão 1
eststo ex11_61: reg cgfr cpe
display e(r2)

esttab ex11_61 using "fertil3-11_61.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
p1chapeu[gfr] =  0.9765 
p1chapeu[pe] =   0.9636 

		cgfr
cpe		-0.0427
		(0.0284)
	
_cons	-0.785
		(0.502)
Obs.	71
R2		0.0318
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

** Regressão 2
eststo ex11_62: reg cgfr cpe cpe_1 cpe_2 
display e(r2)

esttab ex11_62 using "fertil3-11_62.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
/*
		cgfr
cpe		-0.0362
		(0.0268)
	
cpe_1	-0.0140
		(0.0276)
		
cpe_2	0.110***
		(0.0269)
	
_cons	-0.964**
		(0.468)
Obs.	69
R2		0.232
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

* Exemplo 11.8
eststo ex11_8: reg cgfr cpe cpe_1 cpe_2 cgfr_1
display e(r2)

esttab ex11_8 using "fertil3-11_8.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
cgfr_1		0.300***
			(0.106)
 pro modelo da regressão 11_62 ser dinamicamente completo
nenhum lag de cgfr e cpe deveria aparecer
 se adicionar um falso cgfr_1, ele tem estatística t = 2.84
logo o modelo não é dinamicamente completo

*/
log close
