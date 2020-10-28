
 %{
	 const Nodo = require('./NodoAST');
	 
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
"--"			return "sustraccion";
"++"			return "adicion";



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
"=="			return 'dobleigual';
">="			return 'mayorigual';
"<="			return 'menorigual';
">"				return 'mayor';
"<"				return 'menor';
"!="			return "notigual";
//--------------------Aritmeticas---------
"+"				return "mas";
"-"				return "menos";
"*"				return "por";
"/"				return "dividido";
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
"System.out.println"	return 'print';
"System.out.print"	return 'print';
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

INICIO: LISTACLASE EOF 	{$$= new Nodo("INICIO","");
								$$.addHijos($1);
								return $$;

						}
;
LISTACLASE:LISTACLASE CLASE{ $$ = new Nodo("LISTACLASE","");
								$$.addHijos($1);	
								$$.addHijos($2);																			
							}
	|CLASE					{ $$ = new Nodo("LISTACLASE","");
								$$.addHijos($1);																				
							}
	|error  pcoma { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
	;




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

