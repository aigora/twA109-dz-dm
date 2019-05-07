
import processing.serial.*;//Importamos la librería Serial
Serial puertoArduino; //Nombre del puerto serie
//Declaracion de variables
int x = 65, ancho = 700, alto = 600;
boolean p = true;
int cFondo = 240; //Color fondo

PrintWriter datos;//Para crear el archivo de texto donde guardar los datos

// Declarar y construir un objeto (llamado g) de la class(clase) Graf
//Una class(clase) es un compuesto de campos (datos) y métodos (funciones que forman parte de la class) que pueden crearse como objetos.  
//La primera letra del nombre de una class suele estar en mayúsculas para separarla de otros tipos de variables.
//En este caso el nombre de la class seria "Graf"
Graf g = new Graf(ancho, alto, cFondo);


void setup (){
 //Con esta función, Processing crea una ventana de X píxeles por Y píxeles. En esta ventana crearemos nuestro entorno gráfico.
  size(700, 600);
 
  background(240); //Determina el color del fondo de la ventana creada
  
  puertoArduino= new Serial(this, "COM3", 9600);  // Aqui poner la COM del arduino que en nuestro caso es 3
  puertoArduino.bufferUntil('\n');

// Guardaremos los datos muestreados en un archivo de texto

  datos = createWriter("angulos.txt"); 
   //Con "fill" indica el color de lo que esta bajo él
  fill(0, 0, 255);
  
  text("Angulo en grados: ", 20, 40);//Escribe un texto en la posición X, Y deseada.
  text("Muestras", ancho / 2, alto - 20);//Escribe un texto en la posición X, Y deseada.
  g.cuadricula();//Iremos a la funcion "void cuadricula()" que esta dentro de "class Graf"
 
}

void draw()
{
  //String es una cadena que almacena una gran variedad de caracteres.
  String inString = puertoArduino.readStringUntil('\n'); //Lee el dato y lo almacena en la variable "inString"
   if (inString != null)//si inString distinti de null
   {
     //trim elimina los caracteres de espacio en blanco del principio y final de una cadena.
      inString = trim(inString);
      float val = float(inString);      
      datos.print(val + " º    "); // copia el dato en medidas.txt     
      g.puntos(x, val, p); //Iremos a la funcion "void puntos()" que esta dentro de "class Graf"
      p = false;
      x = x + 20;//va sumando de 20 en 20
      if (x > ancho - 60) //si supera el ancho de la grafica, lo borraremos y crearemos una nueva
       {
         x = 60;
         g.borra();      //Iremos a la funcion "void borra()" que esta dentro de "class Graf"
         g.cuadricula(); //Iremos a la funcion "void cuadricula()" que esta dentro de "class Graf"
         p = true;
       }        
    }
}    

void keyPressed() //Presionar 'ESC' para salir
{    
    datos.flush();   // Escribe los datos restantes en el archivo
    datos.close();  // Final del archivo
    exit();  //Salimos del programa
}



class Graf 
{
//declaración de variables
  int nX, nY, colF;
  float coordAntX, coordAntY;
  
  Graf (int x, int y, int cF)
  {
    nX = x;// se almacena el valor en la variable "nX", en el que tendria 700
    nY = y; // se almacena el valor en la variable "nY",en el que tendria 600
    colF  = cF;// se almacena el valor en la variable "colF",en el que tendria 240
  }
  
  void cuadricula()
  {
    
    stroke(0);   //permite cambiar el color, después de stroke tendrá el color de este.
    
    for (int  j = 60 ; j <= nX - 60; j = j + 20)
      {
       //Crear líneas. Los dos primeros valores son la primera coordenada X, Y. Los dos últimos valores son la última coordenada X, Y.
        line (j, 60, j, nY - 60);      
       } // Creamos lineas verticales
    for (int  j = 60 ; j <= nY - 60; j = j + 20)
      {
      line (60, j, nX - 60, j);
      } //Creamos lineas horizontales
 
  }
  
  void borra()
  {
    fill(colF); // Color del fondo
    noStroke(); //Sin trazos (bordes)
    rectMode(CORNERS);
    rect(50 , 50, nX , nY - 30 );// Los dos primeros valores es la posición X, Y en el gráfico. Los dos últimos valores son la anchura y la altura respectivamente.
  }
  
  void puntos(int x, float nValor, boolean primera)
    {
      
      fill(255,255,255);
      rectMode(CORNERS); 
      //Borra lectura anterior.
      rect(140,25,200,45);//Los dos primeros valores es la posición X, Y en el gráfico. Los dos últimos valores son la anchura y la altura respectivamente.
      fill (0,0,255);
      text(nValor, 142, 40); //Escribe el valor de la variable "nValor" en la posición X, Y deseada.
      fill(0, 0, 255);
      float v = map(nValor, 0, 1023, nY - 60, 60); //Mapeo inverso entre 
                                               //los margenes sup e inf.    
      ellipse(x, v-250, 5, 5);//Creamos puntos
      
      //Une los dos puntos con una linea excepto en la primera lectura.
      if (primera == false)
       { 
        line (coordAntX, coordAntY-250, x, v-250);
        
       }
       //guardamos la cordenada del ultimo punto para crear una linea continua
        coordAntX = x;
        coordAntY = v;          
    }


}
