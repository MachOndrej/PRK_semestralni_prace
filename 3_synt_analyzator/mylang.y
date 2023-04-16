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
#include <stdarg.h>

void debug_print(const char* fmt, ...);


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
    expr LINE_END { debug_print("Rule1\n"); }
    | AMPR expr LINE_END { debug_print("Rule1\n");} 
    ;

expr:
    term { debug_print("Rule2\n"); }
    | PLUS term {debug_print("Rule2\n"); }
    ;

term:
    factor { debug_print("Rule3\n"); }
    | MPY factor { debug_print("Rule3\n"); }
    ;

factor:
    L_BR expr R_BR { debug_print("Rule4\n"); }
    | numberU { debug_print("Rule4\n"); }
    ;

numberU:
    unary { debug_print("Rule5\n"); }
    | number { debug_print("Rule5\n"); }
    ;

number:
    float { debug_print("Rule6\n"); }
    | BOOL { debug_print("Rule6\n"); }
    ;

float:
    whole numend { debug_print("Rule7\n"); }
    ;

whole:
    NONZERO_INT { debug_print("Rule8\n"); }
    | NONZERO_INT INT { debug_print("Rule8\n"); }
    | ZERO { debug_print("Rule8\n"); }
    ;

unary:
    INCREMENT { debug_print("Rule10\n"); }
    | { debug_print("Rule10\n"); }
    ;

numend:
    DOT whole2 { debug_print("Rule11\n"); }
    | { debug_print("Rule11\n"); }
    ;

whole2:
    INT { debug_print("Rule12\n"); }
    ;
%%

/* C code */

void debug_print(const char* fmt, ...)
{
    /* Create a va_list to hold the variable arguments */
    va_list args;

    /* Initialize the va_list with the variable arguments */
    va_start(args, fmt);

    /* Print the formatted string to stdout */
    printf("[DEBUG] ");
    vprintf(fmt, args);
    printf("\n");

    /* Clean up the va_list */
    va_end(args);
}


void yyerror(const char* s) {   
    printf("%s\n",s);
}

void main(){
    // yydebug = 1;
    debug_print("Entering the main");
    yyparse();
    
    
}

