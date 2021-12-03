import processing.serial.*;
import java.awt.Rectangle;
import java.awt.Graphics;
import java.awt.Graphics2D;
import javax.swing.*;
import java.awt.Color;
import javax.swing.JComponent;

Serial myPort;
String val;


JFrame gameFrame = new JFrame("Snake");
final int FRAME_WIDTH = 1200;
final int FRAME_HEIGHT = 1200;

SnakeComponent snake;

final int frameChange = 20;
int frame = 0;

int value = -1;


void setup() {
  //fullScreen();
  
  snake = new SnakeComponent();
  
  gameFrame.setSize(FRAME_WIDTH,FRAME_HEIGHT);
  gameFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
  gameFrame.setVisible(true);
  gameFrame.add(snake);
  
  println("Available Serial Ports: ");
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  if (myPort.available() > 0) {
    val = myPort.readStringUntil('\n'); //read input from arduino (the println statement)
  }
  //println(val);
  
  if(frame >= frameChange)
  {
    
    snake.moveComponent(0,-50);
    
    frame = 0;
  }
  frame++;
}

class SnakeComponent extends JComponent
{
  private Rectangle snake;
  
  SnakeComponent(){
    snake = new Rectangle(FRAME_WIDTH/2-25,FRAME_HEIGHT/2-25,50,50);
  }
  
  void paintComponent(Graphics g){
     super.paintComponent(g);
        Graphics2D g2 = (Graphics2D) g;
        g2.setColor(Color.RED);
        g2.fill(snake);
        
  }
  
  void moveComponent(int x, int y) {
    snake.translate(x,y);
    repaint();
  }
  
  int getSnakeX(){
    return (int) snake.getX();
  } 
  
  int getSnakeY(){
    return (int) snake.getY();
    val = myPort.readString(); //read input from arduino (the println statement)
  }
}
