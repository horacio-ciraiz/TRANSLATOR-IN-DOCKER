const {Router, text} = require('express');
const router = Router();

//var parser =require('./Gramatica.js');
//var AST = require('./AST');
//var NodoObjeto = require('./NodoObjeto');


//varibles globales------------------


router.post('/',(req,res)=>{
    //console.log(req.body);
    const{id,datos} =req.body;
    //iniciar_analisis(id,datos);
    console.log("Archivo analizado correctamente");
    res.json('Archivo analizado correctamente');
   
});

function iniciar_analisis(id,texto){
    texto=texto.substring(1,texto.length-1)//quitamos las llaves jason
    
    var Raiz = new AST();
    //----------server-------------
    NodoObjeto= parser.parse(data.toString());
    var CodigoGraphvizRecuperado= Raiz.RecorrerAST(NodoObjeto.Nodo);
    var CodigoTraducidoRecuperado= Raiz.TraducirAST(NodoObjeto.Nodo);
    var ErroresLexicos= NodoObjeto.lexico;
    var ErroresSintacticos= NodoObjeto.sintactico;
    var Tokens = NodoObjeto.tokens
    console.log(CodigoGraphvizRecuperado);
    console.log(CodigoTraducidoRecuperado);
    console.log("lexico");
    console.log(ErroresLexicos);
    console.log("sintactico");
    console.log(ErroresSintacticos);
    console.log("tokens");
    console.log(Tokens);

    //----------server----------

}