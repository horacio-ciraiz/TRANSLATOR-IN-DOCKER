
/*console.log('Server Escuchando');
const express = require("express");
const app=express(); //servidor

var cors=require('cors');
app.use(cors());
app.set('port',process.env.PORT||8080);

const morgan = require("morgan");
app.use(morgan('dev'));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());


//Iniciar App Server
app.listen(app.get('port'),()=>{
console.log(`Server on port ${app.get('port')}`);

    //console.log('Server on port ${8001}')

});

// Metodos
app.get('/',(req,res)=> {
    console.log("Esperando para Prueba");
    res.send("Hello");
});

app.post('/Analizar/',(req,res)=>{
    console.log("Esperando para Prueba");
    try{
        const {input}=req.body;
        var fs=require('fs');
        var parser =require('./Gramatica');
        //var ast;
        //data="Evaluar[1+1];"
        //parser.parse(data);
        try{
            parser.parse(input.toString());
            //fs.writeFileSync("./ast.json",JSON.stringify(ast,null,2));
            
        }catch(e){
            console.log("Pos Me Mori");
            console.error(e);
        }

        let errores= require("./Gramatica").errors;

       // if(ast!= undefined){
         //   console.log(errors);

        //}
        res.send(errors);

    }catch(e){
        console.error(e);

    }


});*/



var fs = require('fs');
var parser = require('./Gramatica');
var AST = require('./AST');
var NodoObjeto = require('./NodoObjeto');


fs.readFile('./prueba.txt', (err,data) => {
   // if (err) trhow err;
    //parser.parse(data.toString());

    var Raiz = new AST();
    NodoObjeto= parser.parse(data.toString());
   
    try{
        NodoObjeto= parser.parse(data.toString());
        var CodigoGraphvizRecuperado= Raiz.RecorrerAST(NodoObjeto.Nodo);
        var CodigoTraducidoRecuperado= Raiz.TraducirAST(NodoObjeto.Nodo);
        console.log(CodigoGraphvizRecuperado);
        console.log(CodigoTraducidoRecuperado);
        console.log("lexico");
        console.log(NodoObjeto.lexico);
        console.log("sintactico");
        console.log(NodoObjeto.sintactico);
        console.log("tokens");
        //console.log(NodoObjeto.tokens);


    }catch(error){
        console.log("lexico");
        console.log(NodoObjeto.lexico);
        console.log("sintactico");
        console.log(NodoObjeto.sintactico);
        console.log("tokens");
      //  console.log(NodoObjeto.tokens);
    }
    
    //----------------------codigo lexema
    

    //****console.log(raiz.traduccionTree( parser.parse(data.toString())));
 });

