flex flex.l
bison -d parser.y
gcc lex.yy.c parser.tab.c
echo "Compiled successfully"