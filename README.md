antlr4-PacMan
=============

PacMan map parser coded in antlr

To run the program :

- download and set up Antlr 4.1
- run the following commands

Part 1:
	antlr4 csce322a1p1.g
	javac csce322a1p1*.java
	java csce322a1p1d .\PATH\file.pac

Part 2: 
	antlr4 csce322a1p2.g
	javac csce322a1p2*.java
	java csce322a1p2d .\PATH\file.pac

Assumptions:

Part 1 is a pure lexer and part 2 is a pure parser. Part 1 has all the tokens in it, while part 2 contains all the rules that utilize those tokens.

I don't know if the version of antlr matters a ton, but I used 4.1.

Outside resources:

I used mainly antlr.org and a few friends as my resources:
- http://www.antlr.org/wiki/display/ANTLR4/Getting+Started+with+ANTLR+v4
- http://www.antlr.org/wiki/display/ANTLR4/Grammar+Structure
- http://www.antlr.org/wiki/display/ANTLR4/Lexer+Rules
