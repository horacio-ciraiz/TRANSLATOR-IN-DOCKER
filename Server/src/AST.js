var NodoContador = 1;
var CodigoGraphviz = "";
class AST {

    RecorrerAST(Nodo) {
        if (Nodo.ID == 0) {
            Nodo.ID = NodoContador;
            NodoContador++;
        }

       
        CodigoGraphviz += "S" + Nodo.ID + " [label = \"" + Nodo.Valor + "\" ];" + " "

        Nodo.Hijos.forEach(element => {

            CodigoGraphviz += "S" + Nodo.ID + " -> " + "S" + NodoContador + ";" + "  ";

            this.RecorrerAST(element);
        });
       
        return CodigoGraphviz;

    }
    LimpiarVariableGraph() {

        CodigoGraphviz="";
    }
    TraducirAST(Nodo) {
        if (Nodo.Valor == "INICIO") {//--------------------------------Inicio------------------
            console.log("---INICIO---");
            var INICIO = this.TraducirAST(Nodo.Hijos[0]);
            return INICIO;

        } else if (Nodo.Valor == "LISTACLASE") {//---------------------ListaClase--------------
            console.log("---LISTACLASE---");
            var tamnodos = Nodo.Hijos.length
            if (tamnodos == 1) {//------1
                var LISTACLASE = this.TraducirAST(Nodo.Hijos[0]);

            } else if (tamnodos == 2) {//------2
                let LISTACLASES = this.TraducirAST(Nodo.Hijos[0]);//izquierda
                let TIPOCLASE = this.TraducirAST(Nodo.Hijos[1]);//derecha
                var LISTACLASE = LISTACLASES +TIPOCLASE;
            }
            return LISTACLASE;
        } else if (Nodo.Valor == "TIPOCLASE") {//------------------------TipoClase
            var tamnodos = Nodo.Hijos.length;
            console.log("----TIPOCLASE---")

            if (Nodo.Hijos[0].Valor == "CLASS") {

                var TIPOCLASE = this.TraducirAST(Nodo.Hijos[0]);
            } else {
                console.log("-----INTERFACE---")
                var TIPOCLASE = "";
            }
            return TIPOCLASE;
        } else if (Nodo.Valor == "CLASS") {
            console.log("-----CLASS--");
            var tamnodos = Nodo.Hijos.length;
            if (tamnodos == 1) {
                var CLASS = "class " + Nodo.Hijos[0].Valor + "{ \n\n" + "}\n";
            } else if (tamnodos == 2) {
                let LISTACUERPOCLASS = this.TraducirAST(Nodo.Hijos[1]);//listacuerpoclass
                let identificador = Nodo.Hijos[0].Valor;
                var CLASS = "class " + identificador + "{\n" + LISTACUERPOCLASS + "\n}\n";
            }
            return CLASS;
        } else if (Nodo.Valor == "LISTACUERPOCLASS") {
            console.log("-----LISTACUERPOCLASS--");
            var tamnodos = Nodo.Hijos.length;
            if (tamnodos == 1) {
                var LISTACUERPOCLASS = this.TraducirAST(Nodo.Hijos[0]);
            } else if (tamnodos == 2) {
                let _LISTACUERPOCLASS = this.TraducirAST(Nodo.Hijos[0]);//izquierda
                let CUERPOCLASS = this.TraducirAST(Nodo.Hijos[1]);//derecha
                var LISTACUERPOCLASS = _LISTACUERPOCLASS +CUERPOCLASS;
            }
            return LISTACUERPOCLASS;
        } else if (Nodo.Valor == "CUERPOCLASS") {

            var CUERPOCLASS = this.TraducirAST(Nodo.Hijos[0])+"\n";

            return CUERPOCLASS
        } else if (Nodo.Valor == "METODOS") {
            var tamnodos = Nodo.Hijos.length;

            if (tamnodos == 3) {
                if (Nodo.Tipo == 1) {
                    let identificador = Nodo.Hijos[1].Valor;
                    let listaparametros = this.TraducirAST(Nodo.Hijos[2]);
                    var METODOS = "function " + identificador + "( " + listaparametros + " ) {\n}\n";


                } else if (Nodo.Tipo == 4) {
                    let identificador = Nodo.Hijos[1].Valor;
                    let listainstrucciones = this.TraducirAST(Nodo.Hijos[2]);
                    var METODOS = "function " + identificador + "( ) {\n" + listainstrucciones + "\n}\n";

                }

            } else if (tamnodos == 2) {
                let identificador = Nodo.Hijos[1].Valor;
                var METODOS = "function " + identificador + "( ) { }\n";

            } if (tamnodos == 4) {
                let identificador = Nodo.Hijos[1].Valor;
                let listaparametros = this.TraducirAST(Nodo.Hijos[2]);
                let listainstrucciones = this.TraducirAST(Nodo.Hijos[3]);
                var METODOS = "function " + identificador + "( " + listaparametros + " ) {\n" + listainstrucciones + "\n} \n\n";
            }

            //var METODOS=this.TraducirAST(Nodo.Hijos[0]);

            return METODOS
        } else if (Nodo.Valor == "LISTAPARAMETROS") {
            var tamnodos = Nodo.Hijos.length;

            if(tamnodos==1){
                var LISTAPARAMETROS= this.TraducirAST(Nodo.Hijos[0]);

            }else if (tamnodos ==2){
                let lista= this.TraducirAST(Nodo.Hijos[0]);
                let parametros= this.TraducirAST(Nodo.Hijos[1]);

                var LISTAPARAMETROS= lista+","+parametros;
            }

            return LISTAPARAMETROS
        }else if (Nodo.Valor == "PARAMETROS") {

            var PARAMETROS = Nodo.Hijos[1].Valor;


            return PARAMETROS

        }else if (Nodo.Valor == "LISTAINSTRUCCIONES") {
            var tamnodos = Nodo.Hijos.length;

            if(tamnodos==1){
                let instrucciones = this.TraducirAST(Nodo.Hijos[0]);

                var LISTAINSTRUCCIONES=  instrucciones;
            }else if (tamnodos==2){
                let lista= this.TraducirAST(Nodo.Hijos[0])+"\n";
                let instrucciones = this.TraducirAST(Nodo.Hijos[1]);

                var LISTAINSTRUCCIONES=  lista + instrucciones;
            }
            return LISTAINSTRUCCIONES
//---------------------------------------------DECLARACIO-----------------
        }else if (Nodo.Valor == "DEC") {
            let listaidentificadores = this.TraducirAST(Nodo.Hijos[1]);
            var DEC = "var " + listaidentificadores+";";

            return DEC

        }else if (Nodo.Valor == "LISTAIDENTIFICADORES") {
            var tamnodos = Nodo.Hijos.length;
            if(tamnodos==1){
                
                let identificadores = this.TraducirAST(Nodo.Hijos[0]);

                var LISTAIDENTIFICADORES= identificadores;

            }else if (tamnodos==2){
                let lista = this.TraducirAST(Nodo.Hijos[0]);
                let identificadores = this.TraducirAST(Nodo.Hijos[1]);

                var LISTAIDENTIFICADORES= lista + ","+ identificadores;
            }
            

            return LISTAIDENTIFICADORES

        }else if (Nodo.Valor == "LISTID") {
            var tamnodos = Nodo.Hijos.length;
            if(tamnodos==1){
                
                let identificadores = Nodo.Hijos[0].Valor;
                var LISTID= identificadores;

            }else if (tamnodos==2){
                let identificador = Nodo.Hijos[0].Valor;
                let identificadores = this.TraducirAST(Nodo.Hijos[1]);

                var LISTID= identificador + "="+ identificadores;
            }
            return LISTID
//--------------------------------------------------EXPRESION            
        }else if (Nodo.Valor == "EXP") {

            if(Nodo.Tipo=="UNICO"){
                var EXP= this.TraducirAST(Nodo.Hijos[0]);

            }else if (Nodo.Tipo=="MEDIO"){
                let valor1=this.TraducirAST(Nodo.Hijos[0]);
                let simbolo=Nodo.Hijos[1].Valor;
                let valor2=this.TraducirAST(Nodo.Hijos[2]);
                var EXP= valor1 + simbolo + valor2;
                
            }else if (Nodo.Tipo=="TERM"){
                if(Nodo.Hijos[0].Tipo=="cadena"){
                    var valor="\""+Nodo.Hijos[0].Valor+"\"";
                }else{
                    var valor=Nodo.Hijos[0].Valor;
                }
                var EXP= valor;
                
            }else if (Nodo.Tipo=="PAREN"){
                let parenA=Nodo.Hijos[0].Valor;
                let valor=this.TraducirAST(Nodo.Hijos[1]);
                let parenC=Nodo.Hijos[2].Valor;
                var EXP= parenA + valor + parenC;
                
            }else if (Nodo.Tipo=="FINAL"){
                let valor=this.TraducirAST(Nodo.Hijos[0]);
                let simobolo=Nodo.Hijos[1].Valor;
                var EXP= valor + simobolo;
                
            }else if (Nodo.Tipo=="INICIO"){
                
                let simobolo=Nodo.Hijos[0].Valor;
                let valor=this.TraducirAST(Nodo.Hijos[1]);
                var EXP= simbolo + valor;
            }

            return EXP

//---------------Aumento---------------------
        }else if (Nodo.Valor == "AUM_DEC") {
            let valor= Nodo.Hijos[0].Valor;
            let simbolo= Nodo.Hijos[1].Valor;
            var AUM_DEC= valor + simbolo + ";\n" ;

            return AUM_DEC 
        }else if (Nodo.Valor == "ASIGNACION") {
            let identificador= Nodo.Hijos[0].Valor;
            let valor = this.TraducirAST( Nodo.Hijos[1]);
            var ASIGNACION= identificador+ "=" + valor +  ";" ;

           return ASIGNACION 
        }else if (Nodo.Valor == "MAIN") {
            var tamnodos = Nodo.Hijos.length;
            if(tamnodos==0){
                var MAIN="function main(){}";

            }else if (tamnodos==1){
                var contenido = this.TraducirAST(Nodo.Hijos[0]);
                var MAIN="function main( ){\n"+contenido+ "\n}\n";
            }
            

           return MAIN 
        }else if (Nodo.Valor == "FUNCIONES") {
            var tamnodos = Nodo.Hijos.length;
            if(tamnodos==2){
                let nombre= Nodo.Hijos[1].Valor;
                var FUNCIONES="function " + nombre + "();";//funciones
            }else if (tamnodos==3){
                let nombre = Nodo.Hijos[1].Valor;
                let parametros= this.TraducirAST(Nodo.Hijos[2]);
                var FUNCIONES="function "+nombre+"("+parametros+");";//funciones
            }

            return FUNCIONES
        }else if (Nodo.Valor == "INSTRUCCIONES") {
            var INSTRUCCIONES= this.TraducirAST(Nodo.Hijos[0]); 
            return INSTRUCCIONES
        }
        else if (Nodo.Valor == "SENTENCIA") {
            var SENTENCIA=this.TraducirAST(Nodo.Hijos[0]); 
            return SENTENCIA
        }else if (Nodo.Valor=="REPETICION"){
            var REPETICION = this.TraducirAST(Nodo.Hijos[0]);
            return REPETICION
        }else if (Nodo.Valor=="CONTROL"){
            var CONTROL = this.TraducirAST(Nodo.Hijos[0]);
            return CONTROL
        }else if (Nodo.Valor=="IF"){
            var tamnodos = Nodo.Hijos.length;
            if(tamnodos==1){
                let expresion= this.TraducirAST(Nodo.Hijos[0]);
                var IF="if("+expresion+"){ }";//funciones
            }else if (tamnodos==2){
                let expresion= this.TraducirAST(Nodo.Hijos[0]);
                let instrucciones= this.TraducirAST(Nodo.Hijos[1]);
                var IF="if("+expresion+"){\n"+instrucciones+"\n}";//funciones
            }
            return IF
        }else if (Nodo.Valor=="ELSEIF"){
            var tamnodos = Nodo.Hijos.length;
            if(tamnodos==1){
                let expresion= this.TraducirAST(Nodo.Hijos[0]);
                var ELSEIF="else if("+expresion+"){ }";//funciones
            }else if (tamnodos==2){
                let expresion= this.TraducirAST(Nodo.Hijos[0]);
                let instrucciones= this.TraducirAST(Nodo.Hijos[1]);
                var ELSEIF="else if("+expresion+"){ \n"+instrucciones+"\n}";//funciones
            }
            return ELSEIF
        }else if (Nodo.Valor=="ELSE"){
            var tamnodos = Nodo.Hijos.length;
            if(tamnodos==0){
                
                var ELSE="else{ }";//funciones
            }else if (tamnodos==1){
                let instrucciones= this.TraducirAST(Nodo.Hijos[0]);
                var ELSE="else{\n "+instrucciones+"\n}";//funciones
            }
            return ELSE
        }else if (Nodo.Valor=="FOR"){
            var tamnodos = Nodo.Hijos.length;
            if(tamnodos==3){
                let dec = this.TraducirAST(Nodo.Hijos[0]);
                let exp1= this.TraducirAST(Nodo.Hijos[1]);
                let exp2= this.TraducirAST(Nodo.Hijos[2]);
                
                var FOR="for("+dec+exp1+";"+exp2+"){ }";
            }else if (tamnodos==4){
                let dec = this.TraducirAST(Nodo.Hijos[0]);
                let exp1= this.TraducirAST(Nodo.Hijos[1]);
                let exp2= this.TraducirAST(Nodo.Hijos[2]);  
                let instrucciones=this.TraducirAST(Nodo.Hijos[3]); 
                var FOR="for("+dec+exp1+";"+exp2+"){\n"+instrucciones+"\n}";
            }
            return FOR
        }else if (Nodo.Valor=="DOWHILE"){
            var tamnodos = Nodo.Hijos.length;
            if(tamnodos==1){
                let dec = this.TraducirAST(Nodo.Hijos[0]);

                
                var DOWHILE="do{}while("+dec+");";
            }else if (tamnodos==2){
                let instrucciones=this.TraducirAST(Nodo.Hijos[0]); 
                let condicion = this.TraducirAST(Nodo.Hijos[1]);
                var DOWHILE="do{\n"+instrucciones+"\n}while("+condicion+");";
            }
            return DOWHILE
        }else if (Nodo.Valor=="WHILE"){
            var tamnodos = Nodo.Hijos.length;
            if(tamnodos==1){
                let dec = this.TraducirAST(Nodo.Hijos[0]);
                var WHILE="while("+dec+"){\n}";
            }else if (tamnodos==2){
                let condicion = this.TraducirAST(Nodo.Hijos[0]);
                let instrucciones=this.TraducirAST(Nodo.Hijos[1]); 
                var WHILE="while("+condicion+"){\n"+instrucciones+"\n}";
            }
            return WHILE
        }else if (Nodo.Valor=="BREAK"){
            var BREAK = "break;"
            return BREAK
        }else if (Nodo.Valor=="ERROR"){
            var ERROR = ""
            return ERROR
        }else if (Nodo.Valor=="CONTINUE"){
            var CONTINUE = "continue;"
            return CONTINUE
        }else if (Nodo.Valor=="RETURN"){
            let expresion = this.TraducirAST(Nodo.Hijos[0]);
            var RETURN = "return " + expresion +";";
            return RETURN
        }else if (Nodo.Valor=="PRINT"){
            let expresion = this.TraducirAST(Nodo.Hijos[0]);
            var PRINT = "console.log(" + expresion +");";
            return PRINT
        }else if (Nodo.Valor=="LLAMADA"){
            var tamnodos = Nodo.Hijos.length;

            if(tamnodos==1){
                let nombre = Nodo.Hijos[0].Valor;
                var LLAMADA = "function " + nombre +"( );"
            }else if (tamnodos==2){
                let nombre = Nodo.Hijos[0].Valor;
                let parametros = this.TraducirAST(Nodo.Hijos[1]);
                var LLAMADA = "function " + nombre +"( "+parametros+" );"
            }

            return LLAMADA
        }else if (Nodo.Valor == "LISTAPARAMETROSVALOR") {
            var tamnodos = Nodo.Hijos.length;

            if(tamnodos==1){
                var LISTAPARAMETROSVALOR= this.TraducirAST(Nodo.Hijos[0]);

            }else if (tamnodos ==2){
                let lista= this.TraducirAST(Nodo.Hijos[0]);
                let parametros= this.TraducirAST(Nodo.Hijos[1]);

                var LISTAPARAMETROSVALOR= lista+","+parametros;
            }

            return LISTAPARAMETROSVALOR
        }else if (Nodo.Valor == "PARAMETROSVALOR") {

            var PARAMETROSVALOR = this.TraducirAST(Nodo.Hijos[0]);


            return PARAMETROSVALOR

        }





        //-------------------Metodos---------------------------

        // return CodigoTraduccion
    }


}
module.exports = AST;
module.exports.CodigoGraphviz=CodigoGraphviz;