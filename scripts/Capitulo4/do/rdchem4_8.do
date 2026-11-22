**** CHAPTER 4

** EXAMPLE 4.8

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap4"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using rdchem4_8.log, replace

*Importando dados
import excel "rdchem.xls", clear
type RDCHEM.DES

rename(A-H) (rd sales profits rdintens profmarg salessq lsales lrd)

label var rd              "R&D spending, millions $"
label var sales           "firm sales, millions $"
label var profits         "profits, millions $"
label var rdintens        "rd as percent of sales"
label var profmarg        "profits as percent of sales"
label var salessq         "sales^2"
label var lsales          "log(sales)"
label var lrd             "log(rd)"

summarize

eststo ex4_8: reg lrd lsales profmarg

***** TABELA COM O RESULTADO  - SAlVA O ARQUIVO NO SEU DIRETORIO
esttab ex4_8 using "tab4_8.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))

* Invervalo de confiança
display _b[lsales] - invttail(e(df_r), 0.025)*_se[lsales]
display _b[lsales] + invttail(e(df_r), 0.025)*_se[lsales]
lincom profmarg
/*
			lrd
lsales		1.084***
			(0.0602)
	
profmarg	0.0217
			(0.0128)
		
_cons		-4.378***
			(0.468)
Obs.		32
R2			0.918
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

intervalo de confiança(Beta = Beta_chapeu +- c.erropadrao)
df = n - k - 1 = 32 - 2 - 1 = 29
valor crítico a  2,5% c = 2.045
para Beta_lsales(0.961, 1.21) -> não dá pra rejeitar H_0: Beta_lsales = 1 em favor de H_1: != 1
para Beta_profmarg(-0.0045, 0.0479) 
*/

log close
