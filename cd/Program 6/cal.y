%{
#include <stdio.h>

int yylex(void);
int yyerror(char *s);
%}

%define api.value.type {double}

%token NUM

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

Statement:
      E '\n' { printf("Answer: %g\n", $1); }
    ;

E:
      E '+' E { $$ = $1 + $3; }
    | E '-' E { $$ = $1 - $3; }
    | E '*' E { $$ = $1 * $3; }
    | E '/' E { $$ = $1 / $3; }
    | NUM
    ;

%%

int main()
{
    printf("Enter the expression:\n");
    yyparse();
    return 0;
}

int yyerror(char *s)
{
    printf("%s\n", s);
    return 0;
}
