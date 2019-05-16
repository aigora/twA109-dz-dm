const int trigger1 = 2; //Trigger Pin del sensor
const int echo1 = 3; //Echo pin del sensor
float tiempo,angulo_grado;
float dist,dist2;

void setup() {
 // inicializar la comunicación serial a 9600 bits por segundo:
  Serial.begin(9600);
  pinMode(trigger1, OUTPUT); //output (de salida)
  pinMode(echo1, INPUT); // input (de entrada)
 
}
 
// la rutina de bucle se ejecuta una y otra vez para siempre:
void loop() {
  digitalWrite(trigger1, LOW); //Para generar un pulso limpio, ponemos a LOW a 2us
  delayMicroseconds(2);
  digitalWrite(trigger1, HIGH);//Genera Trigger (disparo) de 10 us
  delayMicroseconds(10);
  digitalWrite(trigger1, LOW);
  tiempo = pulseIn(echo1, HIGH); //Medimos el tiempo entre pulsos, en microsegundos
  dist= tiempo*0.034/2; //Calculamos y obtenemos la distancia entre el sensor y el objeto
  dist2=dist-30;//Situaremos el pendulo a 30cm del sensor
  //Si el pendulo esta a 30cm, obtendriamos un angulo de 0 grados
  if(dist2<30)
  {
  angulo_grado=asin((dist2)/30)*180/3.14;//angulo en grados

  Serial.println(angulo_grado);// Imprime los datos

  delay(50);//Retardo 
  } 

}
