%{

/* Original EBNF    
MyLang = syntax;
syntax = expr, { "&",expr};
expr = term, { "+", term };
term = factor, { "*", factor };
factor = "(", expr, ")" | numberU;
numberU = unary,number;
number = float | bool;
float = whole, numend;
whole = nonzeroDigit, {digit} | zero;
unary = "++" | ;
numend = ".", whole2 | ;
whole2 = digit, {digit};

zero = "0";
bool = "T" | "F";
digit = "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9";
nonzeroDigit = "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9";
*/

#include <stdio.h>
#include <stdlib.h>


int yylex();
void yyerror(const char *s);
extern int yylineno, yylval;

%}
%token INT
%token BOOL
%token FLOAT
%token L_BR
%token R_BR
%token PLUS
%token MPY
%token INCREMENT
%token AMPR
%token LINE_END

%%
/* Expr:
    expr_part1 expr_part2    {action; }
    | other expr
    ;
*/

MyLang:
    MyLang syntax LINE_END { printf("Syntax OK, Rule0\n"); }
    | syntax LINE_END { printf("Syntax OK, Rule0\n") ;}
    ;

syntax:
    expr { printf("Rule1\n");}
    | syntax AMPR expr { printf("Rule1\n");} 
    ;

expr:
    term {printf("Rule2\n"); }
    | expr PLUS term {printf("Rule2\n"); }
    ;

term:
    factor { printf("Rule3\n"); }
    | term MPY factor { printf("Rule3\n"); }

    ;

factor:
    L_BR expr R_BR { printf("Rule4\n"); }
    | numberU { printf("Rule4\n"); }
    ;

numberU:
    INCREMENT number { printf("Rule5\n"); }
    | number { printf("Rule5\n"); }
    ;

number:
    BOOL { printf("Rule6\n"); }
    | INT { printf("Rule6\n"); }
    | FLOAT { printf("Rule6\n"); }
    ;

%%

/* C code */


void yyerror(const char* s) {   
    printf("%s\n",s);
}

void main(){
    // yydebug = 1;
    printf("Entering the main:\n");
    yyparse();
    
    
}

