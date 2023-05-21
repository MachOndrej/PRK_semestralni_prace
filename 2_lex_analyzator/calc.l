%{
/* Variable declaration */
int BOOL=0;
int INT=0;
int FLOAT=0;

#include <stdio.h>
#include <stdlib.h>
#include "ll.h"


%}

%%
[0-9]+\.[0-9]+                      printf("float ");
[1-9][0-9]*                         printf("int ");
T|F                                 printf("bool ");
\+                                  printf("add ");
\*                                  printf("mpy ");
\(                                  printf("Lbracket ");
\)                                  printf("Rbracket ");
"++"                                printf("inc ");
\&                                  printf("& ");
[ \t\n]                             { /* Ignore whitespace */ }
.                                   { /* Ignore all other characters */ }
%%




