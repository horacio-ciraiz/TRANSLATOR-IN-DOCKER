const Nodo = require('./NodoAST');

class NodoObjeto{

    constructor(Nodo,lexico,sintactico,tokens){
        this.Nodo=Nodo;
        this.lexico=lexico;
        this.sintactico=sintactico;
        this.tokens=tokens;
    }

}
module.exports = NodoObjeto;