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

%%

program:
  /* epsilon */
| statement program
;

statement:
  block
| SEMI
| assignment
| declaration
| if
| while
| "break" SEMI
| "continue" SEMI
| "exit" OPEN_PARE CLOSE_PARE SEMI
| "print" parExpression SEMI
| "println" parExpression SEMI
;

block:
  OPEN_BRACE program CLOSE_BRACE
;

expression:
  literal
| IDENTIFIER
| '!' expression
| '-' expression
| expression '+' expression
| expression '-' expression
| expression '*' expression
| expression '/' expression
| expression '%' expression
| expression '<' expression
| expression '>' expression
| expression "<=" expression
| expression ">=" expression
| expression "==" expression
| expression "!=" expression
| expression "&&" expression
| expression "||" expression
| parExpression
| "readInt" OPEN_PARE CLOSE_PARE
| "readDouble" OPEN_PARE CLOSE_PARE
| "readLine" OPEN_PARE CLOSE_PARE
| "toString" parExpression
;

parExpression:
  OPEN_PARE expression CLOSE_PARE
;

assignment:
  IDENTIFIER ASSIGNMENT_OPERATOR expression SEMI
;

declarationOne:
  /* epsilon */
| ASSIGNMENT_OPERATOR expression
;

declaration:
  type IDENTIFIER declarationOne SEMI
;

ifOne:
  /* epsilon */
| "else" statement
;

if:
  "if" parExpression statement ifOne
;

while:
  "while" parExpression statement
;

type:
  "int"
| "double"
| "bool"
| "string"
;

booleanLiteral:
  "true"
| "false"
;

literal:
  INTEGER_LITERAL
| FLOATING_POINT_LITERAL
| STRING_LITERAL
| booleanLiteral
;

%%
