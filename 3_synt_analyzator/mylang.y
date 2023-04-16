%{

/* Original EBNF    
syntax = expr, { "&",expr};
expr = term, { "+", term };
term = factor, { "*", factor };
factor = "(", expr, ")" | numberU;
numberU = unary,number;
number = float | bool;
float = whole,numend;
whole = nonzeroDigit, {digit} | zero;
bool = "T" | "F";
digit = "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9";
nonzeroDigit = "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9";
zero = "0";
unary = "++" | ;
numend = ".", whole2 | ;
whole2 = digit, {digit};
*/

#include <stdio.h>
#include <stdlib.h>


int yylex();
void yyerror(const char *s);
extern int yylineno, yylval;

%}
%token INT
%token BOOL
%token NONZERO_INT
%token ZERO
%token L_BR
%token R_BR
%token PLUS
%token MPY
%token INCREMENT
%token AMPR
%token DOT
%token LINE_END

%%
/* Expr:
    expr_part1 expr_part2    {action; }
    ;
*/

Syntax:
    expr LINE_END { printf("Rule1\n"); }
    | AMPR expr LINE_END { printf("Rule1\n");} 
    ;

expr:
    term { printf("Rule2\n"); }
    | PLUS term {printf("Rule2\n"); }
    ;

term:
    factor { printf("Rule3\n"); }
    | MPY factor { printf("Rule3\n"); }
    ;

factor:
    L_BR expr R_BR { printf("Rule4\n"); }
    | numberU { printf("Rule4\n"); }
    ;

numberU:
    unary { printf("Rule5\n"); }
    | number { printf("Rule5\n"); }
    ;

number:
    float { printf("Rule6\n"); }
    | BOOL { printf("Rule6\n"); }
    ;

float:
    whole numend { printf("Rule7\n"); }
    ;

whole:
    NONZERO_INT { printf("Rule8\n"); }
    | NONZERO_INT INT { printf("Rule8\n"); }
    | ZERO { printf("Rule8\n"); }
    ;

unary:
    INCREMENT { printf("Rule10\n"); }
    | { printf("Rule10\n"); }
    ;

numend:
    DOT whole2 { printf("Rule11\n"); }
    | { printf("Rule11\n"); }
    ;

whole2:
    INT { printf("Rule12\n"); }
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

