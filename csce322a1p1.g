lexer grammar csce322a1p1;

BEGIN_SECTION : '<-';
END_SECTION : '->';

LEVEL : 'Level';
SCORE : 'Score';
MAP : 'Map';
LIVES : 'Lives';

WALL : 'W';
FOOD : 'F';
POWER : 'P';
EMPTY : '_';
BORDER : 'B';
GHOST : 'G';
PACMAN : 'M';

ASSIGNMENT : '=';
QUOTES : '"';
NUMBER : ('0'..'9')+;
ROW_SEPARATOR : ',';
MAP_TERMINATOR : ';';
WHITESPACE : [ \t\r\n]+ -> skip;
