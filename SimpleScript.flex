import java.io.*;

%%

%class SimpleScriptLexer
%unicode
%line
%column
%type Token

%{
    public static class Token {
        public final int type;
        public final Object value;
        public final int line;
        public final int column;
        
        public Token(int type, Object value, int line, int column) {
            this.type = type;
            this.value = value;
            this.line = line;
            this.column = column;
        }
        
        @Override
        public String toString() {
            return String.format("Token[%d, %s] at %d:%d", 
                type, 
                value != null ? value : "null",
                line + 1,
                column + 1);
        }
    }

    // Token type constants
    public static final int EOF = 0;
    public static final int IF = 1;
    public static final int ELSE = 2;
    public static final int WHILE = 3;
    public static final int INT = 4;
    public static final int BOOL = 5;
    public static final int PLUS = 6;
    public static final int MINUS = 7;
    public static final int TIMES = 8;
    public static final int DIVIDE = 9;
    public static final int EQ = 10;      // ==
    public static final int NEQ = 11;     // !=
    public static final int GT = 12;      // >
    public static final int LT = 13;      // <
    public static final int GTE = 14;     // >=
    public static final int LTE = 15;     // <=
    public static final int ASSIGN = 16;  // =
    public static final int LPAREN = 17;  // (
    public static final int RPAREN = 18;  // )
    public static final int LBRACE = 19;  // {
    public static final int RBRACE = 20;  // }
    public static final int SEMI = 21;    // ;
    public static final int IDENTIFIER = 22;
    public static final int INTEGER_LITERAL = 23;
    public static final int BOOLEAN_LITERAL = 24;
    public static final int AND = 25;     // &&
    public static final int OR = 26;      // ||

    private Token token(int type) {
        return new Token(type, null, yyline, yycolumn);
    }
    
    private Token token(int type, Object value) {
        return new Token(type, value, yyline, yycolumn);
    }
%}

LineTerminator = \r|\n|\r\n
WhiteSpace = {LineTerminator} | [ \t\f]
LineComment = "//".*
MultiLineComment = "/*"([^*]|\*+[^*/])*"*/"
Identifier = [a-zA-Z_][a-zA-Z0-9_]*
IntegerLiteral = 0|[1-9][0-9]*|-[1-9][0-9]*
BooleanLiteral = true|false

%%

/* Comments */
{LineComment}      { /* ignore single-line comments */ }
{MultiLineComment} { /* ignore multi-line comments */ }

/* Keywords */
"if"       { return token(IF); }
"else"     { return token(ELSE); }
"while"    { return token(WHILE); }
"int"      { return token(INT); }
"bool"     { return token(BOOL); }

/* Operators */
"+"        { return token(PLUS); }
"-"        { return token(MINUS); }
"*"        { return token(TIMES); }
"/"        { return token(DIVIDE); }
"=="       { return token(EQ); }
"!="       { return token(NEQ); }
">"        { return token(GT); }
"<"        { return token(LT); }
">="       { return token(GTE); }
"<="       { return token(LTE); }
"="        { return token(ASSIGN); }
"&&"       { return token(AND); }
"||"       { return token(OR); }

/* Separators */
"("        { return token(LPAREN); }
")"        { return token(RPAREN); }
"{"        { return token(LBRACE); }
"}"        { return token(RBRACE); }
";"        { return token(SEMI); }

/* Literals */
{BooleanLiteral} { return token(BOOLEAN_LITERAL, yytext()); }
{IntegerLiteral} { 
    try {
        return token(INTEGER_LITERAL, Integer.parseInt(yytext()));
    } catch (NumberFormatException e) {
        throw new Error("Invalid integer literal '" + yytext() + "' at line " + (yyline+1) + ", column " + (yycolumn+1));
    }
}

/* Identifiers */
{Identifier}     { return token(IDENTIFIER, yytext()); }

/* Whitespace */
{WhiteSpace}     { /* ignore */ }

/* Error fallback */
[^]              { throw new Error("Illegal character '" + yytext() + "' at line " + (yyline+1) + ", column " + (yycolumn+1)); }

<<EOF>>          { return token(EOF); }