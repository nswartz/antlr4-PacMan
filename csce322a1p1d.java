import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.dfa.*;
import org.antlr.v4.runtime.atn.*;
import java.util.*;

public class csce322a1p1d {

	public static void main(String[] args) {
		CharStream stream = null;
		try {
			stream = new ANTLRFileStream(args[0]);
		} catch(Exception e) {
			System.out.println("Error: file not found");
		}
		

		csce322a1p1 lexer = new csce322a1p1(stream);
		
		// While there are more tokens
		while((lexer.nextToken()).getType() != -1) {
			// Print out each token on a new line
			switch (lexer.getType()) {
				case csce322a1p1.BEGIN_SECTION:
					System.out.println("Start Section: " + lexer.getText());
					break;
					
				case csce322a1p1.END_SECTION:
					System.out.println("End Section: " + lexer.getText());
					break;
					
				case csce322a1p1.LEVEL:
				case csce322a1p1.SCORE:
				case csce322a1p1.MAP:
				case csce322a1p1.LIVES:
					System.out.println("Section: " + lexer.getText());
					break;
					
				case csce322a1p1.ASSIGNMENT:
					System.out.println("Assignment: " + lexer.getText());
					break;
					
				case csce322a1p1.NUMBER:
					System.out.println("Number: " + lexer.getText());
					break;
					
				case csce322a1p1.WALL:
				case csce322a1p1.FOOD:
				case csce322a1p1.POWER:
				case csce322a1p1.EMPTY:
				case csce322a1p1.BORDER:
				case csce322a1p1.GHOST:
				case csce322a1p1.PACMAN:
					System.out.println("Cell: " + lexer.getText());
					break;
					
				case csce322a1p1.ROW_SEPARATOR:
					System.out.println("Comma: " + lexer.getText());
					break;
					
				case csce322a1p1.MAP_TERMINATOR:
					System.out.println("Semicolon: " + lexer.getText());
					break;
			}
		}
	}
}