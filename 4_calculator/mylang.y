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
#include <string.h>
#include <stdint.h>

int yylex();
void yyerror(const char *s);
//extern int yylineno, yylval;

%}

%union {
    int     intValue;
    float   floatValue;
    char*   stringValue;
}

%token <intValue> INT
%token <intValue> BOOL
%token <floatValue> FLOAT

%token L_BR
%token R_BR
%token PLUS
%token MPY
%token INCREMENT
%token AMPR
%token LINE_END

%type <floatValue> number numberU factor term expr syntax MyLang


%%
/* Expr:
    expr_part1 expr_part2    {action; }
    | other expr
    ;
*/

MyLang:
    MyLang syntax LINE_END { printf("Syntax OK, Rule0\n"), printf("%.3f\n", $2); }
    | syntax LINE_END { printf("Syntax OK, Rule0\n"), printf("Result: %.3f\n", $1);}
    ;

syntax:
    expr { printf("Rule1\n"), $$ = $1; }
    | syntax AMPR expr { printf("Rule1\n"); } //TODO: dva vyrazy
    ;

expr:
    term {printf("Rule2\n"), $$ = $1; }
    | expr PLUS term {printf("Rule2\n"), $$ = $1 + $3; }
    ;

term:
    factor { printf("Rule3\n"), $$ = $1; }
    | term MPY factor { printf("Rule3\n"), $$ = $1 * $3; }
    ;

factor:
    L_BR expr R_BR { printf("Rule4\n"), $$ = ( $2 ); }
    | numberU { printf("Rule4\n"), $$ = $1; }
    ;

numberU:
    INCREMENT number { printf("Rule5\n"), $$ = 1 + $2; }
    | number { printf("Rule5\n"), $$ = $1; }
    ;

number:
    BOOL { printf("Rule6\n"), $$ = (float)$1 ; }
    | INT { printf("Rule6\n"), $$ = (float)$1 ; }
    | FLOAT { printf("Rule6\n"), (float)$$; }
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
