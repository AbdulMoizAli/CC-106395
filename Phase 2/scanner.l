%option noyywrap

%{
    #define KEYWORD 1

    #define IDENTIFIER 2

    #define INTEGER_LITERAL 3
    #define FLOATING_POINT_LITERAL 4
    #define STRING_LITERAL 5

    #define ARITHMETIC_OPERATOR 6
    #define COMPARISON_OPERATOR 7
    #define LOGICAL_OPERATOR 8
    #define ASSIGNMENT_OPERATOR 9

    #define OPEN_BRACE 10
    #define CLOSE_BRACE 11
    #define OPEN_PARE 12
    #define CLOSE_PARE 13

    #define SEMI 14
%}

%%
%%

void main()
{	
	yylex();
}