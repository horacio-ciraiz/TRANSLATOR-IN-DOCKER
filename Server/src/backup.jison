
 %{
	 const Nodo = require('./NodoAST');
	 const NodoObjeto = require('./NodoObjeto');
	 var arreglolexico = [];
	 var arreglosintactico =[];
	 var arreglotokens=[];

	 //comentario actualizacion
 %}
/**
 * Jison utilizando Nodejs en Mint
 */

/* Definición Léxica */
%lex

%options case-insensitive

%%

//-----------------Comentarios----------------
"//".*                              // comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] // comentario multiple líneas

//--------------------Aritmeticas Extra---------
"--"			%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return "sustraccion";%}
"++"			%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return "adicion";%}



//------------------Caracteres-----------
","             %{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'coma';%}
";"             %{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'pcoma'%};
"("				%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'parentesisA';%}
")"             %{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'parentesisC';%}
"{"             %{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'llaveA';%}
"}"             %{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'llaveC';%}
"["				%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'corcheteA';%}
"]"				%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'corcheteC';%}
//-------------------Relacionales---------
"=="			%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'dobleigual';%}   
">="			%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'mayorigual';%}   
"<="			%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'menorigual';%}   
">"				%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'mayor';%}   
"<"				%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'menor';%}   
"!="			%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return "notigual";%}  
//--------------------Aritmeticas---------
"+"				%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return "mas";%} 
"-"				%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return "menos";%} 
"*"				%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return "por";%} 
"/"				%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return "dividido";%}  
"="				%{ arreglotokens.push('Este es un igual: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return "igual";%} 

//-------------------Logicas--------------
"&&"					%{ arreglotokens.push('Este es un and: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'and';%}  
"||"            		%{ arreglotokens.push('Este es un or: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'or';%} 
"!"						%{ arreglotokens.push('Este es un not: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'not';%} 
"^"						%{ arreglotokens.push('Este es un xor: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return "xor";%} 

//-----------Palabras Reservadas
"void"         			%{ arreglotokens.push('Este es un void: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'void';%}  
"static"				%{ arreglotokens.push('Este es un static: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'static';%} 
"interface"				%{ arreglotokens.push('Este es un interface: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'interface';%} 
"main"					%{ arreglotokens.push('Este es un main: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'main';%} 
"System.out.println"	%{ arreglotokens.push('Este es un print: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'print';%} 
"System.out.print"		%{ arreglotokens.push('Este es un print: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'print';%} 
"args"					%{ arreglotokens.push('Este es un args: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return "args";%} 
"public"				%{ arreglotokens.push('Este es un public: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return "public";%} 
"class"					%{ arreglotokens.push('Este es un class: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return "class";%} 
//------------Sentencias
"for"					%{ arreglotokens.push('Este es un for: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'for';%} 
"while"					%{ arreglotokens.push('Este es un while: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'while';%} 
"do"					%{ arreglotokens.push('Este es un do: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'do';%} 
"if"					%{ arreglotokens.push('Este es un if: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'if';%} 
"else"					%{ arreglotokens.push('Este es un else: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'else';%} 
"break"					%{ arreglotokens.push('Este es un break: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'break';%} 
"continue"				%{ arreglotokens.push('Este es un continue: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'continue';%}  
"return"				%{ arreglotokens.push('Este es un return: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'return';%} 


//---------------Tipos

"boolean"				%{ arreglotokens.push('Este es un boolean: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'boolean';%} 
"int"					%{ arreglotokens.push('Este es un int: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'int';%}
"double" 				%{ arreglotokens.push('Este es un double: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'double';%} 
"String"				%{ arreglotokens.push('Este es un String: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'string';%} 
"char"					%{ arreglotokens.push('Este es un char: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'char';%}


/* Espacios en blanco */
[\s]+                    {}
[\r\t]+            {}
\n                  {}
//------------------Expresiones Regulares

([a-zA-Z])[a-zA-Z0-9_]* %{ arreglotokens.push('Este es un identificador: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'identificador'; %} 
[0-9]+("."[0-9]+)?\b    %{ arreglotokens.push('Este es un decimal: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'decimal'; %}
[0-9]+\b                %{ arreglotokens.push('Este es un entero: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); return 'entero'; %}
\"[^\"]*\"               { arreglotokens.push('Este es un cadena: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); yytext = yytext.substr(1,yyleng-2); return 'cadena';}


.                       {arreglolexico.push('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column);  console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }


<<EOF>>                 return 'EOF';

/lex
/* Asociación de operadores y precedencia */


%left 'mas' 'menos'
%left 'dividido' 'por'
%left 'adicion' 'sustraccion'

%left umenos


%start INICIO
%% /* Definición de la gramática */

INICIO: LISTACLASE EOF 	{$$= new Nodo("INICIO","");
								$$.addHijos($1);
								var NodoOb= new NodoObjeto($$,arreglolexico,arreglosintactico,arreglotokens);
								return NodoOb;
						}

						;
LISTACLASE:LISTACLASE CLASE{ $$ = new Nodo("LISTACLASE","");
								$$.addHijos($1);	
								$$.addHijos($2);																			
							}
	|CLASE					{   $$ = new Nodo("LISTACLASE","");
								$$.addHijos($1);																				
							}
	|LISTACLASE ERROR SIMBOLO
	|ERROR SIMBOLO
	;

CLASES:llaveA llaveC;


CLASE:CLASS{ $$ = new Nodo("TIPOCLASE","");
					$$.addHijos($1);																			
				}
	|INTERFACE{ $$ = new Nodo("TIPOCLASE","");
					$$.addHijos($1);																			
				}
	;

MAIN: public static void main parentesisA string  corcheteA corcheteC args parentesisC llaveA  llaveC{ $$ = new Nodo("MAIN","");
																								
																								}
	| public static void main parentesisA string  corcheteA corcheteC args parentesisC llaveA LISTAINSTRUCCIONES llaveC{ $$ = new Nodo("MAIN","");
																												$$.addHijos($12);
																								}
;

//------------------------------------Class--------------

CLASS: public class identificador llaveA llaveC  { $$ = new Nodo("CLASS","");
											$$.addHijos(new Nodo($3,"identificador"));
											}
	|public class identificador llaveA LISTACUERPOCLASS llaveC{ $$ = new Nodo("CLASS","");
											$$.addHijos(new Nodo($3,"identificador"));
											$$.addHijos($5);
											}
	;
				
LISTACUERPOCLASS:LISTACUERPOCLASS CUERPOCLASS { $$ = new Nodo("LISTACUERPOCLASS","");
													$$.addHijos($1);
													$$.addHijos($2);
												}
				|CUERPOCLASS					{ $$ = new Nodo("LISTACUERPOCLASS","");
													$$.addHijos($1);
												}
				|LISTACUERPOCLASS ERROR SIMBOLO				
				|ERROR SIMBOLO
				;

CUERPOCLASS:METODOS { $$ = new Nodo("CUERPOCLASS","");
						$$.addHijos($1);
					}
			|FUNCIONES{ $$ = new Nodo("CUERPOCLASS","");
						$$.addHijos($1);
					  }
			|DEC	{ $$ = new Nodo("CUERPOCLASS","");
						$$.addHijos($1);
					}
	
			|EXP		{ $$ = new Nodo("CUERPOCLASS","");
						$$.addHijos($1);
					}
			|MAIN	{ $$ = new Nodo("CUERPOCLASS","");
						$$.addHijos($1);
					}
			|ASIGNACION	{ $$ = new Nodo("CUERPOCLASS","");
						$$.addHijos($1);				 //---------------------Funciones
			}
			;



FUNCIONES:public TIPOVOID identificador parentesisA LISTAPARAMETROS parentesisC pcoma { $$ = new Nodo("FUNCIONES","");
																							$$.addHijos($2);
																							$$.addHijos(new Nodo($3,"identificador"));
																							$$.addHijos($5);
																							}
		|public TIPOVOID identificador parentesisA  parentesisC pcoma		 { $$ = new Nodo("FUNCIONES","");
																							$$.addHijos($2);
																							$$.addHijos(new Nodo($3,"identificador"));
																							}
		;

//--------------------------------Metodos
METODOS:public TIPOVOID identificador parentesisA LISTAPARAMETROS parentesisC llaveA llaveC	{ $$ = new Nodo("METODOS","1");
																							$$.addHijos($2);
																							$$.addHijos(new Nodo($3,"identificador"));
																							$$.addHijos($5);
																							} 	//--con parametros
		|public TIPOVOID identificador parentesisA  parentesisC llaveA llaveC 	{ $$ = new Nodo("METODOS","2");
																							$$.addHijos($2);
																							$$.addHijos(new Nodo($3,"identificador"));
																							}//---sin parametros 
		|public TIPOVOID identificador parentesisA LISTAPARAMETROS parentesisC llaveA LISTAINSTRUCCIONES llaveC 	{ $$ = new Nodo("METODOS","3");
																													$$.addHijos($2);
																													$$.addHijos(new Nodo($3,"identificador"));
																													$$.addHijos($5);
																													$$.addHijos($8);
																													}//--con parametros
		|public TIPOVOID identificador parentesisA  parentesisC llaveA LISTAINSTRUCCIONES llaveC 					{ $$ = new Nodo("METODOS","4");
																													$$.addHijos($2);
																													$$.addHijos(new Nodo($3,"identificador"));
																													$$.addHijos($7);
																													}//---sin parametros
	;						

//-----------------------------Interface------------------
INTERFACE: public interface identificador llaveA llaveC  	{ $$ = new Nodo("INTERFACE","");
													$$.addHijos(new Nodo($3,"identificador"));
													}
		|public interface identificador llaveA LISTACUERPOINTERFACE llaveC{ $$ = new Nodo("INTERFACE","");
																	$$.addHijos(new Nodo($3,"identificador"));
																	$$.addHijos($5);
																	}
;

LISTACUERPOINTERFACE:LISTACUERPOINTERFACE CUERPOINTERFACE { $$ = new Nodo("LISTACUERPOINTERFACE","");
																	$$.addHijos($1);
																	$$.addHijos($2);
																	}
					|CUERPOINTERFACE					  { $$ = new Nodo("LISTACUERPOINTERFACE","");
																	$$.addHijos($1);
																	
																	}
					|LISTACUERPOINTERFACE  ERROR SIMBOLO				
					|ERROR SIMBOLO
				
					;

CUERPOINTERFACE:FUNCIONES{ $$ = new Nodo("CUERPOINTERFACE","");
							$$.addHijos($1);
						}
;


//-------------Lista de Instrucciones------
LISTAINSTRUCCIONES:LISTAINSTRUCCIONES INSTRUCCIONES 	{ $$ = new Nodo("LISTAINSTRUCCIONES","");
													$$.addHijos($1);
													$$.addHijos($2);	
													}
				|INSTRUCCIONES 						{ $$ = new Nodo("LISTAINSTRUCCIONES","");
													$$.addHijos($1);
													}
				|LISTAINSTRUCCIONES  ERROR SIMBOLO				
				|ERROR SIMBOLO
				;

INSTRUCCIONES:SENTENCIAS	{ $$ = new Nodo("INSTRUCCIONES","");
							$$.addHijos($1);	
							}
			;
			

SENTENCIAS:	REPETICION	{ $$ = new Nodo("SENTENCIA","");
						$$.addHijos($1);	
						}
			|CONTROL	{ $$ = new Nodo("SENTENCIA","");
						$$.addHijos($1);	
						}
			|BREAK	{ $$ = new Nodo("SENTENCIA","");
						$$.addHijos($1);	
						}
			|CONTINUE	{ $$ = new Nodo("SENTENCIA","");
						$$.addHijos($1);	
						}
			|RETURN	{ $$ = new Nodo("SENTENCIA","");
						$$.addHijos($1);	
						}
			|DEC	{ $$ = new Nodo("SENTENCIA","");
						$$.addHijos($1);	
						}
			|ASIGNACION	{ $$ = new Nodo("SENTENCIA","");
						$$.addHijos($1);	
						}
			|PRINT	{ $$ = new Nodo("SENTENCIA","");
						$$.addHijos($1);	
						}
			|EXP { $$ = new Nodo("SENTENCIA","");
						$$.addHijos($1);	
						}
			|LLAMADA{ $$ = new Nodo("SENTENCIA","");
						$$.addHijos($1);	
						}

			;

LLAMADA: identificador parentesisA LISTAPARAMETROSVALOR parentesisC pcoma{ $$ = new Nodo("LLAMADA","");
																 $$.addHijos(new Nodo($1,"identificador")); 
																 $$.addHijos($3);	
																}
		|identificador parentesisA  parentesisC pcoma		{ $$ = new Nodo("LLAMADA","");
																 $$.addHijos(new Nodo($1,"identificador")); 
																 
																}
;

LISTAPARAMETROSVALOR:LISTAPARAMETROSVALOR coma 	PARAMETROSVALOR {	 $$ = new Nodo("LISTAPARAMETROSVALOR","");
																 $$.addHijos($1); 
																 $$.addHijos($3); 
																}
					|PARAMETROSVALOR 							{	 $$ = new Nodo("LISTAPARAMETROSVALOR","");
																 $$.addHijos($1); 
																}
					|LISTAPARAMETROSVALOR ERROR SIMBOLO 
					|ERROR SIMBOLO

					;			

PARAMETROSVALOR: EXPRESIONRELACIONAL							{	 $$ = new Nodo("PARAMETROSVALOR","");
																 $$.addHijos($1); 
																};

EXP: identificador adicion pcoma{ $$ = new Nodo("AUM_DEC","");
								$$.addHijos(new Nodo($1,"identificador")); 
								$$.addHijos(new Nodo($2,"sutraccion")); 	
								}
	|identificador sustraccion pcoma{ $$ = new Nodo("AUM_DEC","");
								$$.addHijos(new Nodo($1,"identificador")); 
								$$.addHijos(new Nodo($2,"sustraccion")); 
								};


PRINT: print parentesisA EXPRESIONLOGICA parentesisC pcoma	{ $$ = new Nodo("PRINT","");
																$$.addHijos($3);	
															}
				;

//-------------Repeticion
REPETICION:FOR	{ $$ = new Nodo("REPETICION","");
					$$.addHijos($1);	
				}
		|WHILE	{ $$ = new Nodo("REPETICION","");
					$$.addHijos($1);	
				}
		|DOWHILE	{ $$ = new Nodo("REPETICION","");
					$$.addHijos($1);	
				}
		;


//--------------Do While---------------
DOWHILE: do llaveA llaveC while parentesisA EXPRESIONLOGICA parentesisC pcoma { $$ = new Nodo("DOWHILE","");
																				$$.addHijos($6);	
																			}
		|do llaveA LISTAINSTRUCCIONES llaveC while parentesisA EXPRESIONLOGICA parentesisC pcoma { $$ = new Nodo("DOWHILE","");
																								$$.addHijos($3);
																								$$.addHijos($7);	
																								}
		;
//--------------While
WHILE: while parentesisA EXPRESIONLOGICA parentesisC llaveA llaveC			{ $$ = new Nodo("WHILE","");
																				$$.addHijos($3);	
																			}
	| while parentesisA EXPRESIONLOGICA parentesisC llaveA LISTAINSTRUCCIONES llaveC{ $$ = new Nodo("WHILE","");
																				$$.addHijos($3);	
																				$$.addHijos($6);
																			}
	;
//-----------------For

FOR: for parentesisA DEC  EXPRESIONLOGICA pcoma EXPRESIONLOGICA parentesisC llaveA llaveC		{ $$ = new Nodo("FOR","");
																								$$.addHijos($3);
																								$$.addHijos($4);
																								$$.addHijos($6);
																								}	
	|for parentesisA DEC  EXPRESIONLOGICA pcoma EXPRESIONLOGICA parentesisC llaveA LISTAINSTRUCCIONES llaveC{ $$ = new Nodo("FOR","");
																											$$.addHijos($3);
																											$$.addHijos($4);
																											$$.addHijos($6);
																											$$.addHijos($9)
																											}	
	;

//-------------------Control
CONTROL:IF 						{ $$ = new Nodo("CONTROL","");
								$$.addHijos($1);
								}	
		|ELSE					{ $$ = new Nodo("CONTROL","");
								$$.addHijos($1);
								}	
		|ELSEIF					{ $$ = new Nodo("CONTROL","");
								$$.addHijos($1);
								}	
		
		;
//------------------if
IF: if parentesisA EXPRESIONLOGICA parentesisC llaveA llaveC 	{ $$ = new Nodo("IF","");
																$$.addHijos($3);
																}	
	|if parentesisA EXPRESIONLOGICA parentesisC llaveA LISTAINSTRUCCIONES llaveC{ $$ = new Nodo("IF","");
																				$$.addHijos($3);
																				$$.addHijos($6);
																				}	
	;
//-------------------else--------------
ELSE:else llaveA llaveC						{ $$ = new Nodo("ELSE","");
											
											}	
	|else llaveA LISTAINSTRUCCIONES llaveC	{ $$ = new Nodo("ELSE","");
											$$.addHijos($3);
											}	
	
	;
//------------------else if------------
ELSEIF:else if parentesisA EXPRESIONLOGICA parentesisC llaveA llaveC	{ $$ = new Nodo("ELSEIF","");
																			$$.addHijos($4);
																		}	
		|else if parentesisA EXPRESIONLOGICA parentesisC llaveA LISTAINSTRUCCIONES llaveC	{ $$ = new Nodo("ELSEIF","");
																							$$.addHijos($4);
																							$$.addHijos($7);
																							}
		;



//---------------Break
BREAK: break pcoma													{ $$ = new Nodo("BREAK","");
																//$$.addHijos(new Nodo($1,"break"));
																};
//---------------Continue
CONTINUE: continue	pcoma											{ $$ = new Nodo("CONTINUE","");
																//$$.addHijos(new Nodo($1,"continue"));
																};
//---------------Return
RETURN: return EXPRESIONLOGICA pcoma									{ $$ = new Nodo("RETURN","");
																  $$.addHijos($2);
																}
		;
//--------------Asignacion---------------
ASIGNACION: identificador igual EXPRESIONLOGICA pcoma			{ $$ = new Nodo("ASIGNACION","");
																	$$.addHijos(new Nodo($1,"identificador")); 
																$$.addHijos($3);
																}
	
	;

//--------------Declaracion--------------
DEC:TIPO LISTAIDENTIFICADORES pcoma							{ $$ = new Nodo("DEC","");
                            									$$.addHijos($1);
																$$.addHijos($2);
																}

	
;

LISTAIDENTIFICADORES: LISTAIDENTIFICADORES coma LISTID 	{ $$ = new Nodo("LISTAIDENTIFICADORES","");
                            									$$.addHijos($1);
																$$.addHijos($3);
																}
																
					|LISTID								{ $$ = new Nodo("LISTAIDENTIFICADORES","");
																$$.addHijos($1);
                        										}
					
					;

LISTID:identificador igual EXPRESIONLOGICA 						{ $$ = new Nodo("LISTID","");
                            									$$.addHijos(new Nodo($1,"identificador")); 
																$$.addHijos($3);
																}
																
		|identificador											{ $$ = new Nodo("LISTID","");
                            									$$.addHijos(new Nodo($1,"identificador")); 
																}
																;

//------------_Lista de Parametros
LISTAPARAMETROS:LISTAPARAMETROS coma PARAMETROS 	{ $$ = new Nodo("LISTAPARAMETROS","");
                            							$$.addHijos($1);
														$$.addHijos($3); 
													}	

				|PARAMETROS 						{ $$ = new Nodo("LISTAPARAMETROS","");
                            							$$.addHijos($1);
                            							
													}
				;




PARAMETROS:TIPO identificador 						{ $$ = new Nodo("PARAMETROS","");
                            							$$.addHijos($1);
                            							$$.addHijos(new Nodo($2,"identificador")); 
													}	
			; 

//--------------Tipo/Void
TIPOVOID:VOID  { $$ = new Nodo("TIPOVOID","");
				$$.addHijos($1);
			}// cambiar a VOID
		|TIPO { $$ = new Nodo("TIPOVOID","");
				$$.addHijos($1);
			}
		;
VOID: void 					{ $$ = new Nodo("VOID","");
								$$.addHijos(new Nodo($1,"void")); 	
                        	}
	;
//--------------Tipo		
TIPO:int 					{ $$ = new Nodo("TIPO","");
								$$.addHijos(new Nodo($1,"int")); 	
                        	}
	|boolean				{ $$ = new Nodo("TIPO","");
								$$.addHijos(new Nodo($1,"boolean")); 	
                        	}
	|double					{ $$ = new Nodo("TIPO","");
								$$.addHijos(new Nodo($1,"double")); 	
                        	}
	|string					{ $$ = new Nodo("TIPO","");
								$$.addHijos(new Nodo($1,"string")); 	
                        	}
	|char					{ $$ = new Nodo("TIPO","");
								$$.addHijos(new Nodo($1,"char")); 	
                        	}
	;








//---------------Expresion Numerica
EXPRESIONNUMERICA:
		menos EXPRESIONNUMERICA %prec umenos		{ $$ = new Nodo("EXP","INICIO");
													  $$.addHijos(new Nodo($1,"menos")); 
                            							$$.addHijos($2);
													}	
		|EXPRESIONNUMERICA mas EXPRESIONNUMERICA	{ $$ = new Nodo("EXP","MEDIO");
                            							$$.addHijos($1);
                            							$$.addHijos(new Nodo($2,"mas")); 
														$$.addHijos($3);
													}	
		|EXPRESIONNUMERICA menos EXPRESIONNUMERICA { $$ = new Nodo("EXP","MEDIO");
                            							$$.addHijos($1);
                            							$$.addHijos(new Nodo($2,"menos")); 
														$$.addHijos($3);
													}	
		|EXPRESIONNUMERICA por EXPRESIONNUMERICA	{ $$ = new Nodo("EXP","MEDIO");
                            							$$.addHijos($1);
                            							$$.addHijos(new Nodo($2,"multiplicacion")); 
														$$.addHijos($3);
													}		
		|EXPRESIONNUMERICA dividido EXPRESIONNUMERICA{ $$ = new Nodo("EXP","MEDIO");
                            							$$.addHijos($1);
                            							$$.addHijos(new Nodo($2,"division")); 
														$$.addHijos($3);
													}	
		|EXPRESIONNUMERICA adicion					{ $$ = new Nodo("EXP","FINAL");
                            							$$.addHijos($1);
                            							$$.addHijos(new Nodo($2,"adicion")); 
													}	
		|EXPRESIONNUMERICA sustraccion 				{ $$ = new Nodo("EXP","FINAL");
                            							$$.addHijos($1);
                            							$$.addHijos(new Nodo($2,"sustraccion")); 
													}			
		|parentesisA EXPRESIONNUMERICA parentesisC	{ $$ = new Nodo("EXP","PAREN");
														$$.addHijos(new Nodo($1,"parentesisA")); 
                            							$$.addHijos($2); 
														$$.addHijos(new Nodo($3,"parentesisC"));
                        							}
		|entero										{ $$ = new Nodo("EXP","TERM");
															$$.addHijos(new Nodo($1,"entero")); 	
                        							}
		|decimal									{ $$ = new Nodo("EXP","TERM");
															$$.addHijos(new Nodo($1,"decimal")); 	
                        							}
		|cadena										{ $$ = new Nodo("EXP","TERM");
															$$.addHijos(new Nodo($1,"cadena")); 	
                        							}
		|identificador  							{ $$ = new Nodo("EXP","TERM");
															$$.addHijos(new Nodo($1,"identificador")); 	
                        							arreglotokens.push('Este es un token: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column);
													}
;

EXPRESIONRELACIONAL:
		//--------------Relacionales----------
		EXPRESIONNUMERICA dobleigual EXPRESIONNUMERICA 		{ $$ = new Nodo("EXP","MEDIO");
															$$.addHijos($1); 
															$$.addHijos(new Nodo($2,"dobleigual")); 
                            								$$.addHijos($3);
															
                        									}
		|EXPRESIONNUMERICA notigual EXPRESIONNUMERICA{ $$ = new Nodo("EXP","MEDIO");
															$$.addHijos($1); 
															$$.addHijos(new Nodo($2,"not igual")); 
                            								$$.addHijos($3);
															
                        									}
		|EXPRESIONNUMERICA mayor EXPRESIONNUMERICA{ $$ = new Nodo("EXP","MEDIO");
															$$.addHijos($1); 
															$$.addHijos(new Nodo($2,"mayor")); 
                            								$$.addHijos($3);
															
                        									}
		|EXPRESIONNUMERICA mayorigual EXPRESIONNUMERICA{ $$ = new Nodo("EXP","MEDIO");
															$$.addHijos($1); 
															$$.addHijos(new Nodo($2,"mayorigual")); 
                            								$$.addHijos($3);
															
                        									}
		|EXPRESIONNUMERICA menor EXPRESIONNUMERICA{ $$ = new Nodo("EXP","MEDIO");
															$$.addHijos($1); 
															$$.addHijos(new Nodo($2,"menor")); 
                            								$$.addHijos($3);
															
                        									}
		|EXPRESIONNUMERICA menorigual EXPRESIONNUMERICA{ $$ = new Nodo("EXP","MEDIO");
															$$.addHijos($1); 
															$$.addHijos(new Nodo($2,"dobleigual")); 
                            								$$.addHijos($3);
															
                        									}
		|EXPRESIONNUMERICA /* esta se puede borrar*/{ $$ = new Nodo("EXP","UNICO");
															$$.addHijos($1); 
															
															
                        									}
;

EXPRESIONLOGICA:
		//--------------Logicas---------------
		|EXPRESIONRELACIONAL and EXPRESIONRELACIONAL 		{ $$ = new Nodo("EXP","MEDIO");
															$$.addHijos($1); 
															$$.addHijos(new Nodo($2,"and")); 
                            								$$.addHijos($3);
															
                        									}
		|EXPRESIONRELACIONAL or EXPRESIONRELACIONAL			{ $$ = new Nodo("EXP","MEDIO");
															$$.addHijos($1); 
															$$.addHijos(new Nodo($2,"or")); 
                            								$$.addHijos($3);
															
                        									}
		|EXPRESIONRELACIONAL xor EXPRESIONRELACIONAL		{ $$ = new Nodo("EXP","MEDIO");
															$$.addHijos($1); 
															$$.addHijos(new Nodo($2,"xor")); 
                            								$$.addHijos($3);
															
                        									}
		|not EXPRESIONRELACIONAL							{ $$ = new Nodo("EXP","INICIO");
															$$.addHijos(new Nodo($1,"not")); 
															$$.addHijos($2); 
															
                        									}
		|EXPRESIONRELACIONAL								{ $$ = new Nodo("EXP","UNICO");
															$$.addHijos($1); 
															
                        									}

;

ERROR: error  { arreglosintactico.push('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
	;

SIMBOLO: pcoma
		|parentesisC
		|llaveC
		;
