var NodoContador = 1;
var CodigoGraphviz = "";
var CodigoTraduccion = "";
class AST {
    RecorrerAST(Nodo) {
        if (Nodo.ID == 0) {
            Nodo.ID = NodoContador;
            NodoContador++;
        }


        CodigoGraphviz += "S" + Nodo.ID + " [label = \"" + Nodo.Valor + "\" ];" + "\n"

        Nodo.Hijos.forEach(element => {

            CodigoGraphviz += "S" + Nodo.ID + " -> " + "S" + NodoContador + ";" + "\n";

            this.RecorrerAST(element);
        });
        return CodigoGraphviz;

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
                var LISTACLASE = LISTACLASES + TIPOCLASE;
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
                var CLASS = "class " + identificador + "{\n" + LISTACUERPOCLASS + "\n}";
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
                var LISTACUERPOCLASS = _LISTACUERPOCLASS + CUERPOCLASS;
            }
            return LISTACUERPOCLASS;
        } else if (Nodo.Valor == "CUERPOCLASS") {

            var CUERPOCLASS = this.TraducirAST(Nodo.Hijos[0]);

            return CUERPOCLASS
        } else if (Nodo.Valor == "METODOS") {
            var tamnodos = Nodo.Hijos.length;

            if (tamnodos == 3) {
                if (Nodo.Tipo == 1) {
                    let identificador = Nodo.Hijos[1].Valor;
                    let listaparametros = this.TraducirAST(Nodo.Hijos[2]);
                    var METODOS = "function " + identificador + "( " + listaparametros + " ) { \n\t} \n";


                } else if (Nodo.Tipo == 4) {
                    let identificador = Nodo.Hijos[1].Valor;
                    let listainstrucciones = this.TraducirAST(Nodo.Hijos[2]);
                    var METODOS = "function " + identificador + "( ) { \n " + listainstrucciones + "\n\t} \n";

                }

            } else if (tamnodos == 2) {
                let identificador = Nodo.Hijos[1].Valor;
                var METODOS = "function " + identificador + "( ) { }\n";

            } if (tamnodos == 4) {
                let identificador = Nodo.Hijos[1].Valor;
                let listaparametros = this.TraducirAST(Nodo.Hijos[2]);
                let listainstrucciones = this.TraducirAST(Nodo.Hijos[3]);
                var METODOS = "function " + identificador + "( " + listaparametros + " ) { \n " + listainstrucciones + "\n\t} \n";
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
            var LISTAINSTRUCCIONES = "HOLA"

            return LISTAINSTRUCCIONES

        }else if (Nodo.Valor == "DEC") {
            let listaidentificadores = this.TraducirAST(Nodo.Hijos[1]);
            var DEC = "var " + listaidentificadores+";\n";

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
        }else if (Nodo.Valor == "EXP") {
          var EXP = "2";

            return EXP

        }


        //-------------------Metodos---------------------------

        // return CodigoTraduccion
    }


}
module.exports = AST;