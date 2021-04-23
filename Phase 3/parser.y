%{
  #include <stdio.h>
%}

%start program

%token KEYWORD
%token IDENTIFIER
%token INTEGER_LITERAL
%token FLOATING_POINT_LITERAL
%token STRING_LITERAL
%token ARITHMETIC_OPERATOR
%token COMPARISON_OPERATOR
%token LOGICAL_OPERATOR
%token ASSIGNMENT_OPERATOR
%token OPEN_BRACE
%token CLOSE_BRACE
%token OPEN_PARE
%token CLOSE_PARE
%token SEMI

%nonassoc "else"

%right '+'
%right '-'
%right '*'
%right '/'
%right '%'

%right '='

%left "&&"
%left "||"
%left '!'

%left '<'
%left '>'
%left "<="
%left ">="
%left "=="
%left "!="