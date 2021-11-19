import processing.serial.*;
Serial myPort;

final int b1 = 2;
final int b2 = 3;
final int b3 = 4;
final int b4 = 5;
int sb1 = 0;
int sb2 = 0;
int sb3 = 0;
int sb4 = 0;

void setup() {
  fullScreen();
  
  
  println("Available Serial Ports: ");
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  /*
  //sb1 = digitalRead(b1);
  //sb2 = digitalRead(b2);
  //sb3 = digitalRead(b3);
  //sb4 = digitalRead(b4);
  if (sb1 == HIGH) {
    Serial.print("1");
  }
  if (sb2 == HIGH) {
    Serial.print("2");
  }
  if (sb3 == HIGH) {
    Serial.print("3");
  }
  if (sb4 == HIGH) {
    Serial.print("4");
  }
  Serial.println("");
  delay(1);
  */
  sb1 = myPort.read();
  println(sb1);
  delay(1);
}
