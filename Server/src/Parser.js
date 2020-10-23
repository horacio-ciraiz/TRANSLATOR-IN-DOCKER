var parser = require('./Gramatica');
data="public class af2 { public void metodo1(int x,int y){ } \n "
+"} \n public class af2 { }"


parser.parse(data);
console.log("Entre");