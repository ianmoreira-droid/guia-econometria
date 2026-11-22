**** CHAPTER 8

** EXAMPLE 8.3

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap8"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using crime1_8.log, replace

*Importando dados
import excel "crime1.xls", firstrow clear

*Sumário
summarize

*Regressões 8.3 
eststo ex8_3: reg narr86 pcnv avgsen avgsensq ptime86 qemp86 inc86 black hispan

esttab ex8_3 using "tab8_3.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
test avgsen avgsensq
* Regressão com Erro-padrão robusto
reg narr86 pcnv avgsen avgsensq ptime86 qemp86 inc86 black hispan, vce(robust)

/*
			narr86
pcnv		-0.136***
			(0.0404)
			[.0336218]
	
avgsen		0.0178*
			(0.00970)
			[.0101233]
	
avgsensq	-0.000516*
			(0.000297)
			[.0002077]
	
ptime86		-0.0394***
			(0.00869)
			[.0062236]
	
qemp86		-0.0505***
			(0.0144)
			[.0142015]
	
inc86		-0.00148***
			(0.000341)
			[.0002295]
	
black		0.325***
			(0.0454)
			[.0585135]
	
hispan		0.193***
			(0.0397)
			[.0402983]
	
_cons		0.567***
			(0.0361)
			[.0402756]
Obs.		2725
R2			0.0728
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01
Teste F em avgsen avgsensq F = 1.73 e p-valor = 0.1779, não são conjunta-
-mente significantes

LM Usual: LM = 3.4626014; p-valor = .17705396

LM Robusto: LM = 3.9970853 ~ 4; p-valor = .13553266
*/
*Teste LM usual
reg narr86 pcnv ptime86 qemp86 inc86 black hispan
predict u, residuals
reg u pcnv avgsen avgsensq ptime86 qemp86 inc86 black hispan
display 2725*e(r2)
display chi2tail(2,2725*e(r2))
*Teste LM Robusto
reg narr86 pcnv ptime86 qemp86 inc86 black hispan
predict uhat_1, resid

reg avgsen pcnv ptime86 qemp86 inc86 black hispan
predict r_avgsen, resid

reg avgsensq pcnv ptime86 qemp86 inc86 black hispan
predict r_avgsen2, resid

gen z1 = r_avgsen*uhat_1
gen z2 = r_avgsen2*uhat_1
gen one = 1

reg one z1 z2, noconstant
display e(N)-e(rss)
display chi2tail(2,e(N)-e(rss))
log close
