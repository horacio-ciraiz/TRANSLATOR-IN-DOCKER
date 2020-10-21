var parser = require('./Gramatica');
data="public class af2 {"
+ "public void PrimeroMetodo(){ } \n"
+" }"


parser.parse(data);
console.log("Entre");