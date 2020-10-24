var NodoUnico =1;
class AST{
    RecorrerAST(nodo){
        if(nodo.ID==0){
            nodo.ID = NodoUnico;
            NodoUnico++;
        }

        //PARA LOS NODOS
        console.log("S"+nodo.ID +' [label = "'+ nodo.Valor +'" shape = "circle"];');
        

        nodo.Hijos.forEach(element => {
            //TRANSICIONES
            console.log("S"+nodo.ID +' -> '+ "S"+NodoUnico +';');

            this.RecorrerAST(element);
        });


    }
    

}
module.exports = AST;