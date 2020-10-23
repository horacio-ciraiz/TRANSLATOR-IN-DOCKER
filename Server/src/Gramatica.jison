
 
/**
 * Jison utilizando Nodejs en Mint
 */

/* Definición Léxica */
%lex

%options case-insensitive

%%

//--------------------Aritmeticas Extra---------
"--"			return "sustraccion";
"++"			return "adicion";
"="				return "igual";


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
"System.out.println"	return 'print';
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
%left 'adicion' 'sustraccion'
%left umenos

%start INICIO

%% /* Definición de la gramática */

INICIO: LISTACLASE EOF
;

LISTACLASE:LISTACLASE CLASE
	|CLASE
	|error  pcoma { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
	;

CLASE:public TIPOCLASE
	;


TIPOCLASE:CLASS
	|INTERFACE
	;

MAIN: static void main parentesisA string  corcheteA corcheteC args parentesisC llaveA  llaveC
	|static void main parentesisA string  corcheteA corcheteC args parentesisC llaveA LISTAINSTRUCCIONES llaveC
;

//------------------------------------Class--------------

CLASS: class identificador llaveA llaveC
	|class identificador llaveA LISTACUERPOCLASS llaveC
	;
				
LISTACUERPOCLASS:LISTACUERPOCLASS CUERPOCLASS
				|CUERPOCLASS
				;

CUERPOCLASS:METODOS
			|FUNCIONES
			|MAIN
			;

//---------------------Funciones
FUNCIONES:public TIPOVOID identificador parentesisA LISTAPARAMETROS parentesisC pcoma
		|public TIPOVOID identificador parentesisA  parentesisC pcoma		
		;

//--------------------------------Metodos
METODOS:public TIPOVOID identificador parentesisA LISTAPARAMETROS parentesisC llaveA llaveC //--con parametros
		|public TIPOVOID identificador parentesisA  parentesisC llaveA llaveC //---sin parametros 
		|public TIPOVOID identificador parentesisA LISTAPARAMETROS parentesisC llaveA LISTAINSTRUCCIONES llaveC //--con parametros
		|public TIPOVOID identificador parentesisA  parentesisC llaveA LISTAINSTRUCCIONES llaveC //---sin parametros
	;						

//-----------------------------Interface------------------
INTERFACE: interface identificador llaveA llaveC
;

//-------------Lista de Instrucciones------
LISTAINSTRUCCIONES:LISTAINSTRUCCIONES INSTRUCIONES 
				|INSTRUCCIONES
				;

INSTRUCCIONES:SENTENCIAS;

SENTENCIAS:	REPETICION
			|CONTROL
			|BREAK
			|CONTINUE
			|RETURN
			|DEC
			|ASIGNACION
			|PRINT
			;
PRINT: print parentesisA EXPRESIONLOGICA parentesisC pcoma;

//-------------Repeticion
REPETICION:FOR
		|WHILE
		|DOWHILE
		;


//--------------Do While---------------
DOWHILE: do llaveA llaveC while parentesisA EXPRESIONLOGICA parentesisC pcoma
		|do llaveA LISTAINSTRUCCIONES llaveC while parentesisA EXPRESIONLOGICA parentesisC pcoma
		;
//--------------While
WHILE: while parentesisA EXPRESIONLOGICA parentesisC llaveA llaveC
	| while parentesisA EXPRESIONLOGICA parentesisC llaveA LISTAINSTRUCCIONES llaveC
	;
//-----------------For

FOR: for parentesisA DEC  EXPRESIONLOGICA pcoma EXPRESIONLOGICA parentesisC llaveA llaveC
	|for parentesisA DEC  EXPRESIONLOGICA pcoma EXPRESIONLOGICA parentesisC llaveA LISTAINSTRUCCIONES llaveC
	;

//---------------Control
CONTROL:IF 
		|ELSE
		|ELSEIF
		;
//------------------if
IF: if parentesisA EXPRESIONLOGICA parentesisC llaveA llaveC 
	|if parentesisA EXPRESIONLOGICA parentesisC llaveA LISTAINSTRUCCIONES llaveC
	;
//-------------------else--------------
ELSE:else llaveA llaveC
	|else llaveA LISTAINSTRUCCIONES llaveC
	;
//------------------else if------------
ELSEIF:else if parentesisA EXPRESIONLOGICA parentesisC llaveA llaveC
		|else if parentesisA EXPRESIONLOGICA parentesisC llaveA LISTAINSTRUCCIONES llaveC
		;


//------------------else-----------
//---------------Break
BREAK: break;
//---------------Continue
CONTINUE: continue;
//---------------Return
RETURN: return EXPRESION;
//--------------Asignacion---------------
ASIGNACION: identificador igual EXPRESIONLOGICA pcoma;

//--------------Declaracion--------------
DEC: TIPO LISTAIDENTIFICADORES igual EXPRESIONLOGICA pcoma;

LISTAIDENTIFICADORES: LISTAIDENTIFICADORES coma identificador 
					|identificador
					;

//------------_Lista de Parametros
LISTAPARAMETROS:LISTAPARAMETROS coma PARAMETROS 
				|PARAMETROS
				;

PARAMETROS:TIPO identificador; 

//--------------Tipo/Void
TIPOVOID:void
		|TIPO
		;
//--------------Tipo		
TIPO:int 
	|boolean
	|double
	|string
	|char
	;

//---------------Expresion Numerica
EXPRESIONNUMERICA:
		menos EXPRESIONNUMERICA %prec umenos
		|EXPRESIONNUMERICA mas EXPRESIONNUMERICA
		|EXPRESIONNUMERICA menos EXPRESIONNUMERICA
		|EXPRESIONNUMERICA por EXPRESIONNUMERICA
		|EXPRESIONNUMERICA dividido EXPRESIONNUMERICA
		|EXPRESIONNUMERICA adicion
		|EXPRESIONNUMERICA sustraccion
		|parentesisA EXPRESIONNUMERICA parentesisC
		|entero
		|decimal
		|cadena
		|identificador
		;

EXPRESIONRELACIONAL:
		//--------------Relacionales----------
		EXPRESIONNUMERICA dobleigual EXPRESIONNUMERICA
		|EXPRESIONNUMERICA notigual EXPRESIONNUMERICA
		|EXPRESIONNUMERICA mayor EXPRESIONNUMERICA
		|EXPRESIONNUMERICA mayorigual EXPRESIONNUMERICA
		|EXPRESIONNUMERICA menor EXPRESIONNUMERICA
		|EXPRESIONNUMERICA menorigual EXPRESIONNUMERICA
		|EXPRESIONNUMERICA // esta se puede borrar
		;

EXPRESIONLOGICA:
		//--------------Logicas---------------
		|EXPRESIONRELACIONAL and EXPRESIONRELACIONAL
		|EXPRESIONRELACIONAL or EXPRESIONRELACIONAL
		|EXPRESIONRELACIONAL xor EXPRESIONRELACIONAL
		|not EXPRESIONRELACIONAL
		|EXPRESIONRELACIONAL

;


