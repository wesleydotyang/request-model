%{

#import <Foundation/NSData.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSString.h>
#include "ParserHeader.h"



#define YYDEBUG 1

    #ifndef  DEBUG_BISON
    #define NSLog(...)
    #define printf(...)
    #endif

extern void ERROR(const char* str);    
extern void yyerror(const char *);
extern int yylex(), yyparse();
extern void _VSetDataToScan(const char *someData);
extern void _VRegisterTypeName(const char *aTypeName);
extern BOOL _VIsKnownTypeName();
extern char _VCurrentIdentifier[512];

%}

%output  "Json2ObjcParser.mm"
%defines "Json2ObjcParser.h"


%union
{
    int          ival;
    NSString     *sval;
    id data;
};


%token <sval> IDENTIFIER
%token <sval> CONSTANT
%token <sval> STRING_LITERAL
%token <sval> TYPE_NAME

%token SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN

%token TYPEDEF EXTERN STATIC AUTO REGISTER
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID SBOOL SYES SNO
%token STRUCT UNION ENUM ELLIPSIS
//new
%token REQUEST RESPONSE  URL  HEADER POST GET

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN


%token INTERFACE IMPLEMENTATION PROTOCOL END
%token CLASS PRIVATE PUBLIC PROTECTED PROPERTY REQUIRED OPTIONAL ENCODE SELECTOR
%token SYNTHESIZE DYNAMIC

%type <sval>    type request_name var_name sys_type class_name
%type <data>    link_list link assignment_exp declare_exp type_specifier 
%type <data>    value_list value 
%type <data>    request request_head_list request_head request_body response_body response service service_list


//%destructor { } <character>
//%destructor {printf ("Discarding type symbol.\n"); free ($$); } <*>
//%destructor {NSLog(@"discarding string %@",$$); [$$ release];  } CONSTANT STRING_LITERAL TYPE_NAME IDENTIFIER
//%destructor { printf ("Discarding tagless symbol.\n"); } <>

%start translation_unit

%%

translation_unit
: service_list  {[ParseResult setCurrentParseResult:$1];}
| error {yyerror("Parse input failed. please check grammar.");}
;


service_list
: service               {$$=[NSMutableArray arrayWithObject:$1];}
| service_list service  {[(NSMutableArray*)$1 addObject:$2];$$=$1;}
;

service
//: request response  {$$=[JOService serviceWithRequest:$1 response:$2];}
: request  {$$=[JOService serviceWithRequest:$1 response:nil];}
//| error response{ERROR("request not found or error");}
;

request
: REQUEST request_head_list request_body
{$$=[JORequest requestWithHeads:$2 body:$3];}
| REQUEST request_body
{$$=[JORequest requestWithHeads:nil body:$2];}
| request_body
{$$=[JORequest requestWithHeads:nil body:$1];}
;

request_head_list
:  request_head                     
    {$$=[NSMutableArray arrayWithObject:$1];}
|  request_head_list request_head
    {[(NSMutableArray*)$1 addObject:$2];$$=$1;}
;

request_head
:  HEADER              
 {$$=[JORequestHeader requestHeaderWithType:JOREQUEST_HEADER_HEADER value:nil];}
 
|  HEADER STRING_LITERAL 
{$$=[JORequestHeader requestHeaderWithType:JOREQUEST_HEADER_HEADER value:$2];}

|  URL  STRING_LITERAL  
{$$=[JORequestHeader requestHeaderWithType:JOREQUEST_HEADER_URL value:$2];}


| POST
{$$=[JORequestHeader requestHeaderWithType:JOREQUEST_HEADER_POST value:nil];}

| GET
{$$=[JORequestHeader requestHeaderWithType:JOREQUEST_HEADER_GET value:nil];}

;

request_body
:  class_name value 
{$$=[JORequestBody requestBodyWithName:$1 value:$2];}
|  value 
{$$=[JORequestBody requestBodyWithName:nil value:$1];}
;

response
: RESPONSE response_body
{$$=[JOResponse responseWithBody:$2];}
;

response_body
:  class_name value
{$$=[JOResponseBody responseBodyWithName:$1 value:$2];}
|  value
{$$=[JOResponseBody responseBodyWithName:nil value:$1];}
;

link_list
: link              {$$=[NSMutableArray arrayWithObject:$1];}
| link_list sentence_separator link {[(NSMutableArray*)$1 addObject:$3];$$=$1;}

;


link
: request_name ':' assignment_exp   {$$=[JOLink linkWithName:$1 assignment:$3]; }
| request_name ':'  {$$=[JOLink linkWithName:$1 assignment:nil]; }
| request_name      {$$=[JOLink linkWithName:$1 assignment:nil]; }
;


