%option noyywrap

%{
  int yylineno = 1;
%}

LETTER [a-zA-Z]
DIGIT [0-9]

RESERVED_KEYWORD if|else|while|continue|break|int|double|bool|string|true|false
RESERVED_IDENTIFIER exit|print|println|toString|readInt|readDouble|readLine

%%

{RESERVED_KEYWORD}|{RESERVED_IDENTIFIER} { return KEYWORD; }

({LETTER}|_)({LETTER}|{DIGIT}|_)* { return IDENTIFIER; }

{DIGIT}+ { return INTEGER_LITERAL; }

{DIGIT}+"."{DIGIT}+ { return FLOATING_POINT_LITERAL; }

\".*\" { return STRING_LITERAL; }

"+"|"-"|"*"|"/"|"%" { return ARITHMETIC_OPERATOR; }

"=="|"!="|"<"|">"|"<="|">=" { return COMPARISON_OPERATOR; }

"!"|"&&"|"||" { return LOGICAL_OPERATOR; }

"=" { return ASSIGNMENT_OPERATOR; }

"{" { return OPEN_BRACE; }

"}" { return CLOSE_BRACE; }

"(" { return OPEN_PARE; }

")" { return CLOSE_PARE; }

";" { return SEMI; }

\n { yylineno = yylineno + 1; }

.

%%
