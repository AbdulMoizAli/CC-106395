# Compiler Construction 106395 Spring 2021: Project Phase 3

## Project Members 👨 👩

|    ID     |      Name      |
| :-------: | :------------: |
| **63153** | **Abdul Moiz** |
|   63130   |   Tahoor Ali   |

# Language ✔

**Mini-C**

# Project Description 🔰

A lexical Analyzer and Parser for the `Mini-C` programming language using `Flex(Fast Lexical Analyzer Generator)` and `Yacc(Yet Another Compiler-Compiler)`.

In this project we have implemented first two phases of a compiler i.e. Lexical Analyzer and Parser. Lexical Analyzer's job is to read a source program and generate a token stream which is then read by a parser to validate the sequence of tokens and report any syntax errors. We used `Flex` and `Yacc` to generate the Lexical Analyzer and Parser.

# Mini-C Language Specification 📃

Mini-C is a very simple C-like programming language designed for education purposes (for software that
can be used by students to learn about program compilation).

It has if statements, loops (while), variables, arithmetic (+, -, \*, /, %), comparison (==, !=, <, >, <=, >=),
logical (!, &&, ||) operators, string concatenation.

It does not have “main” function for entry point like in C or Java, all code on “top-level” (similarly to
Python, JavaScript) is executed as if it was inside of C/Java main.

Currently it does not support user-defined functions.

# Data Types 🌀

- int (signed 32-bit)
- double (double-precision 64-bit IEEE 754 floating point)
- bool
- string

# Built-in statements/expressions for input/output 🔁

- Print a string (to stdout)

```cs

void print(string s);
void println(string s);

```

- Read a number (from stdin)

```cs

int readInt();
double readDouble();

```

- Read a string with all characters until a line separator (from stdin)

```cs

string readLine();

```

- Convert a number or boolean to a string

```cs

string toString(int input);
string toString(double input);
string toString(bool input);

```

# Scopes 🌌

Nested scopes are supported for variables and work the same as in most of other languages like C, Java.
Blocks (curly braces, { … }) can be nested and variables defined in a scope are available only until the end
of the scope. Redeclaration of variables existing in parent (or current) scopes is not allowed

### Example: ⬇

```c

int a = 42;

if (a == 42) {
  int b = a + 1;
  print(toString(b)); // 43
}

{
  int b = a + 2;
  print(toString(b)); // 44
}

{
  int a = 41; // error
  print(toString(b + 1)); // error
}

int a = 40; // error

```

# Example Constructs Of The Language 🔰

```c

println("Hello world!");

print("Enter name: ");
string name = readLine();

print("Enter age: ");
int age = readInt();

if (age < 10) {
  println("Sorry, you are not old enough to learn about compilers");
  exit();
}

println("Hello " + name);

int n = 10;
int sum = 0;
int i = 1;
while (i <= n) {
  sum = sum + i;
  i = i + 1;
}
println("Sum of the first " + toString(n) +
 " natural numbers: " + toString(sum));

double pi = 3.141592;
int r = 5;
double area = pi * (r * r);
println("Area of a circle with radius " + toString(r) + ": " +
 toString(area));

int desiredCount = 20;
println("First " + toString(desiredCount) + " prime numbers:");
int num = 2;
int count = 0;
while (count < desiredCount) {
  bool isPrime = true;
  int j = 1;
  while (j < num / 2) {
    if (j != 1 && num % j == 0) {
      isPrime = false;
      break;
    } else
      j = j + 1;
  }
  if (isPrime) {
    print(toString(num));
    if (count < desiredCount - 1)
      print(toString(", "));
    count = count + 1;
  }
  num = num + 1;
}

```

# Lexical Specification and Language Grammar ℹ

Grammar description using EBNF.

- 'x' — terminal symbol.
- x? – zero or one occurrences of x.
- x\* – zero or more occurrences of x
- x+ – one or more occurrences of x.
- x | y – alternative (x or y).
- () – group, for example (x | y) z (x y)?

