**** CHAPTER 5

** EXAMPLE 5.2

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\PIBIC\Stata\ExemplosWooldridge\Cap5"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO


** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear
clear all

log using bwght5.log, replace

*Importando dados
import excel "bwght.xls", firstrow clear
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


*Sumário
summarize

*Regressão - eststo salva resultados
eststo ex5_21: reg lbwght cigs lfaminc
display e(r2)

esttab ex5_21 using "bwght51.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))


*Regressão até a observação 694	
eststo ex5_22: reg lbwght cigs lfaminc in 1/694
display e(r2)

esttab ex5_22 using "bwght52.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
/*
se(Betaj) =~ cj/√n 
dividindo erro padrão da população completa, 
pelo erro-padrão da metade da população
(c/n^1/2) / (c/(n/2)^1/2) = (1/2)^1/2 = 0.707106781

setotaln = .0008585
se(n/2) =  .0013335 
setotaln/se(n/2)= 0.662 aproximado, a diferença entre o valor que deveria ser
e o encontrado se deve ao fato de estarmos no mundo amostral
*/





log close
