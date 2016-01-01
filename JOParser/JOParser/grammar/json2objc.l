%{

#include "ParserHeader.h"
#include "Json2ObjcParser.h"

//#include <malloc.h>

    #ifndef  DEBUG_BISON
    #define NSLog(...)
    #define printf(...)
    #endif
    

extern char _VCurrentIdentifier[512];
void comment();
void linecomment();
void preCompiler();
void keyword();
int check_type();
void _VSetDataToScan(const char *someData);
extern BOOL _VIsKnownTypeName();

static const char * _VCurrentDataBytes = NULL;
static NSData *_VCurrentData = nil;
static int _VCurrentDataBytesIndex = 0;

#ifdef _WIN32

/* Windows doesn't define the isatty() function.
   As we always read from a file, we can easily
   provide the following simple implementation: */

int isatty (int fd)
{
    return 0;
}
#endif

%}

%option outfile="Json2ObjcLexer.mm" header-file="Json2ObjcLexer.h"


D                       [0-9]
L                       [a-zA-Z_]
H                       [a-fA-F0-9]
E                       [Ee][+-]?{D}+
FS                      (f|F|l|L)
IS                      (u|U|l|L)*
%{
#include <stdio.h>
#include "Json2ObjcParser.h"

void count();
%}

%%
"/*"                    { comment(); }
"//"                    { linecomment(); }
"#"                     { preCompiler();}

"@request"            { count();keyword(); return(REQUEST);}
"@REQUEST"            { count();keyword(); return(REQUEST);}

"@response"            { count();keyword(); return(RESPONSE);}
"@RESPONSE"            { count();keyword(); return(RESPONSE);}

"@url"            { count();keyword(); return(URL);}
"@URL"            { count();keyword(); return(URL);}

"@head"            { count();keyword(); return(HEADER);}
"@HEAD"            { count();keyword(); return(HEADER);}
"@header"            { count();keyword(); return(HEADER);}
"@HEADER"            { count();keyword(); return(HEADER);}

"@post"            { count();keyword(); return(POST);}
"@get"            { count();keyword(); return(GET);}
"@POST"            { count();keyword(); return(POST);}
"@GET"            { count();keyword(); return(GET);}

"@return"                { count();keyword(); return(RETURN); }


"@interface"            { count();keyword(); return(INTERFACE);}
"@implementation"         { count();keyword(); return(IMPLEMENTATION);}
"@protocol"             { count();keyword(); return(PROTOCOL);}
"@end"            { count();keyword(); return(END);}
"@class"            { count();keyword(); return(CLASS);}
"@private"            { count();keyword(); return(PRIVATE);}
"@public"            { count();keyword(); return(PUBLIC);}
"@protected"            { count();keyword(); return(PROTECTED);}

"@property"              { count();keyword(); return(PROPERTY);}
"@required"              { count();keyword(); return(REQUIRED);}
"@optional"              { count();keyword(); return(OPTIONAL);}

"@encode"               { count();keyword(); return(ENCODE);}
"@selector"             { count();keyword(); return(SELECTOR);}

"@synthesize"           { count();keyword();return(SYNTHESIZE);}
"@dynamic"              { count();keyword(); return(DYNAMIC);}

"auto"                  { count();keyword(); return(AUTO); }
"break"                 { count();keyword(); return(BREAK); }
"case"                  { count();keyword(); return(CASE); }
"char"                  { count();keyword(); return(CHAR); }
"const"                 { count();keyword(); return(CONST); }
"continue"              { count();keyword(); return(CONTINUE); }
"default"               { count();keyword(); return(DEFAULT); }
"do"                    { count();keyword(); return(DO); }
"double"                { count();keyword(); return(DOUBLE); }
"else"                  { count();keyword(); return(ELSE); }
"enum"                  { count();keyword(); return(ENUM); }
"extern"                { count();keyword(); return(EXTERN); }
"float"                 { count();keyword(); return(FLOAT); }
"for"                   { count();keyword(); return(FOR); }
"goto"                  { count();keyword(); return(GOTO); }
"if"                    { count();keyword(); return(IF); }
"int"                   { count();keyword(); return(INT); }
"long"                  { count();keyword(); return(LONG); }
"register"              { count();keyword(); return(REGISTER); }
"return"                { count();keyword(); return(RETURN); }
"short"                 { count();keyword(); return(SHORT); }
"signed"                { count();keyword(); return(SIGNED); }
"sizeof"                { count();keyword(); return(SIZEOF); }
"static"                { count();keyword(); return(STATIC); }
"struct"                { count();keyword(); return(STRUCT); }
"switch"                { count();keyword(); return(SWITCH); }
"typedef"               { count();keyword(); return(TYPEDEF); }
"union"                 { count();keyword(); return(UNION); }
"unsigned"              { count();keyword(); return(UNSIGNED); }
"void"                  { count();keyword(); return(VOID); }
"volatile"              { count();keyword(); return(VOLATILE); }
"while"                 { count();keyword(); return(WHILE); }

