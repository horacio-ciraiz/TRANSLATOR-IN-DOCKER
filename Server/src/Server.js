
console.log('Server Escuchando')
const express = require("express")
const app=express() //servidor

var cors=require('cors')
app.use(cors())
app.set('port',process.env.PORT||8001);

const morgan = require("morgan");
app.use(morgan('dev'));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());


//Iniciar App Server
app.listen(app.get('port'),()=>{
console.log(`Server on port ${app.get('port')}`);

    //console.log('Server on port ${8001}')

})

// Metodos
app.get('/',(req,res)=> {
    console.log("Esperando para Prueba")
    res.send("Hello")
});

app.post('/Analizar/',(req,res)=>{
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

        //let errores= require("./Gramatica").errors;

       // if(ast!= undefined){
         //   console.log(errors);

        //}
       // res.send(errors);

    }catch(e){
        console.error(e);

    }


}

);
