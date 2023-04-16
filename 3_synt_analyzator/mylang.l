%{
/* Variable declaration */

int values=0;
int lines_done=0;
int void_lines_done=0;
int lines_comment=0;
int add_ops=0;
int mpy_ops=0;
int inc_ops=0;
int ampr=0;
int dot=0;
int br_left=0;
int br_right=0;
int errors_detected=0;

#include <stdio.h>
#include <stdlib.h>
#include "mylang.h"
#include "y.tab.h"

/* Function prototype */
int process_pattern(int number, char *Message, int Pattern);
void print_error(int ERRNO);
void print_msg(char *msg);

%}

%%
[1-9]           {values=process_pattern(values,"NonZero detected.", PATT_NONZERO_INT); yylval = atoi(yytext);   return NONZERO_INT;}
"0"             {values=process_pattern(values,"Zero detected.", PATT_ZERO); yylval = atoi(yytext);             return ZERO;}
[0-9]*          {values=process_pattern(values,"Integer detected.", PATT_INT); yylval = atoi(yytext);           return INT;}
T|F             {values=process_pattern(values,"Boolean detected.", PATT_BOOL); yylval = (yytext[0] == 'T');    return BOOL;}

\+              {add_ops=process_pattern(add_ops,"Add operator detected.",PATT_PLUS);                           return PLUS;}
\*              {mpy_ops=process_pattern(mpy_ops,"Multiplication operator detected.",PATT_MPY);                 return MPY;}
\(              {br_left=process_pattern(br_left,"Opening bracket detected.",PATT_L_BR);                        return L_BR;}
\)              {br_right=process_pattern(br_right,"Opening bracket detected.",PATT_R_BR);                      return R_BR;}
"++"            {inc_ops=process_pattern(inc_ops,"Increment operation detected.",PATT_INCREMENT);               return INCREMENT;}
"."             {dot=process_pattern(dot,"Dot.",PATT_DOT);                                                      return DOT;}
\&              {ampr=process_pattern(ampr,"New example.",PATT_AMPR);                                           return AMPR;}
[ \t]+          { /* Ignore whitespace */ }
^\n             {void_lines_done++; print_msg("Void line detected.\n");}       
\n              {lines_done++; print_msg("Line detected.\n");                                                   return LINE_END;}
.               { /* Ignore all other characters */ }
%%

/* Function declaration */

int yywrap(void) {
return 1;
}


void print_msg(char *msg){
    #ifdef VERBOSE
        printf("%s",msg);
    #endif
}

void print_error(int ERRNO){
    #ifdef VERBOSE
    char *message = Err_Messages[ERRNO];
    printf("%s - %d - %s\n",ErrMsgMain,ERR_PATTERN,message);
    #endif
}

int process_pattern(int number,char* Message, int Pattern) {
    if (Pattern == PATT_ERR) {       
        print_error(ERR_PATTERN);        
        exit(ERR_PATTERN);
    }    

    print_msg(Message);
    
    number++;
    return number;
}

