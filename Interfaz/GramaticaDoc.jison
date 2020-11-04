INICIO: LISTACLASE EOF ;

LISTACLASE:LISTACLASE CLASE
	|CLASE					
	|LISTACLASE  ERROR SIMBOLO CLASE
	| ERROR SIMBOLO	CLASE;


CLASE:CLASS
	|INTERFACE;

MAIN: public static void main parentesisA string  corcheteA corcheteC args parentesisC llaveA  llaveC
	| public static void main parentesisA string  corcheteA corcheteC args parentesisC llaveA LISTAINSTRUCCIONES llaveC;

CLASS: public class identificador llaveA llaveC  
	|public class identificador llaveA LISTACUERPOCLASS llaveC;
				
LISTACUERPOCLASS:LISTACUERPOCLASS CUERPOCLASS 
				|CUERPOCLASS					
				|LISTACUERPOCLASS  ERROR SIMBOLO CUERPOCLASS
				| ERROR SIMBOLO	CUERPOCLASS	;

CUERPOCLASS:METODOS 
			|FUNCIONES
			|DEC
			|EXP
			|MAIN
			|ASIGNACION;



FUNCIONES:public TIPOVOID identificador parentesisA LISTAPARAMETROS parentesisC pcoma 
		|public TIPOVOID identificador parentesisA  parentesisC pcoma;

//--------------------------------Metodos
METODOS:public TIPOVOID identificador parentesisA LISTAPARAMETROS parentesisC llaveA llaveC	
		|public TIPOVOID identificador parentesisA  parentesisC llaveA llaveC 
		|public TIPOVOID identificador parentesisA LISTAPARAMETROS parentesisC llaveA LISTAINSTRUCCIONES llaveC /--con parametros
		|public TIPOVOID identificador parentesisA  parentesisC llaveA LISTAINSTRUCCIONES llaveC;						

//-----------------------------Interface------------------
INTERFACE: public interface identificador llaveA llaveC 
		|public interface identificador llaveA LISTACUERPOINTERFACE llaveC;

LISTACUERPOINTERFACE:LISTACUERPOINTERFACE CUERPOINTERFACE
					|CUERPOINTERFACE
					|LISTACUERPOINTERFACE  ERROR SIMBOLO CUERPOINTERFACE
					| ERROR SIMBOLO	CUERPOINTERFACE;

CUERPOINTERFACE:FUNCIONES;

//-------------Lista de Instrucciones------
LISTAINSTRUCCIONES:LISTAINSTRUCCIONES INSTRUCCIONES
				|INSTRUCCIONES 
				|LISTAINSTRUCCIONES  ERROR SIMBOLO INSTRUCCIONES
				|ERROR SIMBOLO	INSTRUCCIONES;

INSTRUCCIONES:SENTENCIAS;

SENTENCIAS:	REPETICION
			|CONTROL
			|BREAK
			|CONTINUE
			|RETURN
			|DEC
			|ASIGNACION
			|PRINT
			|EXP 
			|LLAMADA;

LLAMADA: identificador parentesisA LISTAPARAMETROSVALOR parentesisC pcoma
		|identificador parentesisA  parentesisC pcoma;

LISTAPARAMETROSVALOR:LISTAPARAMETROSVALOR coma 	PARAMETROSVALOR
					|PARAMETROSVALOR;			

PARAMETROSVALOR: EXPRESIONRELACIONAL;

EXP: identificador adicion pcoma
	|identificador sustraccion pcoma;


PRINT: print parentesisA EXPRESIONLOGICA parentesisC pcoma;

//-------------Repeticion
REPETICION:FOR
		|WHILE
		|DOWHILE;

//--------------Do While---------------
DOWHILE: do llaveA llaveC while parentesisA EXPRESIONLOGICA parentesisC pcoma 
		|do llaveA LISTAINSTRUCCIONES llaveC while parentesisA EXPRESIONLOGICA parentesisC pcoma;
//--------------While
WHILE: while parentesisA EXPRESIONLOGICA parentesisC llaveA llaveC
	| while parentesisA EXPRESIONLOGICA parentesisC llaveA LISTAINSTRUCCIONES llaveC;
//-----------------For

FOR: for parentesisA DEC  EXPRESIONLOGICA pcoma EXPRESIONLOGICA parentesisC llaveA llaveC
	|for parentesisA DEC  EXPRESIONLOGICA pcoma EXPRESIONLOGICA parentesisC llaveA LISTAINSTRUCCIONES llaveC;

//-------------------Control
CONTROL:IF
		|ELSE
		|ELSEIF;
//------------------if
IF: if parentesisA EXPRESIONLOGICA parentesisC llaveA llaveC
	|if parentesisA EXPRESIONLOGICA parentesisC llaveA LISTAINSTRUCCIONES llaveC;
//-------------------else--------------
ELSE:else llaveA llaveC	
	|else llaveA LISTAINSTRUCCIONES llaveC	;
//------------------else if------------
ELSEIF:else if parentesisA EXPRESIONLOGICA parentesisC llaveA llaveC	
		|else if parentesisA EXPRESIONLOGICA parentesisC llaveA LISTAINSTRUCCIONES llaveC;
//---------------Break
BREAK: break pcoma;
//---------------Continue
CONTINUE: continue	pcoma;
//---------------Return
RETURN: return EXPRESIONLOGICA pcoma		;
//--------------Asignacion---------------
ASIGNACION: identificador igual EXPRESIONLOGICA pcoma;

//--------------Declaracion--------------
DEC:TIPO LISTAIDENTIFICADORES pcoma;

LISTAIDENTIFICADORES: LISTAIDENTIFICADORES coma LISTID 
					|LISTID;

LISTID:identificador igual EXPRESIONLOGICA 											
		|identificador;

//------------_Lista de Parametros
LISTAPARAMETROS:LISTAPARAMETROS coma PARAMETROS 
				|PARAMETROS;




PARAMETROS:TIPO identificador; 

//--------------Tipo/Void
TIPOVOID:VOID 
		|TIPO;
VOID: void;
//--------------Tipo		
TIPO:int 					
	|boolean				
	|double					
	|string					
	|char;
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
		|identificador;

EXPRESIONRELACIONAL:
		//--------------Relacionales----------
		EXPRESIONNUMERICA dobleigual EXPRESIONNUMERICA 		
		|EXPRESIONNUMERICA notigual EXPRESIONNUMERICA
		|EXPRESIONNUMERICA mayor EXPRESIONNUMERICA
		|EXPRESIONNUMERICA mayorigual EXPRESIONNUMERICA
		|EXPRESIONNUMERICA menor EXPRESIONNUMERICA
		|EXPRESIONNUMERICA menorigual EXPRESIONNUMERICA
		|EXPRESIONNUMERICA /* esta se puede borrar*/;

EXPRESIONLOGICA:
		//--------------Logicas---------------
		|EXPRESIONRELACIONAL and EXPRESIONRELACIONAL 		
		|EXPRESIONRELACIONAL or EXPRESIONRELACIONAL			
		|EXPRESIONRELACIONAL xor EXPRESIONRELACIONAL		
		|not EXPRESIONRELACIONAL							
		|EXPRESIONRELACIONAL;

ERROR: error  { arreglosintactico.push('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column + "se esperaba: "); console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); };

SIMBOLO: pcoma
		|parentesisC
		|llaveC	;
