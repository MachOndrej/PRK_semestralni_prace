//#define VERBOSE 1
#undef VERBOSE

/* Define constants for patterns - used in process_pattern function */

#define PATT_NO 0 /* No pattern will be sent to parser */
#define PATT_NONZERO_INT 1 /* Non zero digit detected */
#define PATT_ZERO 2 /* Zero digit detected */
#define PATT_INT 3 /* Integer detected */
#define PATT_BOOL 4 /* Boolean detected */

#define PATT_PLUS 5 /* Plus operator */
#define PATT_MPY 6  /* Multiplication operator */
#define PATT_L_BR 7 /* Left bracket */
#define PATT_R_BR 8 /* Close bracket */
#define PATT_INCREMENT 9 /* Increment operator */
#define PATT_DOT 10 /* Dot detected */
#define PATT_AMPR 11 /* Next expression */

#define PATT_ERR 100 /* Error in patterns: exit on errors! */


#define ERR_PATTERN 1 /* Lexer: an error pattern detected. */

char *ErrMsgMain = "Error detected with code:";

char Err_Messages[][255] = {"No Error","Lexer: Wrong character detected. Exiting."};

