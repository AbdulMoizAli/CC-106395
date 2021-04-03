%option noyywrap

%{
    #include <unistd.h>
    #include <stdbool.h>

    void write_token_to_file(int token_class);
    bool validate_file_path(char *path);
    void main(int argc, char **argv);

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

"!"|"&&"|"||" write_token_to_file(LOGICAL_OPERATOR);

"=" write_token_to_file(ASSIGNMENT_OPERATOR);

"{" write_token_to_file(OPEN_BRACE);

"}" write_token_to_file(CLOSE_BRACE);

"(" write_token_to_file(OPEN_PARE);

")" write_token_to_file(CLOSE_PARE);

";" write_token_to_file(SEMI);

.|\n

%%

void write_token_to_file(int token_class)
{
    char str[1];
    sprintf(str, "%d", token_class);

    fputs("<", yyout);
    fputs(str, yyout);
    fputs(", ", yyout);
    fputs(yytext, yyout);
    fputs(">\n", yyout);
}

bool validate_file_path(char *path)
{
    if (access(path, F_OK) != 0)
        return false;

    return true;
}

void main(int argc, char **argv)
{
    ++argv, --argc;

    if (argc < 1)
        yyin = stdin;
    else if (argc > 1)
    {
        printf("takes only 1 argument :: path to an input text file");
        return;
    }
    else
    {
        char *file_path = argv[0];

        if (!validate_file_path(file_path))
        {
            printf("Cannot find path '%s' because it does not exist.", file_path);
            return;
        }

        yyin = fopen(file_path, "r");
    }

    yyout = fopen("./TokenStream.txt", "w");

    yylex();

    fclose(yyin);
    fclose(yyout);
}
