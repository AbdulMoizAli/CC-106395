# Compiler Construction 106395 Spring 2021: Project Phase 1

## Project Members 👨 👩

| ID             | Name            |
|:--------------:|:---------------:|
|  **63153**     |  **Abdul Moiz** |
|  63130         |  Tahoor Ali     |

# Language Selected ✔

**Mini-C**

# Mini-C Language Specification 📃

Mini-C is a very simple C-like programming language designed for education purposes (for software that
can be used by students to learn about program compilation).

It has if statements, loops (while), variables, arithmetic (+, -, *, /, %), comparison (==, !=, <, >, <=, >=),
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
- x* – zero or more occurrences of x
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
