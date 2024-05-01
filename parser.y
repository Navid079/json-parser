%{
    #include <stdio.h>
    #include <stdlib.h>

    void yyerror (char*);
    int yylex();
    extern FILE* yyin;
    extern int yylineno;
%}

%token t_oc         // {
%token t_cc         // }
%token t_ob         // [
%token t_cb         // ]
%token t_str        // "sdasd"
%token t_num        // -12.4E-1
%token t_com        // ,
%token t_col        // :
%token t_tru        // true
%token t_fal        // false
%token t_nul        // null

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
    array { printf("An array!\n"); }
    ;

object:
    t_oc keyvalues t_cc
    ;

keyvalues:
    nonempty_keyvalues |
    %empty
    ;

nonempty_keyvalues:
    nonempty_keyvalues t_com keyvalue |
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

void yyerror (char* msg) {
    printf("%s in line %d\n", msg, yylineno);
}

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
