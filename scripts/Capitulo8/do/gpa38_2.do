**** CHAPTER 8

** EXAMPLE 8.2

clear all
set more off

capture log close 

cd "C:\Users\ianpm\Desktop\Ian\Faculdade\UFBA\PIBIC\Stata\ExemplosWooldridge\Cap8"

*** INSTALAR PACOTE PARA GERAR TABELAS DE REGRESAO
ssc install estout, replace

** LIMPAR RESULTADOS JA SALVOS ANTERIORMENTE
eststo clear

log using gpa3_8_2.log, replace

*Importando dados
import excel "gpa3.xls", firstrow clear

*Sumário
summarize

*Regressão 8.2
eststo ex8_2: reg cumgpa sat hsperc tothrs female black white if spring == 1

esttab ex8_2 using "tab8_2.rtf", replace ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2, labels("Obs." "R2"))
test black white
/*
		cumgpa
sat		0.00114***
		(0.000179)
		[.0001915]
	
hsperc	-0.00857***
		(0.00124)
		[.0014179]
	
tothrs	0.00250***
		(0.000731)
		[.0007406]
		
female	0.303***
		(0.0590)
		[.0591378]
		
black	-0.128
		(0.147)
		[.1192413]
		
white	-0.0587
		(0.141)
		[.111392]
		
_cons	1.470***
		(0.230)
		[.2206802]
Obs.	366
R2		0.401
Standard errors in parentheses
* p < 0.10, ** p < 0.05, *** p < 0.01

Conclui-se, pelos dois testes, que não se rejeita H0: 
não há evidências de diferenças no cumgpa associadas 
à raça após controlar pelas demais variáveis.

Estatistica F =~ 0.69
p-valor =  0.5075

Teste F robusto:
F = 0.73
p-valor = 0.4809
Resultado diferente do livro pode ser pelo banco de dados
ou por uma versão mais atualizada do Stata
*/

*Regressão Com Erro padrão robusto
reg cumgpa sat hsperc tothrs female black white if spring == 1, vce(robust)

foreach v in sat hsperc tothrs female black white {
    di "`v'  t = " _b[`v']/_se[`v']
}
test black white

log close
