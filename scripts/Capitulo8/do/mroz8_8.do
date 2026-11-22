**** CHAPTER 8

** EXAMPLE 8.8

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap8"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using mroz8_8.log, replace

*Importando dados
import excel "mroz.xls", firstrow clear

*Sumário
summarize

*Regressão 8.8
eststo ex8_8: reg inlf nwifeinc educ exper expersq age kidslt6 kidsge6

esttab ex8_8 using "tab8_8.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
			inlf
nwifeinc	-0.00341**
			(0.00145)
			[.0015249]
	
educ		0.0380***
			(0.00738)
			[.007266]
	
exper		0.0395***
			(0.00567)
			[.00581]
	
expersq		-0.000596***
			(0.000185)
			[.00019]
	
age			-0.0161***
			(0.00248)
			[.002399]
	
kidslt6		-0.262***
			(0.0335)
			[.0317832]
	
kidsge6		0.0130
			(0.0132)
			[.0135329]
	
_cons		0.586***
			(0.154)
			[.1522599]
Obs.		753
R2			0.264
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Apesar da heterocedasticidade ser uma preocupação teórica, 
ela praticamente não altera a inferência nesse exemplo.	
Vale a pena reportar os 2, já que não aumenta o esforço pra calcular
*/

*Regressão Com Erro padrão robusto
reg inlf nwifeinc educ exper expersq age kidslt6 kidsge6, vce(robust)

foreach v in nwifeinc educ exper expersq age kidslt6 kidsge6 {
    di "`v'  t = " _b[`v']/_se[`v']
}


log close
