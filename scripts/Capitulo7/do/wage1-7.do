**** CHAPTER 7

** EXAMPLE 7.1, 7.5, 7.6 e 7.10

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap7"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using wage1_7.log, replace

*Importando dados
import excel "wage1.xls", firstrow clear

*Sumário
summarize


*Regressões 7.1
eststo ex7_11: reg wage female educ exper tenure 

esttab ex7_11 using "tab7_11.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

/*
			wage
female		-1.811***
			(0.265)
	
educ		0.572***
			(0.0493)
		
exper		0.0254**
			(0.0116)
	
tenure		0.141***
			(0.0212)
	
_cons		-1.568**
			(0.725)
Obs.		526
R2			0.364
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01


*/


eststo ex7_12: reg wage female

esttab ex7_12 using "tab7_12.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
			wage
female		-2.512***
			(0.303)
	
_cons		7.099***
			(0.210)
Obs.		526
R2			0.116
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Pelas estimações é possível notar que o salário da mulher 
é menor que o do homem, mesmo controlando, por experiência
anos de educação e anos na empresa
*/

*Regressão 7.5
eststo ex7_5: reg lwage female educ exper expersq tenure tenursq

esttab ex7_5 using "tab7_5.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

*Efeito em porcentagem de ser mulher
display 100*(exp(_b[female])-1)
/*
			lwage
female		-0.297***
			(0.0358)
	
educ		0.0802***
			(0.00676)
	
exper		0.0294***
			(0.00498)
	
expersq		-0.000583***
			(0.000107)
		
tenure		0.0317***
			(0.00685)
	
tenursq		-0.000585**
			(0.000235)
	
_cons		0.417***
			(0.0989)
Obs.		526
R2			0.441
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

variação no salario de -25.7% 
*/
*Exemplo 7.6

* Homem casado
gen marrmale = (married==1 & female==0)

* Mulher casada
gen marrfem = (married==1 & female==1)

* Mulher solteira
gen singfem = (married==0 & female==1)

*Regressão 7.6
eststo ex7_6: reg lwage marrmale marrfem singfem educ exper expersq tenure tenursq

esttab ex7_6 using "tab7_6.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
*testar se mulheres solteiras e casadas têm o mesmo salário esperado
lincom singfem - marrfem
/*
			lwage
marrmale	0.213***
			(0.0554)
	
marrfem		-0.198***
			(0.0578)
	
singfem		-0.110**
			(0.0557)
	
educ		0.0789***
			(0.00669)
	
exper		0.0268***
			(0.00524)
	
expersq		-0.000535***
			(0.000110)
	
tenure		0.0291***
			(0.00676)
	
tenursq		-0.000533**
			(0.000231)
	
_cons		0.321***
			(0.100)
Obs.		526
R2			0.461
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

No exemplo a estimação é refeita com mulheres casadas sendo grupo
base, o efeito achado a partir dos coeficientes dessa
regressão que fizemos é o mesmo da segunda regressão, apesar
de ser uma evidencia marginal contra a hipótese nula
*/

* Exemplo 7.10
* Regressão 7.10
eststo ex7_10: reg lwage female educ c.female#c.educ exper expersq tenure tenursq

esttab ex7_10 using "tab7_10.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 F, ///
          fmt(0 3 3) ///
          labels("Obs." "R²" "Estatística F"))
/*
				lwage
female			-0.227
				(0.168)
	
educ			0.0824***
				(0.00847)
	
c.female#c.educ	-0.00556
				(0.0131)
	
exper			0.0293***
				(0.00498)
	
expersq			-0.000580***
				(0.000108)
	
tenure			0.0319***
				(0.00686)
		
tenursq			-0.000590**
				(0.000235)
	
_cons			0.389***
				(0.119)
Obs.			526
R²				0.441
Estatística F	58.371
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01
*/

* teste no coeficiente
display _b[c.female#c.educ]/_se[c.female#c.educ]

* teste conjunto
test female c.female#c.educ

* Retorno da educação para as mulheres
display _b[educ] + _b[c.female#c.educ]

* Centralizar edcuação em 12.5 anos
gen educc = educ - 12.5

reg lwage female educ c.educc#c.female exper expersq tenure tenursq
/*
com essa ultima regressão, o beta female mede a diferença no salário
entre homens e mulheres quando educ = 12.5
*/

log close
