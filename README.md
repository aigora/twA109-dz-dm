# TITULO: Controlar el ordenador con sensores

Consiste en controlar el ordenador con gestos usando sensores de ultrasonido.

## Integrantes del equipo

-Dewei Zhou (usuario GitHub: dzhou1999)

-David Martinez Prieto (usuario GitHub: davidmartinezprieto)

## Objetivos del trabajo

-Aprender a usar Arduino.

-Aprender a manejar sensores.

-Ampliar nuestro conocimiento sobre programación.

-Aprender a manejar diferentes aplicaciones (Dev c++, Software de Arduino, Matlab, etc.).

-Saber como intercambiar informacion entre la placa de Arduino y el ordenador.

## Sensores y actuadores que vamos a utilizar
-Dos sensores de ultrasonido.

-No utilizaremos actuadores.

## Funciones

void setup()
{
 Serial.begin();

}

void loop(){
 
}

## Resumen del trabajo

El proyecto consiste en controlar ciertas funciones del ordenador moviendo la mano delante de unos sensores, que en este caso utilizaremos dos sensores de ultrasonido conectados a la placa de Arduino. Utilizaremos el programa de Arduino combinado con Python. 
 El sensor detectará la distancia que hay entre el sensor y la mano, y los datos se enviarán desde la placa de Arduino al ordenador a través del puerto serie (USB). Python leerá estos datos y, según los datos de lectura, se realizará cierta acción en el ordenador.  Para poder realizar las acciones en nuestro ordenador es necesario importar tres módulos en Python llamado pyautogui, serial y time.
El primer sensor de ultrasonido estará conectado a los pines  2, 3 y el pin de 5V.  El sengundo sensor de ultrasonido estará conectado a los pines 4,5 y el pin IOREF que también tendrá 5V.


