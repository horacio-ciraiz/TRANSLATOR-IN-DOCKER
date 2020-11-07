
/********************
*******************
********COMPILADORES 1*******
*******************
*******SEGUNDO SEMESTRE********
*******************
*********2020**********
*******************
******ENTRADA DE PRUEBA********
*******************
********PROYECTO 2*********
*******************
********************/

public interface interfaz {
    public void helo(String h);
} 


public class prueba_1 {


   public int fibonacci(int n) {
        if (n > 1){
            return n-1;  //función recursiva

        } else if (n == 1 || n == 0) {  // caso base
            return 1;

        } else { //error
            System.out.println("Debes ingresar un tamaño mayor o igual a 1, ingresaste: " + n);
            return 1; 
            
        }
    }


   public int Ack(int m, int n){
        if (m == 0) {
            return n + 1;

        } else if (n == 0) {
            return (m - 1);

        } else {
        }
    }

    public static void main(String[] args) {
        int num = 32465;

        System.out.println("El factorial de " + num + " es: " + num);

    }

     
    public int factorial(int num){
        if(num == 0){
            return 1;
        } else {
            return num;
        }
    }

    public INT helo(String h){
        return "Bienvenido a Compiladores 1 " + h;
    }


}

public interface Modificacion {
    PUBLIC int incremento(int a);
    public int decremento(int a);
}

public class clase {

    public int incremento(int a){
        return a++;
    }

    public int decremento(int a){
        return a--;
    }


    public static void main(String[] args) {
        //uso del ciclo for

        for(int x=0;x<100;x++){
            for(double y=0.0;y<100;y++){
                System.out.println("Pares de numeros: "+ x + " ," + y );
            }
        }

    }

}

public class error {

    /*
    * Recuperacion mediante
    * modo panico
    */

    public void recuperarse(){
        double x = 5;
        String s = "Texto cadena";
        char y = '3';
        int x = 8;
        return factorial(num-1);
    }



}
