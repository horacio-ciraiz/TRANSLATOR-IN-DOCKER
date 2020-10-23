/**
 * Jison utilizando Nodejs en Mint
 */

/* Definición Léxica */
%lex

%options case-insensitive

%%


//------------------Caracteres-----------
","             return 'coma';
";"             return 'pcoma';
"("				return 'parentesisA';
")"             return 'parentesisC';
"{"             return 'llaveA';
"}"             return 'llaveC';
"["				return 'corcheteA';
"]"				return 'corcheteC';
//-------------------Relacionales---------
">"				return 'mayor';
"<"				return 'menor';
">="			return 'mayorigual';
"<="			return 'menorigual';
"=="			return 'dobleigual';
"!="			return "notigual";
//--------------------Aritmeticas---------
"+"				return "mas";
"-"				return "menos";
"*"				return "por";
"/"				return "dividido";

//--------------------Aritmeticas Extra---------
"--"			return "sustraccion";
"++"			return "adicion";
"="				return "igual";

//-------------------Logicas--------------
"&&"			return 'and';
"||"            return 'or';
"!"				return 'not';
"^"				return "xor";

//-----------Palabras Reservadas
"void"          return 'void';
"static"		return 'static';
"interface"		return 'interface'
"main"			return 'main';
"System".out.println"	return 'print';
"args"			return "args";
"public"		return "public";
"class"			return "class";
//------------Sentencias
"for"			return 'for';
"while"			return 'while';
"do"			return 'do';
"if"			return 'if';
"else"			return 'else';
"break"			return 'break';
"continue"		return 'continue';
"return"		return 'return';






//---------------Tipos

"boolean"		return 'boolean';
"int"			return 'int';
"double" 		return 'double';
"String"		return 'string';
"char"			return 'char';


/* Espacios en blanco */

[\s]+                    {}
[\r\t]+            {}
\n                  {}
//------------------Expresiones Regulares

([a-zA-Z])[a-zA-Z0-9_]* return 'identificador';
[0-9]+("."[0-9]+)?\b    return 'decimal';
[0-9]+\b                return 'entero';
\"[^\"]*\"              { yytext = yytext.substr(1,yyleng-2); return 'cadena'; }

//-----------------Comentarios----------------

"//".*                              // comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] // comentario multiple líneas



<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex

/* Asociación de operadores y precedencia */

%left 'mas' 'menos'
%left 'dividido' 'por'
%left umenos


%start INICIO

%% /* Definición de la gramática */

INICIO: LISTACLASE EOF
;

LISTACLASE:LISTACLASE CLASE
	|CLASE
	|error { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
	;

CLASE:public TIPOCLASE
	;


TIPOCLASE:MAIN
	|CLASS
	|INTERFACE
	;

MAIN: static void main parentesisA string  corcheteA corcheteC args parentesisC llaveA  llaveC
	;

CLASS: class identificador llaveA llaveC
	;


INTERFACE: interface identificador llaveA llaveC
;









				




/*
instrucciones
	: instruccion instrucciones
	| instruccion
	| error { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
;

instruccion
	: REVALUAR CORIZQ expresion CORDER PTCOMA {
		console.log('El valor de la expresión es: ' + $3);
	}
;

expresion
	: MENOS expresion %prec UMENOS  { $$ = $2 *-1; }
	| expresion MAS expresion       { $$ = $1 + $3; }
	| expresion MENOS expresion     { $$ = $1 - $3; }
	| expresion POR expresion       { $$ = $1 * $3; }
	| expresion DIVIDIDO expresion  { $$ = $1 / $3; }
	| ENTERO                        { $$ = Number($1); }
	| DECIMAL                       { $$ = Number($1); }
	| PARIZQ expresion PARDER       { $$ = $2; }
;
*/