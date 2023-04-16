0) mám soubory x.l a x.y
1) generuji y.tab.h a y.tab.c:	yacc -d x.y
2) generuji lex.yy.c: 			lex x.l
4) compile:					gcc le.yy.c y.tab.c -o executableFileName