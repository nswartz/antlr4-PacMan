import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.dfa.*;
import org.antlr.v4.runtime.atn.*;
import java.util.*;

public class csce322a1p2d {	
	public static void main(String[] args) {
		CharStream stream = null;
		try {
			stream = new ANTLRFileStream(args[0]);
		} catch (Exception e) {
			System.out.println("Error: file not found");
		}
		csce322a1p1 lexer = new csce322a1p1(stream);
		
		//TokenStream ts = new CommonTokenStream(lexer);	
		csce322a1p2 parser = new csce322a1p2(new BufferedTokenStream(lexer));
		
		// Establish contexts
		csce322a1p2.ProgramContext program = parser.program();
		csce322a1p2.StructureContext structure = program.structure();
		csce322a1p2.MapSectionContext mapSection = structure.mapSection();	
		csce322a1p2.MapContext map = mapSection.map();
		
		// Flag to see if there are any violations
		boolean violation = false;
		
		// If there are any errors, print them and change the violation flag
		for(int i=1; i<program.errors.length; i++) {
			if(program.errors[i] == true) {
				System.out.println("Semantic rule " + i + " violated.");
				violation = true;
			}
		}
		
		// If there are no violations, print the correct output
		if(!violation) {
			System.out.println("The map has " + map.totalFood + " food pellets.");
		}
	}
}