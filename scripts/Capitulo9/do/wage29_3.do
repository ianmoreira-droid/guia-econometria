**** CHAPTER 9

** EXAMPLE 9,3

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap9"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using wage2_9_3.log, replace

*Importando dados
import excel "wage2.xls", firstrow clear

*Sumário
summarize

*** Exemplo 9.3

*Regressão 1
eststo ex9_3: reg lwage educ exper tenure married south urban black

esttab ex9_3 using "tab9_3_1.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
		lwage
educ	0.0654***
		(0.00625)
	
exper	0.0140***
		(0.00319)
	
tenure	0.0117***
		(0.00245)
	
married	0.199***
		(0.0391)
	
south	-0.0909***
		(0.0262)
	
urban	0.184***
		(0.0270)
	
black	-0.188***
		(0.0377)
	
_cons	5.395***
		(0.113)
Obs.	935
R2		0.253
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

*Regressão 2
eststo ex9_31: reg lwage educ exper tenure married south urban black IQ

esttab ex9_31 using "tab9_3_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
		lwage
educ	0.0544***
		(0.00693)
	
exper	0.0141***
		(0.00317)
	
tenure	0.0114***
		(0.00244)
	
married	0.200***
		(0.0388)
	
south	-0.0802***
		(0.0263)
		
urban	0.182***
		(0.0268)
	
black	-0.143***
		(0.0395)
	
IQ		0.00356***
		(0.000992)
	
_cons	5.176***
		(0.128)
Obs.	935
R2		0.263
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Incluir o IQ aumenta a parcela da variação do salário
explicada
*/	

*Regressão 3
eststo ex9_32: reg lwage educ exper tenure married south urban black IQ c.IQ#c.educ

esttab ex9_32 using "tab9_3_3.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
			lwage
educ		 0.0185
			(0.0411)
	
exper		 0.0139***
			(0.00318)
	
tenure		0.0114***
			(0.00244)
	
married		0.201***
			(0.0388)
	
south		-0.0802***
			(0.0263)
	
urban		 0.184***
			(0.0269)
		
black		-0.147***
			(0.0397)
	
IQ			-0.000942
			(0.00516)
	
c.IQ#c.educ	0.000340
			(0.000383)
	
_cons		5.648***
			(0.546)
Obs.		935
R2			0.263
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Incluir a interação de IQ com educ não é estatistica-
-mente significativa, tornando o modelo mais complexo 
sem explicação
*/
log close
