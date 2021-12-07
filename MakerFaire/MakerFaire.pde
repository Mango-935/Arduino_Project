import processing.serial.*;
import java.awt.Rectangle;
import java.awt.Graphics;
import java.awt.Graphics2D;
import javax.swing.*;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.event.KeyEvent;
import javax.swing.JComponent;
import java.awt.event.KeyListener;
import java.util.ArrayList;

Serial myPort;
String val = "";
int score = 0;

boolean foodEaten = false;

JFrame gameFrame = new JFrame("Snake");
JFrame endFrame = new JFrame("Game Over");
final int FRAME_WIDTH = 1225;
final int FRAME_HEIGHT = 1220;
final int SCALE = 50;

GameComponent game;

final int frameChange = 10;
int frame = 0;

int value = -1;

final JLabel gameOverText = new JLabel ("Game Over, Rerun the program to play again");

KeyListener keyListenerTest = new SnakeMoveListener();

void setup() {
<<<<<<< HEAD
=======
  //fullScreen();
>>>>>>> 422067c907a052c0d7ff905df354d341f768b491
  
  game = new GameComponent();
  
  gameOverText.setPreferredSize(new Dimension(500,500));
  gameOverText.setFont(new Font("Verdana", Font.PLAIN, 45));
  
  gameFrame.setSize(FRAME_WIDTH,FRAME_HEIGHT);
  gameFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
  gameFrame.add(game);
  gameFrame.addKeyListener(keyListenerTest);
  gameFrame.setVisible(true);
  
  endFrame.setSize(FRAME_WIDTH,FRAME_HEIGHT);
  endFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
  endFrame.setVisible(false);
  endFrame.add(gameOverText);
  
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
    
    if(foodEaten)
    {
      if (val.equals("1")){
       game.addToSnake(50,0);
       game.moveFoodComponent();
       foodEaten = false;
      }
      else if(val.equals("2")){
        game.addToSnake(0,50);
        game.moveFoodComponent();
        foodEaten = false;
      }
      else if(val.equals("3")){
        game.addToSnake(0,-50);
        game.moveFoodComponent();
        foodEaten = false;
      }
      else if(val.equals("4")){
        game.addToSnake(-50,0);
        game.moveFoodComponent();
        foodEaten = false;
      }
      else{
        game.addToSnake(0,0);
        game.moveFoodComponent();
        foodEaten = false;
      }
      score++;
      println("Score: " + score);
    }
    else if (!foodEaten)
    {
      if (val.equals("1")){
       game.moveSnakeComponent(50,0);
      }
      else if(val.equals("2")){
        game.moveSnakeComponent(0,50);
      }
      else if(val.equals("3")){
        game.moveSnakeComponent(0,-50);
      }
      else if(val.equals("4")){
        game.moveSnakeComponent(-50,0);
      }
      else{
        game.moveSnakeComponent(0,0);
      }
    }
    
    if((Math.abs(game.getSnakeX() - game.getFoodX()) <= 5) && (Math.abs(game.getSnakeY() - game.getFoodY()) <= 5))
    {
     foodEaten = true;
    }
    
    frame = 0;
  }
  
  

  
  if(game.gameOver() && !foodEaten)
  {
     val="-1";
     game.moveSnakeComponent(0,0);
     gameFrame.setVisible(false);
     endFrame.setVisible(true);
     noLoop();
  }
  
  frame++;
}

class SnakeMoveListener implements KeyListener
{
  public void keyPressed(KeyEvent e)
  {
    if(e.getKeyCode() == KeyEvent.VK_UP && !(val.equals("2")))
    {
      val = "3";
    }
    else if(e.getKeyCode() == KeyEvent.VK_DOWN && !(val.equals("3")))
    {
      val = "2"; 
    }
    else if(e.getKeyCode() == KeyEvent.VK_RIGHT && !(val.equals("4")))
    {
      val = "1"; 
    }
    else if(e.getKeyCode() == KeyEvent.VK_LEFT && !(val.equals("1")))
    {
      val = "4"; 
    }
  }
  
  public void keyTyped(KeyEvent e)
  {
    
  }
  
  public void keyReleased(KeyEvent e)
  {
    
  }
}

class GameComponent extends JComponent
{
  private Rectangle food;
  
