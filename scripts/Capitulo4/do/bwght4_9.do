**** CHAPTER 4

** EXAMPLE 4.9

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap4"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using bwght4_9.log, replace

*Importando dados
import excel "bwght.xls", clear
type BWGHT.DES

rename (A-N) (faminc cigtax cigprice bwght fatheduc motheduc parity male white cigs lbwght bwghtlbs packs lfaminc)

label variable faminc     "1988 family income, $1000s"
label variable cigtax     "cig. tax in home state, 1988"
label variable cigprice   "cig. price in home state, 1988"
label variable bwght      "birth weight, ounces"
label variable fatheduc   "father's yrs of educ"
label variable motheduc   "mother's yrs of educ"
label variable parity     "birth order of child"
label variable male       "=1 if male child"
label variable white      "=1 if white"
label variable cigs       "cigs smked per day while preg"
label variable lbwght     "log of bwght"
label variable bwghtlbs   "birth weight, pounds"
label variable packs      "packs smked per day while preg"
label variable lfaminc    "log(faminc)"

destring fatheduc, replace
destring motheduc, replace
*Sumário
summarize

*Regressão - eststo salva resultados(unrestricted)
eststo ex4_9: reg bwght cigs parity faminc motheduc fatheduc


***** TABELA COM O RESULTADO  - SAlVA O ARQUIVO NO SEU DIRETORIO
esttab ex4_9 using "tab4_9_ur.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
	
* Feito direto
test motheduc fatheduc

* Feito a mão
scalar R2_ur = e(r2)
scalar n = e(N)
/*
	     bwght
cigs	   -0.596***
	       (0.110)
	
parity	    1.788***
	       (0.659)
	
faminc	    0.0560
	       (0.0366)
	
motheduc	-0.370
	        (0.320)
	
fatheduc	0.472*
	        (0.283)
	
_cons	   114.5***
	       (3.728)
Obs.	   1191
R2ur	   0.0387
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

*/

*Regressão Restrita(sem motherduc e fathereduc)
eststo ex4_91: reg bwght cigs parity faminc if(motheduc != . & fatheduc != .)


***** TABELA COM O RESULTADO  - SAlVA O ARQUIVO NO SEU DIRETORIO
esttab ex4_91 using "tab4_9_1r.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

scalar R2_r = e(r2)
/*
Resultado da regressão restrita
		bwght
cigs	-0.598***
		(0.109)
	
parity	1.832***
		(0.658)
	
faminc	0.0671**
		(0.0324)
	
_cons	115.5***
		(1.656)
Obs.	1191
R2   	0.0364
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01
*/
* Continuando o feito a mâo
* Parâmetros
scalar q = 2
scalar k = 5

* Numerador
scalar numerador = (R2_ur - R2_r)/q

* Denominador
scalar denominador = (1 - R2_ur)/(n - k - 1)

* Estatística F
scalar F_manual = numerador/denominador

display "Numerador: " numerador
display "Denominador: " denominador
display "Estatistica F: " F_manual
/*
Teste F, faz excluindo motheduc e fatheduc
H_0: Beta_4 = Beta_5 = 0
df = n - k - 1 = 1191 - 5 - 1 = 1185
valor crítico a 5% c = 3

F = [(R^2ur - R^2r)/q]/[1-R^2ur)/df]
q = 2
calculando o numerador 
(0.0387 - 0.0364)/2 = 0.00115
calculando o denominador
(1 - 0.0387) / 1185 = 0.000811223
F = numerador / denominador = 1.42
Logo, falhamos em rejeitar a hipótese nula

Calculado pelo stata = 1.44
*/


log close