```cs

program = statement*

statement = block
          | SEMI
          | assignment
          | declaration
          | if
          | while
          | 'break' SEMI
          | 'continue' SEMI
          | 'exit' '(' ')' SEMI
          | 'print' parExpression SEMI
          | 'println' parExpression SEMI

block = '{' statement* '}'

expression = literal
           | ID
           | ('!' | '-') expression
           | expression ('*' | '/' | '%') expression
           | expression ('+' | '-') expression
           | expression ('<' | '>' | '<=' | '>=') expression
           | expression ('==' | '!=') expression
           | expression ('&&') expression
           | expression ('||') expression
           | parExpression
           | 'readInt' '(' ')'
           | 'readDouble' '(' ')'
           | 'readLine' '(' ')'
           | 'toString' parExpression

parExpression = '(' expression ')'

assignment = ID assignmentOp expression SEMI

declaration = type ID (assignmentOp expression)? SEMI

if = 'if' parExpression statement ('else' statement)?

while = 'while' parExpression statement

assignmentOp = '='

type = 'int'
     | 'double'
     | 'bool'
     | 'string'

literal = IntegerLiteral
        | FloatingPointLiteral
        | StringLiteral
        | BooleanLiteral

IntegerLiteral = DIGIT+
FloatingPointLiteral = DIGIT+ '.' DIGIT+
StringLiteral = '"' (CHAR | '\"')* '"'
BooleanLiteral = 'true' | 'false'

SEMI = ';'

ID = (LETTER | '_') (LETTER | DIGIT | '_')*

DIGIT = '0' | ... | '9'
LETTER = 'a' | ... | 'z' | 'A' | ... | 'Z'

CHAR = <unicode character, as in Java>

Whitespace characters (' ', '\t', '\r', '\n') are skipped outside of tokens.

```

# Approach 🅰

## Tasks

Creating a Lexical Analyzer was relatively easier than the Parser but, after reading a bunch of documentations and collaborative work, we did manage to get it done correctly.

## Working

Download and compile the `scanner.l` and `parser.y` file to create an executable, run the executable to parse the source code. There are two ways to provide source code to the executable, either from the standard input in the command line or from a text file. The executable would parse the source program and let user know if there are any parsing errors in the program.

### Compile (flex & yacc)

compiling the `scanner.l` and `parser.y` files would create a `lex.yy.c` and `parser.tab.c` files, you can provide `-o` flag to override the default output c file name.

```
>  flex scanner.l
   or
>  flex scanner.l -o <FILE NAME>

>  yacc parser.y
   or
>  yacc parser.y -o <FILE NAME>
```

### Compile (gcc)

Compile the c file generated by yacc, that would create the main executable named `a.exe` on windows and `a.out` on linux/mac, you can provide `-o` flag to override the default executable file name.

```
>  gcc parser.tab.c | <FILE NAME>.c
   or
>  gcc parser.tab.c -o <FILE NAME> | <FILE NAME>.c -o <FILE NAME>
```

### Run

The executable accepts zero or one argument, without any argument the program would parse source program from the standard input in the command line, or you can specify the path to an input text file as an argument.

##### Windows

```
>  a.exe | <FILE NAME>.exe
   or
>  a.exe <FILE PATH> | <FILE NAME>.exe <FILE PATH>
```

##### Linux/Mac

```
$  ./a.out | ./<FILE NAME>.out
   or
$  ./a.out <FILE PATH> | ./<FILE NAME>.out <FILE PATH>
```

# Problems Faced 🚩

## Interpreting the language grammar

It took quite a while to get our heads around the grammar of Mini-C language but, as we progressed through the course material, things started to make sense.

## Integrating the scanner with parser

It was hard finding an example on integration of flex with yacc program then we found a simple and straight forward example on the [course website](http://compilersatkiet.22web.org/).

## Eliminating grammar conflicts in parser

We faced significant number of grammar conflicts in our initial implementation of parser because there are situations where the grammar is clear without fuzzy rules but Yacc cannot handle it because by default it generates LALR(1) parsers with limited look-ahead ability.

We resolved some of the Shift/Reduce conflicts by specifying the associativity property of different operators in the Yacc program. Remaining conflicts were eliminated by using always opening and closing curly braces around statements and using different precedence rules to associate “else” with the nearest “if”.

# References 🖇

> [Flex Manual](http://manpages.ubuntu.com/manpages/trusty/man1/flex.1.html)

> [Yacc Manual](http://manpages.ubuntu.com/manpages/trusty/man1/yacc.1plan9.html)

> [Using Flex with Yacc](https://www.oreilly.com/library/view/flex-bison/9780596805418/ch01.html)

> [Yacc Rules Syntax](https://www.gnu.org/software/bison/manual/html_node/Rules-Syntax.html)

> [Shift/Reduce Conflicts in Yacc](https://www.gnu.org/software/bison/manual/html_node/Shift_002fReduce.html)

> [Techniques for resolving common grammar conflicts in parsers.](https://efxa.org/2014/05/17/techniques-for-resolving-common-grammar-conflicts-in-parsers/)

# Demo 🎥

https://user-images.githubusercontent.com/59338587/115956232-17f8a700-a515-11eb-87bd-59fc6ccbd556.mp4