  ArrayList<Rectangle> theSnake = new ArrayList<Rectangle>();
  
  
  GameComponent(){
    theSnake.add(new Rectangle((12*SCALE),3*SCALE,50,50));
    
    food= new Rectangle(FRAME_WIDTH-75-450,FRAME_HEIGHT-120-450,50,50);
  }
  
  void paintComponent(Graphics g){
     super.paintComponent(g);
      Graphics2D g2 = (Graphics2D) g;
      g2.setColor(Color.RED);
      for(int i = 0; i < theSnake.size();i++)
      {
        g2.fill(theSnake.get(i));
      }
      
      g2.setColor(Color.BLUE);
      g2.fill(food);
  }
  
  void moveSnakeComponent(int x, int y) {
    int pastSnakeX = (int) theSnake.get(0).getX();
    int pastSnakeY = (int) theSnake.get(0).getY();
    for(int i = 0; i < theSnake.size();i++)
    {
      if(i==0)
       theSnake.get(i).translate(x,y);
      else
      {
        int tempValX = (int) theSnake.get(i).getX();
        int tempValY = (int) theSnake.get(i).getY();
         theSnake.get(i).setLocation(pastSnakeX,pastSnakeY);
         pastSnakeX = tempValX;
         pastSnakeY = tempValY;
      }
    }
    //snake.translate(x,y);
    repaint();
  }
  
  void addToSnake(int x, int y){
    if(theSnake.size() > 1)
    {
      int lastSnakeX = (int) theSnake.get(theSnake.size() - 1).getX();
      int lastSnakeY = (int) theSnake.get(theSnake.size() - 1).getY();
      
      moveSnakeComponent(x,y);
      theSnake.add(new Rectangle(lastSnakeX,lastSnakeY,50,50));
    }
    else
    {
      int lastSnakeX = (int) theSnake.get(0).getX();
      int lastSnakeY = (int) theSnake.get(0).getY();
      
      moveSnakeComponent(x,y);
      theSnake.add(new Rectangle(lastSnakeX,lastSnakeY,50,50));
    }
    
    repaint();
  }
  
  boolean gameOver(){
    for(int i = 1;i < theSnake.size() && theSnake.size() > 1;i++){
      int tempSnakeX = (int) theSnake.get(i).getX();
      int tempSnakeY = (int) theSnake.get(i).getY();
      if((getSnakeX() == tempSnakeX) && (getSnakeY() == tempSnakeY))
      {
        return true;
      }
    }
    
    if(getSnakeX() < 0 || getSnakeX() > 1175 || getSnakeY() < 0 || getSnakeY() > 1170)
    {
      return true; 
    }
    return false;
  }
  
  void moveFoodComponent(){
    int randomX = ((int) (Math.random() * 24)) * SCALE - 100;
    int randomY = (int) ((Math.random() * 24)) * SCALE - 150;
    if(randomX < 0)
    {
      randomX = 0; 
    }
    if(randomY < 0)
    {
      randomY = 0; 
    }
    food = new Rectangle(randomX,randomY,50,50);
    repaint();
  }
  
  int getSnakeX(){
    return (int) theSnake.get(0).getX();
  } 
  
  int getSnakeY(){
<<<<<<< HEAD
    return (int) theSnake.get(0).getY();
  }
  
  int getFoodX(){
    return (int) food.getX();
  }
  
  int getFoodY(){
   return (int) food.getY(); 
=======
    return (int) snake.getY();
    val = myPort.readString(); //read input from arduino (the println statement)
>>>>>>> 422067c907a052c0d7ff905df354d341f768b491
  }
}

//class FoodComponent extends JComponent {
//  private Rectangle food;
  
//  FoodComponent(){
//    int randomX = (int) (Math.random() * 24);
//    int randomY = (int) (Math.random() * 24);
//    food = new Rectangle((randomX*50)-25,randomY*50,50,50);
//  }
  
//  void paintComponent(Graphics g){
//     super.paintComponent(g);
//      Graphics2D g2 = (Graphics2D) g;
//      g2.setColor(Color.BLUE);
//      g2.fill(food);
//  }
  
//  void moveFoodComponent(){
//    int randomX = (int) (Math.random() * 24);
//    int randomY = (int) (Math.random() * 24);
//    food = new Rectangle((randomX*50)-25,randomY*50,50,50);
//  }
//}
