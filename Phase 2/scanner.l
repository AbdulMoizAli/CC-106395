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

LETTER [a-zA-Z]
DIGIT [0-9]

RESERVED_KEYWORD if|else|while|continue|break|int|double|bool|string|true|false
RESERVED_IDENTIFIER exit|print|println|toString|readInt|readDouble|readLine

%%

{RESERVED_KEYWORD}|{RESERVED_IDENTIFIER} write_token_to_file(KEYWORD);

({LETTER}|_)({LETTER}|{DIGIT}|_)* write_token_to_file(IDENTIFIER);

{DIGIT}+ write_token_to_file(INTEGER_LITERAL);

{DIGIT}+"."{DIGIT}+ write_token_to_file(FLOATING_POINT_LITERAL);

\".*\" write_token_to_file(STRING_LITERAL);

"+"|"-"|"*"|"/"|"%" write_token_to_file(ARITHMETIC_OPERATOR);

"=="|"!="|"<"|">"|"<="|">=" write_token_to_file(COMPARISON_OPERATOR);

%%

void main()
{	
	yylex();
}