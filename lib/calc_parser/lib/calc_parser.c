// Bare bones scanner and parser for the following LL(1) grammar:
// expr -> term { [+-] term }     ; An expression is terms separated by add ops.
// term -> factor { [*/] factor } ; A term is factors separated by mul ops.
// factor -> unsigned_factor      ; A signed factor is a factor,
//         | - unsigned_factor    ;   possibly with leading minus sign
// unsigned_factor -> ( expr )    ; An unsigned factor is a parenthesized expression
//         | NUMBER               ;   or a number
//
// The parser returns the floating point value of the expression.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>
#include <math.h>

typedef enum _LookAheadTokens {
        PRED_OP0 = 2,
        PRED_OP1,
        LPAREN,
        RPAREN,
        NUM,
        PI,
        ANS,
        END
}LookAheadTK;

/* Global Variables */
#define pi \
        3.1415926535897932381626433832795028841971693993751058209749445923078164062862089986280348253421170679
double result = 0;
const char *errMsg;
static LookAheadTK look_ahead_tk; // last_tk;
static double value, Ans = 0, fracMult;
static char *expr_ptr, *last_point;

/* Function Prototypes */
static inline double unsigned_factor(void);
static inline double factor(void);
static inline double term(void);
static inline double expr(void);
static inline LookAheadTK scan(void);
static inline bool eval_sign(void); /* unimplemented */
static inline LookAheadTK scan(void);
static inline void advance(void);


static inline void advance(void) {
        //last_tk = look_ahead_tk;
        look_ahead_tk = scan();
}

static inline LookAheadTK scan(void) {
        if(errMsg) return EXIT_FAILURE;
        switch (*expr_ptr) {
                case '-': case '+':
                        last_point = expr_ptr++;
                        return PRED_OP0;
                case '*': case '/':
                        last_point = expr_ptr++;
                        return PRED_OP1;
                case 'm':
                        last_point = expr_ptr;
                        expr_ptr += 3;
                        return PRED_OP1;
                case 'A':
                        last_point = expr_ptr;
                        expr_ptr += 3;
                        return ANS;
                case '(':
                        last_point = expr_ptr++;
                        return LPAREN;
                case ')':
                        last_point = expr_ptr++;
                        return RPAREN;
                case '0': case '1': case '2': case '3': case '4':
                case '5': case '6': case '7': case '8': case '9':
                        last_point = expr_ptr;
                        value = strtod(expr_ptr, &expr_ptr);
                        return NUM;
                case (char)0xCF :
                        last_point = expr_ptr;
                        expr_ptr += 2;
                        return PI;
                case '\0':
                        return END;
                default:
                        errMsg = "Bad Character Encountered!!";
                        return EXIT_FAILURE;
        }
}

double unsigned_factor(void) {

        if(errMsg) return EXIT_FAILURE;
        double rtn = 0;
        switch (look_ahead_tk) {
                case NUM:
                        rtn = value;
                        break;
                case ANS:
                        rtn = Ans;
                        break;
                case PI:
                        rtn = pi;
                        break;
                case LPAREN:
                        advance();
                        rtn = expr();
                        if (look_ahead_tk != RPAREN) {
                                errMsg = "Missing ')'!!";
                                return EXIT_FAILURE;
                        }
                        break;
                default:
                        errMsg = "Unexpected Token Encountered!!";
                        return EXIT_FAILURE;
        }

        if(*expr_ptr == '^') {
                expr_ptr++;
                if(*expr_ptr >= '0' && *expr_ptr <= '9') {
                        value = strtod(expr_ptr, &expr_ptr);
                        rtn = pow(rtn, value);
                } else {
                        errMsg = "Exponential must be integral!!";
                        return EXIT_FAILURE;
                }
        }
        advance();
        return rtn;
}

double factor(void) {
        if(errMsg) return EXIT_FAILURE;
        double rtn = 0;
                if (look_ahead_tk == PRED_OP0 && *last_point == '-') {
                        advance();
                        rtn = -unsigned_factor();
                }
                else rtn = unsigned_factor();
        return rtn;
}

double term(void) {
        if(errMsg) return EXIT_FAILURE;
        double rtn = factor();
        while (look_ahead_tk == PRED_OP1) {
                switch(*last_point) {
                        case '*':
                        advance();
                        rtn *= factor();
                        break;
                case '/':
                        advance();
                        rtn /= factor();
                        break;
                case 'm':
                        look_ahead_tk = scan();
                        int a = (int)result;
                        if(result != a) {
                                errMsg = "Left operand must be integral!!";
                                return EXIT_FAILURE;
                        }
                        result = factor();
                        int b = (int)result;
                        if(result != b) {
                                errMsg = "Right operand must be integral!!";
                                return EXIT_FAILURE;
                        }
                        result = (double)(a % b);
                }
        }
        return rtn;
}

double expr(void) {
        if(errMsg) return EXIT_FAILURE;
        double rtn = term();
        while (look_ahead_tk == PRED_OP0) {
                switch(*last_point) {
                case '+':
                        advance();
                        rtn += term();
                        break;
                case '-':
                        advance();
                        rtn -= term();
                        break;
                }
        }
        return rtn;
}

void solve(const char *s) {
        errMsg = NULL;
        expr_ptr = (char *)s;
        advance();
        result = expr();
        if (look_ahead_tk != END && !errMsg) {
                errMsg = "End Of String Null Byte Missing!!";
                return;
        }
        if(!errMsg) Ans = result;
}
