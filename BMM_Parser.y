%{

#include <stdio.h>
#include <string.h>
int yylex();
void yyerror(char const *);
extern FILE *yyin,*yyout,*lexout;

%}

%union{
    int num;
    char *str;
}
%token LINE_NUMBER DATA_TYPE VARIABLE_DECLARATION COMMENT PRINT IF THEN NOT AND OR XOR FOR STEP NEXT GOTO GOSUB DATA DEF DIM SEMICOLON COMMA EQUAL_TO PLUS MINUS DIV MUL LEFT_BRAC RIGHT_BRAC GREATER_THAN LESS_THAN LESS_THAN_EQUAL GREATER_THAN_EQUAL COMPARE_NOT_EQUAL RETURN STOP FNX EXPONTIATION INTEGER_TYPE SINGLE_P_INT DOUBLE_P_INT LET TO INPUT STRING_TYPE END
%token <num> NUM
%token <str> STRING
%left PLUS MINUS
%left MUL DIV
%left LEFT_BRAC RIGHT_BRAC

%%

programs    : LINE_NUMBER program programs
            | LINE_NUMBER program
;

program :Comment                      
    | variable_declaration             
    | if_condition                    
    | for_loop   
    | NEXT INTEGER_TYPE                     
    | PRINT print_statement                 
    | DATA data_collection
    | user_defined_function
    | DIM specific_array
    | goto_statement
    | gosum_statement
    | INPUT input_statement
    | RETURN
    | STOP
    | END
;
Comment : COMMENT

variable_declaration : LET ident  
    |  LET ident EQUAL_TO expr       
    | LET ident EQUAL_TO STRING  
;

if_condition :IF BOOL THEN NUM
;

for_loop : FOR INTEGER_TYPE EQUAL_TO expr TO expr STEP expr                                                  
    | FOR INTEGER_TYPE EQUAL_TO expr TO expr                    
;

input_statement:input_statement COMMA specific_array
               |input_statement COMMA INTEGER_TYPE
               input_statement COMMA SINGLE_P_INT
               input_statement COMMA DOUBLE_P_INT
               input_statement COMMA STRING_TYPE
               |specific_array
               |INTEGER_TYPE
               |SINGLE_P_INT
               |DOUBLE_P_INT
               |STRING_TYPE
;
print_statement : expr
                | expr SEMICOLON 
                | expr COMMA 
                | expr SEMICOLON print_statement
                | expr COMMA print_statement                                 
;                    

data_collection:data_collection COMMA NUM
    |data_collection COMMA STRING
    |STRING
    |NUM
;
user_defined_function: DEF FNX EQUAL_TO expr
   |DEF FNX LEFT_BRAC ident RIGHT_BRAC EQUAL_TO expr

specific_array:  INTEGER_TYPE LEFT_BRAC NUM RIGHT_BRAC
   | INTEGER_TYPE LEFT_BRAC NUM COMMA NUM RIGHT_BRAC
   | INTEGER_TYPE LEFT_BRAC INTEGER_TYPE RIGHT_BRAC
   | INTEGER_TYPE LEFT_BRAC INTEGER_TYPE COMMA INTEGER_TYPE RIGHT_BRAC
;
goto_statement: GOTO NUM
gosum_statement: GOSUB NUM

BOOL : BOOL LESS_THAN BOOL              
    | BOOL GREATER_THAN BOOL            
    | BOOL EQUAL_TO BOOL           
    | BOOL COMPARE_NOT_EQUAL BOOL       
    | BOOL LESS_THAN_EQUAL BOOL         
    | BOOL GREATER_THAN_EQUAL BOOL      
    | expr
    | INTEGER_TYPE LEFT_BRAC INTEGER_TYPE RIGHT_BRAC
;

ident :INTEGER_TYPE                     
      |SINGLE_P_INT
      |DOUBLE_P_INT
      |STRING_TYPE
;

expr :LEFT_BRAC expr RIGHT_BRAC
    | expr EXPONTIATION expr 
    | MINUS expr        
    | expr MUL expr             
    | expr DIV expr 
    | expr PLUS expr            
    | expr MINUS expr                
    |expr EQUAL_TO expr
    | expr COMPARE_NOT_EQUAL expr
    | expr LESS_THAN expr
    | expr GREATER_THAN expr
    | expr LESS_THAN_EQUAL expr
    | expr GREATER_THAN_EQUAL expr
    |expr NOT expr
    |expr AND expr
    |expr OR expr
    |expr XOR expr
    | NUM     
    | STRING               
    | ident
;

%%

int main()
{
     yyin=fopen("CorrectSample.bmm","r");
    //yyin=fopen("IncorrectSample.bmm","r");
    yyout=fopen("BMM_Parser.txt","w");
    lexout=fopen("BMM_Scanner.txt","w");
    yyparse();
    return 0;
}

void yyerror(char const *s){
    printf("Syntax Error\n");
}
