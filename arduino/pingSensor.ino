import processing.serial.*;
Serial mySerial;
PrintWriter output;

#include <NewPing.h>
 
#define TRIGGER_PIN 12
#define ECHO_PIN 11

#define TRIGGER_PIN2 10
#define ECHO_PIN2 9
#define MAX_DISTANCE 200
 
NewPing sonar1(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
NewPing sonar2(TRIGGER_PIN2, ECHO_PIN2, MAX_DISTANCE);

int counter = 0;

void setup() {
  Serial.begin(9600);
  output = createWriter( "data.txt" );
}
 
void loop() {

  delay(50);
  int uS1 = sonar1.ping();
  int uS2 = sonar2.ping();
  Serial.print("Ping: L ");
  Serial.print(uS2 / US_ROUNDTRIP_CM);
  Serial.print("cm  R ");
  Serial.print(uS1 / US_ROUNDTRIP_CM);
  Serial.println("cm");

  if (mySerial.available() > 0 ) {
    String value = mySerial.readString();
    if ( value != null ) {
      output.println( value );
    }
  }

  counter ++;

  if (counter > 1000000) {
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    exit();  // Stops the program
  }
}
