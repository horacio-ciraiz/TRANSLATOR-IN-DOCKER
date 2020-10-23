%left 'or';
%left 'and';
%left 'xor';
%left 'dobleigual', 'notigual';
%left 'menor', 'menorigual', 'mayor', 'mayorigual';
%left 'mas', 'menos';
%left 'dividido', 'por';
%left umenos;
%left 'not';


%left 'or'
%left 'and'
%left 'xor'
%left 'dobleigual' 'notigual'
%left 'menor' 'menorigual' 'mayor' 'mayorigual'
%left 'mas' 'menos'
%left 'dividido' 'por'
%left umenos
%left 'not'


%left 'or'
%left 'and'
%left 'xor'
%left 'dobleigual' 'notigual'
%left 'menor' 'menorigual' 'mayor' 'mayorigual'
%left 'mas' 'menos'
%left 'dividido' 'por'

%left 'not'
%left 'adicion' 'sustraccion'
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
	|class identificador llaveA LISTACUERPOCLASS llaveC
	;

LISTACUERPOCLASS:LISTACUERPOCLASS CUERPOCLASS
				|CUERPOCLASS
				;



/*CUERPOCLASS://METODOS
			//|FUNCIONES
			;
*/
//-----------------------------__Metodo Funciones-------------------------------------			
/*
FUNCIONES:FUNCIONESPRIMA TODOFUNCIONES		
		;

FUNCIONESPRIMA:public TIPOVOID identificador parentesisA;

TODOFUNCIONES:LISTAPARAMETROS parentesisC pcoma
			| parentesisC pcoma
			;
			
			*/
//METODOS:public TIPOVOID identificador parentesisA LISTAPARAMETROS parentesisC llaveA llaveC //--con parametros
		//|public TIPOVOID identificador parentesisA  parentesisC llaveA llaveC //---sin parametros 
		//|public TIPOVOID identificador parentesisA LISTAPARAMETROS parentesisC llaveA LISTAINSTRUCCIONES llaveC //--con parametros
		//|public TIPOVOID identificador parentesisA  parentesisC llaveA LISTAINSTRUCCIONES llaveC //---sin parametros
//		;

//LISTAINSTRUCCIONES:LISTAINSTRUCCIONES INSTRUCIONES 
//				|INSTRUCCIONES
//				;

//INSTRUCCIONES:SENTENCIAS;

/*SENTENCIAS:	REPETICION
			|CONTROL
			|BREAK
			|CONTINUE
			|RETURN
			|DEC
			|ASIGNACION
			;
*//*
PRINT: print parentesisA EXPRESION parentesisC pcoma;

ASIGNACION: identificador igual EXPRESION;

BREAK: break;

CONTINUE: continue;

RETURN: return EXPRESION;

CONTROL:IF 
		|ELSE
		|ELSEIF
		;

REPETICION:FOR
		|WHILE
		|DOWHILE
		;

ELSEIF:else if parentesisA EXPRESION parentesisC llaveA llaveC
		|else if parentesisA EXPRESION parentesisC llaveA LISTAINSTRUCCIONES llaveC
		;

ELSE:else llaveA llaveC
	|else llaveA LISTAINSTRUCCIONES llaveC
	;

IF: if parentesisA EXPRESION parentesisC llaveA llaveC 
	|if parentesisA EXPRESION parentesisC llaveA LISTAINSTRUCCIONES llaveC
	;

FOR: for parentesisA DEC pcoma EXPRESION pcoma EXPRESION parentesisC llaveA llaveC
	|for parentesisA DEC pcoma EXPRESION pcoma EXPRESION parentesisC llaveA LISTAINSTRUCCIONES llaveC
	;

WHILE: while parentesisA EXPRESION parentesisC llaveA llaveC
	| while parentesisA EXPRESION parentesisC llaveA LISTAINSTRUCCIONES llaveC
	;
DOWHILE: do llaveA llaveC while parentesisA EXPRESION parentesisC pcoma
		|do llaveA LISTAINSTRUCCIONES llaveC while parentesisA EXPRESION parentesisC pcoma
		;

*/	
DEC: TIPO identificador igual EXPRESION ;


EXPRESION: 
		//--------------Logicas---------------
		//|EXPRESION and EXPRESION
		//|EXPRESION or EXPRESION
		//|EXPRESION xor EXPRESION
		//|not EXPRESION
		//--------------Relacionales----------
		//|EXPRESION dobleigual EXPRESION
		//|EXPRESION notigual EXPRESION
		//|EXPRESION mayor EXPRESION
		//|EXPRESION mayorigual EXPRESION
		//|EXPRESION menor EXPRESION
		//|EXPRESION menorigual EXPRESION
		//-----------aritmeticas 
		|menos EXPRESION %prec umenos
		|EXPRESION mas EXPRESION
		|EXPRESION menos EXPRESION
		|EXPRESION por EXPRESION
		|EXPRESION dividido EXPRESION
		|parentesisA EXPRESION parentesisC
		//--------Aumento-----------
		//|EXPRESION adicion
		//|EXPRESION sustraccion
		|entero
		|decimal
		|cadena
		|identificador
		;




LISTAPARAMETROS:LISTAPARAMETROS coma PARAMETROS 
				|PARAMETROS
				;

PARAMETROS:TIPO identificador; 

TIPOVOID:void
		|TIPO
		;
TIPO:int 
	|boolean
	|double
	|string
	|char
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