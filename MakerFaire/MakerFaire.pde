import processing.serial.*;
Serial myPort;
String val;

void setup() {
  //fullScreen();
  
  
  println("Available Serial Ports: ");
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  if (myPort.available() > 0) {
    val = myPort.readString(); //read input from arduino (the println statement)
  }
  println(val);
}
