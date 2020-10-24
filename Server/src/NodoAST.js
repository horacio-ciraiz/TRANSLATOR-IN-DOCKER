class NodoAST{
    constructor(Valor,Tipo){
        this.Valor=Valor;
        this.Tipo=Tipo;
        this.Hijos = [];
        this.ID=0;
    }

    getValor(){
        this.Valor;
    }
    getTipo(){
        this.Tipo;
    }
    addHijos(Hijos){
        this.Hijos.push(Hijos);
    }

}
module.exports = NodoAST;