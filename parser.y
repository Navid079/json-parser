%{
    #include <stdio.h>
    #include <stdlib.h>

    char* yyerror (char*);
    int yylex();
    extern FILE* yyin;
%}

%token t_oc
%token t_cc
%token t_ob
%token t_cb
%token t_str
%token t_num
%token t_com
%token t_col
%token t_tru
%token t_fal
%token t_nul

%start json

%%

json:
    value { printf("JSON PARSED!\n"); }
    |
    %empty { printf("JSON IS EMPTY!\n"); }
    ;

value:
    t_str |
    t_num |
    t_tru |
    t_fal |
    t_nul |
    object { printf("An object!\n"); } |
    array { printf("An Array!\n"); }
    ;

object:
    t_oc keyvalues t_cc
    ;

keyvalues:
    nonempty_keyvalues |
    %empty
    ;

nonempty_keyvalues:
    nonempty_keyvalues keyvalue t_com |
    keyvalue
    ;

keyvalue:
    t_str t_col value
    ;

array:
    t_ob values t_cb
    ;

values:
    nonempty_values |
    %empty
    ;

nonempty_values:
    nonempty_values t_com value |
    value
    ;

%%

char* yyerror (char* msg) {return msg;}

int main(int argc, char** argv) {
    if (argc != 2) {
        printf("Usage: %s filename\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Cannot open %s. Maybe file does not exist", argv[1]);
        return 1;
    }

    yyin = file;
    yyparse();

    return 0;
}