assignment_exp
: declare_exp value { $$=[JOAssignmentExp assignmentExpWithDeclareExp:$1 value:$2];}
| declare_exp   { $$=[JOAssignmentExp assignmentExpWithDeclareExp:$1 value:nil];}
| value { $$=[JOAssignmentExp assignmentExpWithDeclareExp:nil value:$1];}
;

declare_exp
: type_specifier var_name {$$ = [JODeclareExp declareExpWithType:$1 varName:$2];}
| var_name      {$$ = [JODeclareExp declareExpWithType:nil varName:$1];}
;



type_specifier
: type                  {$$ = [JOTypeSpecifier typeWithName:$1 subName:nil];}
| type '<' type '>'     {$$ = [JOTypeSpecifier typeWithName:$1 subName:$3];}
|  '<' type '>'         {$$ = [JOTypeSpecifier typeWithName:nil subName:$2];}
;

type
: TYPE_NAME             {$$=$1;}
| IDENTIFIER            {$$=$1;}
| sys_type              {$$=$1;}
;


sys_type
: CHAR      {$$=@"char";}
| SHORT     {$$=@"short";}
| INT       {$$=@"int";}
| LONG      {$$=@"long";}
| FLOAT     {$$=@"float";}
| DOUBLE    {$$=@"double";}
| SBOOL     {$$=@"BOOL";}
;

value_list
: value         {$$=[NSMutableArray arrayWithObject:$1];}
| value_list sentence_separator value 
                {[(NSMutableArray*)$1 addObject:$3];$$=$1; }
;

value
: STRING_LITERAL        {$$= [JOValue valueWithType:JOVALUE_TYPE_STRING value:$1];}
| CONSTANT              {$$ = [JOValue valueWithType:JOVALUE_TYPE_STRING value:nil];}
| SYES                  {$$ = [JOValue valueWithBOOL:YES];}
| SNO                   {$$ = [JOValue valueWithBOOL:NO];}

| '[' value_list ']'    {$$= [JOValue valueWithType:JOVALUE_TYPE_ARRAY value:$2];}
| '['  ']'    {$$= [JOValue valueWithType:JOVALUE_TYPE_ARRAY value:nil];}

| '{' link_list '}'     {$$= [JOValue valueWithType:JOVALUE_TYPE_DICTIONARY value:$2];}
| '{'  '}'     {$$= [JOValue valueWithType:JOVALUE_TYPE_DICTIONARY value:nil];}

;


request_name
: STRING_LITERAL {$$=$1;  @1;}
| IDENTIFIER    {$$=$1;}
;

class_name
: IDENTIFIER    {$$=$1; }
;

var_name
: IDENTIFIER    {$$=$1; }
;



sentence_separator
: ','
| ';'
;


%%
#include <stdio.h>

extern char yytext[];
extern int column;

char _VCurrentIdentifier[512];

void yyerror(const char *s)
{
        fflush(stdout);
        printf("\nError at [line]%d [col]%d-%d %s\n",yylloc.first_line,yylloc.first_column,yylloc.last_column,s);
    NSString *errorStr = [NSString stringWithFormat:@"Error at line:%d col:%d,%s",yylloc.first_line,yylloc.first_column,s];
    [ParseResult appendErrorLog:errorStr];}

void ERROR(const char* str)
{
    printf(" [ERROR]%s\n", str);
}


BOOL ParsePreProcessedC(const char *someData)
{
  _VSetDataToScan(someData); /* sets up lex to scan the data */

  return yyparse();
}


static NSMutableDictionary *typeNameDictionary = nil;


void _VRegisterTypeName(const char *aTypeName)
{
  //fprintf(stderr, "-----------------> %@ <------------------\n",aTypeName);

  if(nil == typeNameDictionary) {
    typeNameDictionary = [[NSMutableDictionary alloc] init];
  }

  [typeNameDictionary setObject:[NSString stringWithCString:aTypeName]forKey:[NSString stringWithCString:aTypeName]];
}


BOOL _VIsKnownTypeName()
{
//    if(strncmp(aTypeName, "NS", 2)==0){
//        return YES;
//    }
    const char commonType[][32]={"AV","NS","UI","CA","CI","CL","CM","CT","CV","CF","CG","GL","MK","MP","SC","PK","OA","\0"};
    for(int i=0;commonType[i][0]!='\0';++i){
        if(strncmp(_VCurrentIdentifier,commonType[i],2)==0){
            if(strlen(_VCurrentIdentifier)>3){
                char c = _VCurrentIdentifier[2];
                if(c>='A'&&c<='Z')
                    return YES;

            }
        }
    }
    
    
  return (nil != [typeNameDictionary objectForKey:[NSString stringWithCString:_VCurrentIdentifier]]);
}
