%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "BMM_Parser.tab.h"
FILE *lexout;
%}

%%

^[1-9][0-9]*0           {fprintf (lexout,"LINE_NUMBER : %s\n",yytext); yylval.str=strdup(yytext); return LINE_NUMBER;}
"LET"                   {fprintf (lexout,"VARIABLE_DECARATION : LET\n"); return LET;}
REM(.*)?                {fprintf (lexout,"COMMENT : %s\n",yytext);  yylval.str=strdup(yytext); return COMMENT;}
[A-Z][0-9]?[%]?         {fprintf (lexout,"DATA_TYPE : %s\n",yytext); return INTEGER_TYPE;}
[A-Z][0-9]?[!]          {fprintf (lexout,"DATA_TYPE : %s\n",yytext); return SINGLE_P_INT;}
[A-Z][0-9]?[#]          {fprintf (lexout,"DATA_TYPE : %s\n",yytext); return DOUBLE_P_INT;}
[A-Z][0-9]?[$]          {fprintf (lexout,"DATA_TYPE: %s\n",yytext); return STRING_TYPE;}
"PRINT"                 {fprintf (lexout,"PRINT_STATEMENT : PRINT\n"); return PRINT;}
"IF"                    {fprintf (lexout,"IF : IF\n"); return IF;}
"THEN"                  {fprintf (lexout,"THEN : THEN\n"); return THEN;}
"NOT"                   {fprintf (lexout,"NOT : NOT\n"); return NOT;}
"AND"                   {fprintf (lexout,"AND : AND\n"); return AND;}
"OR"                    {fprintf (lexout,"OR : OR\n"); return OR;}
"XOR"                   {fprintf (lexout,"XOR : XOR\n"); return XOR;}
"FOR"                   {fprintf (lexout,"FOR : FOR\n"); return FOR;}
"TO"                    {fprintf (lexout,"TO : TO\n"); return TO;}
"STEP"                  {fprintf (lexout,"STEP : STEP\n"); return STEP;}
"NEXT"                  {fprintf (lexout,"NEXT : NEXT\n"); return NEXT;}
"GOTO"                  {fprintf (lexout,"GOTO : GOTO\n"); return GOTO;}
"GOSUB"                 {fprintf (lexout,"GOSUB : GOSUB\n"); return GOSUB;}
"DATA"                  {fprintf (lexout,"DATA : DATA\n"); return DATA;}
"DEF"                   {fprintf (lexout,"DEF : DEF\n"); return DEF;}
"DIM"                   {fprintf (lexout,"DIM : DIM\n"); return DIM;}
"INPUT"                 {fprintf (lexout,"INPUT : INPUT\n"); return INPUT;}
";"                     {fprintf (lexout,"SEMICOLON : ;\n"); return SEMICOLON;}
","                     {fprintf (lexout,"COMMA : ,\n"); return COMMA;}
"="                     {fprintf (lexout,"EQUAL_TO : =\n"); return EQUAL_TO;}
"+"                     {fprintf (lexout,"PLUS : +\n"); return PLUS;}
"-"                     {fprintf (lexout,"MINUS : -\n"); return MINUS;}
"^"                     {fprintf (lexout,"EXPONTIATION : ^\n"); return EXPONTIATION;}
"/"                     {fprintf (lexout,"DIV : /\n"); return DIV;}
"*"                     {fprintf (lexout,"MUL : *\n"); return MUL;}
\(                     {fprintf (lexout,"LEFT_BRAC : (\n"); return LEFT_BRAC;}
\)                     {fprintf (lexout,"RIGHT_BRAC : )\n"); return RIGHT_BRAC;}
">"                     {fprintf (lexout,"GREATER_THAN : >\n"); return GREATER_THAN;}
"<"                     {fprintf (lexout,"LESS_THAN : <\n"); return LESS_THAN;}
"<="                    {fprintf (lexout,"LESS_THAN_EQUAL : <=\n"); return LESS_THAN_EQUAL;}
">="                    {fprintf (lexout,"GREATER_THAN_EQUAL : >=\n"); return GREATER_THAN_EQUAL;}
"<>"                    {fprintf (lexout,"COMPARE_NOT_EQUAL : <>\n"); return COMPARE_NOT_EQUAL;}
\".*\"                  {fprintf (lexout, "TYPE : %s\n", yytext); yylval.str=strdup(yytext); return STRING;}
[0-9]*[\.]?[0-9]*       {fprintf (lexout,"NUM : %d\n", yylval.num=atoi(yytext)); return NUM;}
FN[A-Z]                  {fprintf (lexout,"FNX: FNX\n"); return FNX;}
"RETURN"                {fprintf (lexout,"RETURN : RETURN\n"); return RETURN;}
"STOP"                  {fprintf (lexout,"STOP : STOP\n"); return STOP;}
"END"                  {fprintf (lexout,"END : END\n"); return END;}
[ \t]                    ;
\n                       ;
.                        {printf("Unexpected Token Found: %s\n", yytext);}
%%
int yywrap(){
    return 1;
}
