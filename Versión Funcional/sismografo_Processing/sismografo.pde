import processing.serial.*;

Serial myPort;        // El puerto serie
int xPos = 1;         // posición horizontal de la gráfica

// Variables para dibujar una línea continua.
int lastxPos=1;
int lastheight=0;

boolean nuevoDato = false;

Float dato = 0.0;
Float ultimoDato = 0.0;

Float umbral = 100.0; // Umbral para cambios.
  
PrintWriter log;

void setup () {
  
  // establecer el tamaño de la ventana:
  size(1800, 400);     
  
  log = createWriter("log.csv"); //Logger


 // Listar todos los puertos seriales disponibles
  
   // Compruebe los puertos seriales listados en la máquina
   // y usar el número de índice correcto en Serial.list () [].

  myPort = new Serial(this, "COM3", 9600);  // Aqui poner la COM del arduino

  // A serialEvent() se genera cuando se recibe un carácter de nueva línea:
  myPort.bufferUntil('\n');
  background(0);     // establecer background inicial:
}
void draw () {
   
  if (nuevoDato)
  {
    
    
    nuevoDato = false;
    stroke(127,34,255);     //color del trazo
    strokeWeight(1);        // trazo más ancho
    line(lastxPos, lastheight, xPos, height - dato); 
    lastxPos= xPos;
    lastheight= int(height-dato);

    // en el borde de la ventana, vuelve al principio:
    if (xPos >= width) {
      xPos = 0;
      lastxPos= 0;
      background(0);  // Borrar la pantalla.
    } 
    else {
    // incrementa la posición horizontal:
      xPos++;
    }
  }
}

void serialEvent (Serial myPort) {
 
  String inString = myPort.readStringUntil('\n');
  //System.out.println(inString);
  if (inString != null) {
    inString = trim(inString);                // recortar espacios en blanco.
    dato = float(inString);           // convertir a un número.
    
    
    //log.println(millis()+","+dato);
      log.println(hour()+":"+minute()+":"+second() +" , "+dato);
    
    
    if (dato > (ultimoDato + umbral) || dato < (ultimoDato - umbral))
    {
      dato = map(dato, 0, 1023, 0, height); // mapear a la altura de la pantalla.
      ultimoDato = dato;
      nuevoDato = true;
      
    }
    
  }
}

void exit() {
  
 
  log.flush(); // Escribe los datos restantes en el archivo
  log.close(); // Finaliza el archivo
  
  println("CErrado");
  super.exit();
}
