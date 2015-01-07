import ast.*;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.InputStreamReader;
import java_cup.runtime.*;

public class Test {

    private static String readFilename()
    {
        String filename = "";
        try{
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.println("Please enter test file name or press enter to input live");
        filename = reader.readLine();
        }
        catch ( Exception e )
        {
            System.out.println("Something wrong in the input reader, " +
                    "program will now exit");
            System.exit(1);
        }
        return filename;
    }

    public static void main(String args[]) throws Exception {

//	/* initialise the automatically generated scanner from calc.lex */
//	Yylex myScanner = new Yylex(System.in);
//
//	/* initialise the automatically generated parser from calc.cup */
//	parser myParser = new parser(myScanner);

        String filename = readFilename();
        Yylex myScanner;
        parser myParser = null;
        try {

            File file = new File(filename);
            while(!(file.exists() || filename.isEmpty()))
            {
                filename = readFilename();
                file = new File(filename);
            }
            if(!filename.isEmpty())
            {
                FileReader fileReader = new FileReader(file);
                myScanner = new Yylex(fileReader);
            }
            else myScanner = new Yylex(System.in);
            myParser = new parser(myScanner);
        }
        catch (Exception e)
        {
            System.out.println("Loading file failed.");
            System.out.println("Program exiting");
            System.exit(1);
        }

	/* parse the input program from stdin */

        System.out.println("Started parsing");
	Symbol result = myParser.parse();

	/* get the root of the AST built using semantic actions as specified in calc.cup */
	/* root == null in case there were parsing errors in the input program */
	GNode root = (GNode)result.value;
	

	/* simple traversal of the tree */
	if (root !=null) {
	    System.out.println("\nParsing completed\n\n");

	    SimpleVisitor simpleVisitor = new SimpleVisitor();
	    root.accept(simpleVisitor);

	} else
            System.out.println("Parsing failed");
		    	
   }


}