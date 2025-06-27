import java.io.*;

public class TestLexer {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Usage: java TestLexer <inputfile>");
            return;
        }

        try {
            SimpleScriptLexer lexer = new SimpleScriptLexer(new FileReader(args[0]));
            
            System.out.println("Tokenizing " + args[0] + "...");
            System.out.println("------------------------");
            
            SimpleScriptLexer.Token token;
            do {
                token = lexer.yylex();
                printToken(token);
            } while (token.type != SimpleScriptLexer.EOF);
            
        } catch (IOException e) {
            System.err.println("Error reading file: " + e.getMessage());
        }
    }
    
    private static void printToken(SimpleScriptLexer.Token token) {
        String tokenName = getTokenName(token.type);
        String value = token.value != null ? token.value.toString() : "";
        
        System.out.printf("%-20s %-10s at line %d, column %d\n", 
                         tokenName, value, token.line + 1, token.column + 1);
    }
    
    private static String getTokenName(int type) {
        switch (type) {
            case SimpleScriptLexer.EOF: return "EOF";
            case SimpleScriptLexer.IF: return "IF";
            case SimpleScriptLexer.ELSE: return "ELSE";
            case SimpleScriptLexer.WHILE: return "WHILE";
            case SimpleScriptLexer.INT: return "INT";
            case SimpleScriptLexer.BOOL: return "BOOL";
            case SimpleScriptLexer.PLUS: return "PLUS";
            case SimpleScriptLexer.MINUS: return "MINUS";
            case SimpleScriptLexer.TIMES: return "TIMES";
            case SimpleScriptLexer.DIVIDE: return "DIVIDE";
            case SimpleScriptLexer.EQ: return "EQ";
            case SimpleScriptLexer.NEQ: return "NEQ";
            case SimpleScriptLexer.GT: return "GT";
            case SimpleScriptLexer.LT: return "LT";
            case SimpleScriptLexer.ASSIGN: return "ASSIGN";
            case SimpleScriptLexer.LPAREN: return "LPAREN";
            case SimpleScriptLexer.RPAREN: return "RPAREN";
            case SimpleScriptLexer.LBRACE: return "LBRACE";
            case SimpleScriptLexer.RBRACE: return "RBRACE";
            case SimpleScriptLexer.SEMI: return "SEMI";
            case SimpleScriptLexer.IDENTIFIER: return "IDENTIFIER";
            case SimpleScriptLexer.INTEGER_LITERAL: return "INT_LITERAL";
            case SimpleScriptLexer.BOOLEAN_LITERAL: return "BOOL_LITERAL";
            default: return "UNKNOWN";
        }
    }
}