"bool"                  { count();keyword(); return(SBOOL); }
"BOOL"                  { count();keyword(); return(SBOOL); }
"boolean"               { count();keyword(); return(SBOOL); }
"yes"                   { count();keyword(); return(SYES); }
"true"                  { count();keyword(); return(SYES); }
"YES"                   { count();keyword(); return(SYES); }
"TRUE"                  { count();keyword(); return(SYES); }
"NO"                    { count();keyword(); return(SNO); }
"no"                    { count();keyword(); return(SNO); }
"false"                 { count();keyword(); return(SNO); }
"FALSE"                 { count();keyword(); return(SNO); }

{L}({L}|{D})*           { count(); return(check_type()); }

0[xX]{H}+{IS}?          { count(); return(CONSTANT); }
0{D}+{IS}?              { count(); return(CONSTANT); }
{D}+{IS}?               { count(); return(CONSTANT); }

{D}+{E}{FS}?            { count(); return(CONSTANT); }
{D}*"."{D}+({E})?{FS}?  { count(); return(CONSTANT); }
{D}+"."{D}*({E})?{FS}?  { count(); return(CONSTANT); }

L?\"(\\.|[^\\"])*\"     { count(); return(STRING_LITERAL); }
@\"(\\.|[^\\"])*\"     { count(); return(STRING_LITERAL); }
L?\'(\\.|[^\\"])*\'     { count(); return(STRING_LITERAL); }
\'(\\.|[^\\"])*\'     { count(); return(STRING_LITERAL); }

"..."                   { count(); return(ELLIPSIS); }
">>="                   { count(); return(RIGHT_ASSIGN); }
"<<="                   { count(); return(LEFT_ASSIGN); }
"+="                    { count(); return(ADD_ASSIGN); }
"-="                    { count(); return(SUB_ASSIGN); }
"*="                    { count(); return(MUL_ASSIGN); }
"/="                    { count(); return(DIV_ASSIGN); }
"%="                    { count(); return(MOD_ASSIGN); }
"&="                    { count(); return(AND_ASSIGN); }
"^="                    { count(); return(XOR_ASSIGN); }
"|="                    { count(); return(OR_ASSIGN); }
">>"                    { count(); return(RIGHT_OP); }
"<<"                    { count(); return(LEFT_OP); }
"++"                    { count(); return(INC_OP); }
"--"                    { count(); return(DEC_OP); }
"->"                    { count(); return(PTR_OP); }
"&&"                    { count(); return(AND_OP); }
"||"                    { count(); return(OR_OP); }
"<="                    { count(); return(LE_OP); }
">="                    { count(); return(GE_OP); }
"=="                    { count(); return(EQ_OP); }
"!="                    { count(); return(NE_OP); }
";"                     { count(); return(';'); }
("{"|"<%")              { count(); return('{'); }
("}"|"%>")              { count(); return('}'); }
","                     { count(); return(','); }
":"                     { count(); return(':'); }
"="                     { count(); return('='); }
"("                     { count(); return('('); }
")"                     { count(); return(')'); }
("["|"<:")              { count(); return('['); }
("]"|":>")              { count(); return(']'); }
"."                     { count(); return('.'); }
"&"                     { count(); return('&'); }
"!"                     { count(); return('!'); }
"~"                     { count(); return('~'); }
"-"                     { count(); return('-'); }
"+"                     { count(); return('+'); }
"*"                     { count(); return('*'); }
"/"                     { count(); return('/'); }
"%"                     { count(); return('%'); }
"<"                     { count(); return('<'); }
">"                     { count(); return('>'); }
"^"                     { count(); return('^'); }
"|"                     { count(); return('|'); }
"?"                     { count(); return('?'); }

[ \t\v\n\f]             { count(); }
.                       { count();/* ignore bad characters */ }

%%
#define TAB_WORD 1
void keyword()
{
//    REC(RECTYPE_KEYWORD, @"",yylloc);

}

