import processing.serial.*;
Serial myPort;
String val;
int score = 0;

void setup() {
  fullScreen();
  
  
  println("Available Serial Ports: ");
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  if (myPort.available() > 0) {
    val = myPort.readStringUntil('\n'); //read input from arduino (the println statement)
    //myPort.write(score); //send score to arduino
  }
  println(val);
}
