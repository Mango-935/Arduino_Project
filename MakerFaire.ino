//#include <LiquidCrystal.h>
//LiquidCrystal lcd();
const int b1 = 2; //button 1
const int b2 = 3; //button 2
const int b3 = 4; //button 3
const int b4 = 5; //button 4
int sb1 = 0; //button 1 value
int sb2 = 0; //button 2 value
int sb3 = 0; //button 3 value
int sb4 = 0; //button 4 value
int prev_dir = 0; //previous direction


void setup() {
  Serial.begin(9600);
  
  //initialize button pins
  pinMode(b1, INPUT);
  pinMode(b2, INPUT);
  pinMode(b3, INPUT);
  pinMode(b4, INPUT);
}

void loop() {
  //reads button values
  sb1 = digitalRead(b1);
  sb2 = digitalRead(b2);
  sb3 = digitalRead(b3);
  sb4 = digitalRead(b4);
  /*
  //reads score value
  if (Serial.available()) //if data is available to read
    
  */
  //determine current direction
  int dir = 0;
  if (sb1 == HIGH && prev_dir != 1 && prev_dir != 4)
    dir = 1; //right
  if (sb2 == HIGH && prev_dir != 2 && prev_dir != 3)
    dir = 2; //down
  if (sb3 == HIGH && prev_dir != 3 && prev_dir != 2)
    dir = 3; //up
  if (sb4 == HIGH && prev_dir != 4 && prev_dir != 1)
    dir = 4; //left

  if (dir == 0)
    dir = prev_dir; //if no direction is inputted, use previous direction
  else
    prev_dir = dir; //if new direction is inputted, use new direction

  Serial.println(dir);


  delay(1);
}
