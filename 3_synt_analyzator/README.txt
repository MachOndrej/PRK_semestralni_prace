NOTES

_________________________________________________________________________
Postup: 

0) mám soubory x.l a x.y
	*x.l musí obsahovat #INCLUDE "y.tab.h"
1) generuji y.tab.h a y.tab.c:	yacc -d x.y
2) generuji lex.yy.c: 			lex x.l
3) compile:					gcc lex.yy.c y.tab.c -o x
4) run:					./ x