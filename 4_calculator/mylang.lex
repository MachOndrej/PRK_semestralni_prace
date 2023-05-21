%{
/* Variable declaration */

int float_val=0;
int zero=0;
int integer=0;
int boolean=0;

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
#include <stdbool.h>
#include "mylang.h"
#include "y.tab.h"

/* Function prototype */
int process_pattern(int number, char *Message, int Pattern);
void print_error(int ERRNO);
void print_msg(char *msg);

/* !!! NA KONEC SOUBORU DÁT PRÁZDNOU ŘÁDKU; MEZI VÝRAZY DÁVAT JEN COMMENTY, NE PRÁZDNÉ ŘÁDKY!!! */               

%}

%%
^#.*\n          {lines_comment=process_pattern(lines_comment,"Comment deleted.\n",PATT_NO); }

([1-9][0-9]*)|0 {integer=process_pattern(integer,"Integer detected.", PATT_INT); yylval.intValue = atoi(yytext);   
                    return INT; }

[0-9]+\.[0-9]+  {float_val=process_pattern(float_val,"Float detected.", PATT_FLOAT); yylval.floatValue = atof(yytext);           
                    return FLOAT; }  

"T"             {boolean=process_pattern(boolean,"Boolean detected.", PATT_BOOL); yylval.intValue = 1;              
                    return BOOL; }

"F"             {boolean=process_pattern(boolean,"Boolean detected.", PATT_BOOL); yylval.intValue = 0;
                    return BOOL; }   

\+              {add_ops=process_pattern(add_ops,"Add operator detected.",PATT_PLUS);
                    return PLUS; }
\*              {mpy_ops=process_pattern(mpy_ops,"Multiplication operator detected.",PATT_MPY); 
                    return MPY; }
\(              {br_left=process_pattern(br_left,"Opening bracket detected.",PATT_L_BR);
                    return L_BR; }
\)              {br_right=process_pattern(br_right,"Opening bracket detected.",PATT_R_BR);     
                    return R_BR; }
(\+\+)          {inc_ops=process_pattern(inc_ops,"Increment operation detected.",PATT_INCREMENT); 
                    return INCREMENT; }
\&              {ampr=process_pattern(ampr,"New example.",PATT_AMPR);
                    return AMPR; }
[ \t]+          { /* Ignore whitespace */ }
^\n             {void_lines_done++; print_msg("Void line detected.\n");}       
\n              {lines_done++; print_msg("Line detected.\n");
                    return LINE_END; }
.               {errors_detected=process_pattern(errors_detected,"An error detected.\n",PATT_ERR); /* Ignore all other characters */ }
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
        //exit(ERR_PATTERN);
    }    

    print_msg(Message);
    
    number++;
    return number;
}
