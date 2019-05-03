const int trigger1 = 2; //Trigger Pin del sensor
const int echo1 = 3; //Echo pin del sensor
float time_taken;
float dist,distL;
int valpwm;
float valtemp;
 
void setup() {
 // inicializar la comunicación serial a 9600 bits por segundo:
  Serial.begin(9600);
  pinMode(trigger1, OUTPUT); 
  pinMode(echo1, INPUT); 
 
}
 
// la rutina de bucle se ejecuta una y otra vez para siempre:
void loop() {
  digitalWrite(trigger1, LOW);
  delayMicroseconds(2);
  digitalWrite(trigger1, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigger1, LOW);
  time_taken = pulseIn(echo1, HIGH);
  dist= time_taken*0.034/2;
 
  valtemp = (dist*2500.00)/2023.00;
  delay(1);
  Serial.println(valtemp);
  delay(5);
   
}
