%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%option noyywrap

OPEN-CUR \{
CLOS-CUR \}
OPEN-BRA \[
CLOS-BRA \]

WHITESPACE [ \t\r\n]
STRING \"([^\\"]|[\\]([\\bnrtf/"]|u[0-9a-fA-F]{4}))*\"
NUMBER [+-]?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][+-]?[0-9]+)?
COMMA ,
COLON :
TRUE true
FALSE false
NULL-VALUE null

%%

{OPEN-CUR} { printf("<token, {>\n"); }
{CLOS-CUR} { printf("<token, }>\n"); }
{OPEN-BRA} { printf("<token, [>\n"); }
{CLOS-BRA} { printf("<token, ]>\n"); }

{STRING} { printf("<token, %s>\n", yytext); }
{NUMBER} { printf("<token, %s>\n", yytext); }
{COMMA} { printf("<token, %s>\n", yytext); }
{COLON} { printf("<token, %s>\n", yytext); }
{TRUE} { printf("<token, %s>\n", yytext); }
{FALSE} { printf("<token, %s>\n", yytext); }
{NULL-VALUE} { printf("<token, %s>\n", yytext); }

{WHITESPACE} ;
%%

int main() {
    yylex();
    return 0;
}