
volatile int counter = 0;
void setup() {
  attachInterrupt(digitalPinToInterrupt(2), magDetect, RISING);
  // put your setup code here, to run once:
  Serial.begin(9600);
}
void magDetect() {
  counter ++; 
   
}

void loop() {
  // put your main code here, to run repeatedly:

 // attachInterrupt(digitalPinToInterrupt(12), magDetect, RISING);
  Serial.print(counter);
  Serial.print(" ");
  Serial.println(digitalRead(2));
}



