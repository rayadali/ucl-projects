import java_cup.runtime.Symbol;

%%

%line
%cup

%state COMMENT

letter=[a-zA-Z]
digit=[0-9]

identifier={letter}({letter}|{digit})*

intnumber={digit}+
floatnumber={intnumber}"."{intnumber}

whitespace = [ \t\n\r\f]

strvalue = "\""[^\"]*"\""
chrvalue = "`"({letter}|{digit})"'"

%%

<YYINITIAL>"/*" {yybegin(COMMENT);}
<COMMENT>"*/" {yybegin(YYINITIAL);}
<COMMENT>[^"*/"]+ {}
<YYINITIAL>"len" { return new Symbol(sym.LEN); }
<YYINITIAL>"." { return new Symbol(sym.DOT); }
<YYINITIAL>"in" { return new Symbol(sym.IN); }
<YYINITIAL>"not in" { return new Symbol(sym.NOTIN); }
<YYINITIAL>{strvalue} { return new Symbol(sym.STRVALUE, yytext());}
<YYINITIAL>{chrvalue} {return new Symbol(sym.CHRVALUE, yytext());}
<YYINITIAL>";" { return new Symbol(sym.SEMI); }
<YYINITIAL>"[|" { return new Symbol(sym.TUOP); }
<YYINITIAL>"|]" { return new Symbol(sym.TUCL); }
<YYINITIAL>"[" { return new Symbol(sym.LSQUARE); }
<YYINITIAL>"]" { return new Symbol(sym.RSQUARE); }
<YYINITIAL>"int" {return new Symbol(sym.INT);}
<YYINITIAL>"float" {return new Symbol(sym.FLOAT);}
<YYINITIAL>"bool" {return new Symbol(sym.BOOL);}
<YYINITIAL>"fdef" {return new Symbol(sym.FDEF);}
<YYINITIAL>"tdef" {return new Symbol(sym.TDEF);}
<YYINITIAL>"str" {return new Symbol(sym.STR);}
<YYINITIAL>"list" {return new Symbol(sym.LIST);}
<YYINITIAL>"char" {return new Symbol(sym.CHAR);}
<YYINITIAL>"tuple" {return new Symbol(sym.TUPLE);}
<YYINITIAL>"void" {return new Symbol(sym.VOID);}
<YYINITIAL>"(" { return new Symbol(sym.LPAREN); }
<YYINITIAL>")" { return new Symbol(sym.RPAREN); }
<YYINITIAL>"," { return new Symbol(sym.COMMA); }
<YYINITIAL>"{" { return new Symbol(sym.LBRACE); }
<YYINITIAL>"}" { return new Symbol(sym.RBRACE); }
<YYINITIAL>"do" {return new Symbol(sym.DO);}
<YYINITIAL>"while" {return new Symbol(sym.WHILE);}
<YYINITIAL>"repeat" {return new Symbol(sym.REPEAT);}
<YYINITIAL>"until" {return new Symbol(sym.UNTIL);}
<YYINITIAL>"if" {return new Symbol(sym.IF);}
<YYINITIAL>"else" {return new Symbol(sym.ELSE);}
<YYINITIAL>"=" { return new Symbol(sym.ASSIGN); }
<YYINITIAL>"::" { return new Symbol(sym.CONCAT); }
<YYINITIAL>":" { return new Symbol(sym.COLON); }
<YYINITIAL>"^" { return new Symbol(sym.EXP); }
<YYINITIAL>"+" { return new Symbol(sym.ADD); }
<YYINITIAL>"-" { return new Symbol(sym.MINUS); }
<YYINITIAL>"*" { return new Symbol(sym.TIMES); }
<YYINITIAL>"/" { return new Symbol(sym.DIVIDE); }
<YYINITIAL>"||" { return new Symbol(sym.OR); }
<YYINITIAL>"&&" { return new Symbol(sym.AND); }
<YYINITIAL>"!" { return new Symbol(sym.NOT); }
<YYINITIAL>"<" { return new Symbol(sym.LE); }
<YYINITIAL>">" { return new Symbol(sym.GE); }
<YYINITIAL>"<=" { return new Symbol(sym.LEQ); }
<YYINITIAL>">=" { return new Symbol(sym.GEQ); }
<YYINITIAL>"==" { return new Symbol(sym.EQ); }
<YYINITIAL>"!=" { return new Symbol(sym.NEQ); }
<YYINITIAL>"true" { return new Symbol(sym.TRUE);}
<YYINITIAL>"false" { return new Symbol(sym.FALSE);}
<YYINITIAL>"return" { return new Symbol(sym.RETURN);}
<YYINITIAL>{identifier} { return new Symbol(sym.ID, yytext());}
<YYINITIAL>{floatnumber} { return new Symbol(sym.FLOATNUM, new Float(yytext())); }
<YYINITIAL>{intnumber} { return new Symbol(sym.INTNUM, new Integer(yytext())); }
<YYINITIAL>{whitespace} { /* ignore white space. */ }
<YYINITIAL>. {System.out.println("Scanning error - Illegal expression " + yytext() + " at line " + (yyline+1));}