void comment()
{
    yylloc.first_line = yylloc.last_line;
    yylloc.first_column = yylloc.last_column;
    yylloc.last_column+=2;
    char c, c1;

loop:
    while ((c = yyinput()) != '*' && c != 0){
                putchar(c);
        if(c=='\n'){
            yylloc.last_column=0;
            yylloc.last_line++;
        } else if (c == '\t'){
            yylloc.last_column+=TAB_WORD-(yylloc.last_column%TAB_WORD);
            
        }else{
            yylloc.last_column++;

        }
    }
    yylloc.last_column++;

        if ((c1 = yyinput()) != '/' && c != 0)
        {
                unput(c1);
                goto loop;
        }

    if (c != 0){
            putchar(c1);
        yylloc.last_column+=1;

    }
    REC(RECTYPE_COMMENT,@"",yylloc);
//    printf("[CommentFromC:%d,%d Line:%d,%d]",yylloc.first_column,yylloc.last_column,yylloc.first_line,yylloc.last_line);
}

void linecomment()
{
    yylloc.first_line = yylloc.last_line;
    yylloc.first_column = yylloc.last_column;
    yylloc.last_column+=2;
    char c;
    while ((c = yyinput()) != '\n' && c != 0){
        if (c == '\t'){
            yylloc.last_column+=TAB_WORD-(yylloc.last_column%TAB_WORD);
            
        }else{
            yylloc.last_column++;
        }
    }
    unput(c);
//    printf("[LCommentFromC:%d,%d Line:%d,%d]",yylloc.first_column,yylloc.last_column,yylloc.first_line,yylloc.last_line);
    REC(RECTYPE_COMMENT,@"",yylloc);

}

void preCompiler()
{
    yylloc.first_line = yylloc.last_line;
    yylloc.first_column = yylloc.last_column;
    yylloc.last_column+=1;
    NSString *preString=@"";
    NSString *followString=@"";
    NSString **string = &preString;
    char c;
    while ((c = yyinput()) != '\n' && c != 0){
        if(c==' ' || c=='\t')string = &followString;
        
        *string = [*string stringByAppendingFormat:@"%c",c];
        if (c == '\t'){
            yylloc.last_column+=TAB_WORD-(yylloc.last_column%TAB_WORD);
            
        }else{
            yylloc.last_column++;
        }
    }
    unput(c);
    
    
    
    NSLog(@"[PreCompiler:[%@|%@]%d,%d Line:%d,%d]",preString,followString,yylloc.first_column,yylloc.last_column,yylloc.first_line,yylloc.last_line);
    REC(RECTYPE_PRECOMPILER,@"",yylloc);
    
    if ([preString isEqualToString:@"import"] || [preString isEqualToString:@"include"]) {
        YYLTYPE loc;
        loc.first_line=yylloc.first_line;
        loc.last_line = yylloc.last_line;
        loc.first_column = preString.length+yylloc.first_column+1;
        loc.last_column = yylloc.last_column;
        REC(RECTYPE_STRING,@"",loc);
    }
}

int column = 0;

void count()
{
    yylloc.first_line = yylloc.last_line;
    yylloc.first_column = yylloc.last_column;
    
    int i;
    
    for (i = 0; yytext[i] != '\0'; i++){
        if (yytext[i] == '\n'){
            column = 0;
            yylloc.last_column=0;
            yylloc.last_line++;
        }
        else if (yytext[i] == '\t'){
            column += TAB_WORD - (column % TAB_WORD);
            yylloc.last_column+=TAB_WORD-(yylloc.last_column%TAB_WORD);
            
        }
        else{
            column++;
            yylloc.last_column++;
        }
    }
        yylval.sval = [NSString stringWithCString:yytext encoding:NSUTF8StringEncoding];

//    ECHO;
    
}


int check_type()
{
  strncpy(_VCurrentIdentifier, yytext, 511);

//printf("\ncheck_type:%s , isKNOWN:%d\n",yytext,_VIsKnownTypeName(yytext));
//    char *newVal = (char*)malloc(sizeof(char)*strlen(yytext));
//    yylval.sval = strcpy(newVal,yytext);
    yylval.sval = [NSString stringWithCString:_VCurrentIdentifier];
  if(_VIsKnownTypeName()) {
    return(TYPE_NAME);
  } else {
    return(IDENTIFIER);
  }
}


/* inits the global string to the one we will parse */
void _VSetDataToScan(const char *someData)
{
    yylloc.first_column=yylloc.last_column = 0;
    yylloc.first_line = yylloc.last_line = 1;
    
//  [someData retain];
//  [_VCurrentData release];
//  _VCurrentData = someData;
  _VCurrentDataBytesIndex = 0;
//  _VCurrentDataBytes = (const char*)[_VCurrentData bytes];
    _VCurrentDataBytes = someData;
  if (_VCurrentDataBytes != NULL) {
    yy_scan_string(_VCurrentDataBytes);
  }
}

/* tells lex there's really no more input when we're done */
int yywrap() {
    return 1;
}