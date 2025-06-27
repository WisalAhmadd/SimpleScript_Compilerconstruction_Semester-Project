# SimpleScript_Compilerconstruction_Semester-Project

# SimpleScript Lexer 
A lexical analyzer for a custom language (SimpleScript), built with JFlex as part of a Compiler Construction semester project.

## 🚀 Features  
- Tokenizes keywords, identifiers, literals, and operators.  
- Tracks source positions for error messages.
- 

## 🔧 Usage  
First of all Install JFlex in the current directory amoung all these files present there
then open command prompt and change your directory where all these files are including the JFlex
now follow the next step!

Generate the lexer:
java -jar jflex-full-1.9.1.jar SimpleScript.flex

Compile the lexer:
javac SimpleScriptLexer.java

Run the test:
javac TestLexer.java
java TestLexer test.ss
