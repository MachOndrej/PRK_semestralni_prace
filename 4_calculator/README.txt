Pro kompilaci> make all 

- test ok vypise rovnou (korektni vysledky jsou v results)
- spustitelni soubor> bin/mylang_parser

______________________________________________________________________________
Jak pracuje kalkulacka:
$$      ... aktualni pracovni uzel
$1, $2, ... podle poradi ve vyrazu
- vysledek tiskne na 3 desetinna mista

______________________________________________________________________________
Puvodni (rucni) spousteni 

0) mám soubory x.l a x.y
1) generuji y.tab.h a y.tab.c:	yacc -d x.y
2) generuji lex.yy.c: 			lex x.l
4) compile:					gcc le.yy.c y.tab.c -o executableFileName

