const express = require('express');
const app = express();
//funcion que procesa datos antes de que el servidor lo reciba
const morgan = require('morgan');
// puerto en el que escucha
app.set('port',process.env.PORT || 3030);
app.set('json spaces',2);

//seguridad
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
    next();
});

app.use(morgan('dev'));
app.use(express.urlencoded({extended: false}));
app.use(express.json());


//------variables-------------
const parser =require('./Gramatica.js');
const  AST = require('./AST.js');
var Nodo;
var CodigoGraphvizRecuperado;
var CodigoTraducidoRecuperado;
var ErroresLexicos;
var ErroresSintacticos;
var ListaTokens;

app.post('/api/Analizar',(req,res)=>{
    const{datos} =req.body;
    Analisis(datos);    
    res.json("Analizado Correctamente");

});

function Analisis(datos){


    CodigoTraducidoRecuperado="";
    CodigoGraphvizRecuperado="";
    datos=datos.substring(1,datos.length-1) ;//quitamos las llaves jason
    console.log(datos);

    var analisis=  parser.parse(datos.toString()); 
    Nodo=analisis.nodo;

    
    ErroresLexicos= analisis.lex;
    ErroresSintacticos = analisis.sin;
    ListaTokens= analisis.tok;

    var Raiz = new AST();
    try{
    CodigoGraphvizRecuperado= Raiz.RecorrerAST(Nodo);
    CodigoTraducidoRecuperado= Raiz.TraducirAST(Nodo);
    }catch(error){
        CodigoGraphvizRecuperado="ERROR FATAL";
        CodigoTraducidoRecuperado="ERROR FATAL";
    }
    Raiz.LimpiarVariableGraph();
    Raiz.CodigoGraphviz="";
   

}


app.post('/api/CodigoTraducido',(req,res)=>{
    const{datos} =req.body;
    //rast= new Recorrido_Arbol();
    
    app.response
    res.json(CodigoTraducidoRecuperado.toString());
 
 });

 app.post('/api/CodigoGraphviz',(req,res)=>{
    const{datos} =req.body;
    //rast= new Recorrido_Arbol();
    res.json(CodigoGraphvizRecuperado.toString());
 
 });

 //----------------ErroresLexicos
 app.post('/api/ErroresLexicos',(req,res)=>{
    const{datos} =req.body;
    //console.log("************ERRORES LEXICOS");
    //console.log(ErroresLexicos);
    res.json(ErroresLexicos);
 
 });

//-------------------ErroresSintacticos
app.post('/api/ErroresSintacticos',(req,res)=>{
    const{datos} =req.body;
    //rast= new Recorrido_Arbol();
    console.log("***ERRORES SINTACTICOS***")
    console.log(ErroresSintacticos);
    res.json(ErroresSintacticos);
 
 });

 app.post('/api/ListaTokens',(req,res)=>{
    const{datos} =req.body;
    //rast= new Recorrido_Arbol();
    res.json(ListaTokens);
 
 });



//iniciando servidor
app.listen(app.get('port'),()=>{
    console.log(`http://localhost:${app.get('port')}`);
});

