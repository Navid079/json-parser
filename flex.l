%{
    #include <stdio.h>
    #include <stdlib.h>

    #include "parser.tab.h"
%}

%option noyywrap

OPEN_CUR \{
CLOS_CUR \}
OPEN_BRA \[
CLOS_BRA \]

WHITESPACE [ \t\r\n]
STRING \"([^\\"]|[\\]([\\bnrtf/"]|u[0-9a-fA-F]{4}))*\"
NUMBER [+-]?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][+-]?[0-9]+)?
COMMA ,
COLON :
TRUE true
FALSE false
NULL_VALUE null

%%

{OPEN_CUR} { return t_oc; }
{CLOS_CUR} { return t_cc; }
{OPEN_BRA} { return t_ob; }
{CLOS_BRA} { return t_cb; }

{STRING} { return t_str; }
{NUMBER} { return t_num; }
{COMMA} { return t_com; }
{COLON} { return t_col; }
{TRUE} { return t_tru; }
{FALSE} { return t_fal; }
{NULL_VALUE} { return t_nul; }

{WHITESPACE} ;

. { printf("Invalid character: %s\n", yytext); }

%%
