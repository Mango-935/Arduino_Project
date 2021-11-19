const int b1 = 2;
const int b2 = 3;
const int b3 = 4;
const int b4 = 5;
int sb1 = 0;
int sb2 = 0;
int sb3 = 0;
int sb4 = 0;


void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT);
  pinMode(3, INPUT);
  pinMode(4, INPUT);
  pinMode(5, INPUT);
}

void loop() {
  sb1 = digitalRead(b1);
  sb2 = digitalRead(b2);
  sb3 = digitalRead(b3);
  sb4 = digitalRead(b4);
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
}
