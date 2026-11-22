**** CHAPTER 7

** EXAMPLE 7.7

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap7"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace
ssc install bcuse, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using beauty_7.log, replace

*Importando dados
bcuse beauty
export delimited using "beauty.csv", replace
*Sumário
summarize

*Regressões 7.7
bysort female: gen ordem = sum(female == 0) if female == 0
eststo ex7_7: reg lwage belavg abvavg educ exper expersq married black union goodhlth south bigcity smllcity service if female == 0 & ordem <= 700

esttab ex7_7 using "tab7_7.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
/*
			lwage
belavg		-0.171***
			(0.0571)
	
abvavg		-0.00859
			(0.0396)
	
educ		0.0574***
			(0.00733)
	
exper		0.0483***
			(0.00609)
	
expersq		-0.000790***
			(0.000130)
	
married		0.0766*
			(0.0465)
	
black		-0.313***
			(0.0775)
	
union		0.106***
			(0.0384)
	
goodhlth	-0.0191
			(0.0724)
	
south		0.102**
			(0.0450)
	
bigcity		0.295***
			(0.0491)
	
smllcity	0.153***
			(0.0410)
	
service		-0.197***
			(0.0468)
	
_cons		0.436***
			(0.129)
Obs.		700
R2			0.307
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01
Os resultados dessa e da segunda regressão deram diferente
apesar de próximos
pois as bases utilizadas são diferentes

*/

bysort female: gen ordem2 = sum(female == 1) if female == 1
eststo ex7_71: reg lwage belavg abvavg educ exper expersq married black union goodhlth south bigcity smllcity service if female == 1 & ordem2 <= 409

esttab ex7_71 using "tab7_71.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
/*
			lwage
belavg		-0.137**
			(0.0694)
	
abvavg		0.0709
			(0.0504)
	
educ		0.0778***
			(0.0100)
	
exper		0.0282***
			(0.00734)
	
expersq		-0.000467***
			(0.000179)
	
married		-0.0623
			(0.0456)
	
black		0.132*
			(0.0725)
	
union		0.293***
			(0.0550)
	
goodhlth	0.0996
			(0.0852)
	
south		-0.0274
			(0.0639)
	
bigcity		0.129*
			(0.0673)
	
smllcity	0.0159
			(0.0514)
	
service		-0.0971**
			(0.0483)
	
_cons		-0.0653
			(0.153)
Obs.		409
R2			0.293
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/
log close
