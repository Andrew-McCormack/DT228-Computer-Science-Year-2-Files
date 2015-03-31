import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BirdHunt extends PApplet {

/************************************************************************************************************************************************
  Author: Andrew McCormack
  Student ID: C13569113
  Date: 11/04/2014
  Summary: The objective of this game is to avoid the yellow birds while collecting the red and blue birds. The red birds give the player points
           while the blue ones give the player lives. Player movement is done using the left and right arrow keys. The game gets increasingly 
           faster and thus harder as more points are gained.
***********************************************************************************************************************************************/  

//The minim library allows for music to be played


lines start;
Sprites dog;
Sprites enemy;

float playerX, playerY, rectSize, widthBox, heightBox, left, right;

boolean started, caught, paused;

int lives, points, fps;
int counter = 0;

float speed = 3.0f;

char again;

PImage bg1, bg2, bg3, bg4, redStatic, yellowStatic, blueStatic;
PFont font, font2, font3;

AudioPlayer player;
AudioPlayer[] efx;
Minim minim;//audio context

public void setup()
{
  size (900, 800);
  
  rectSize = width / 10;
  playerX = ((width / 2) - (rectSize / 2));
  playerY = (height - rectSize);
    
  widthBox = width;
  heightBox = height;
  
  fps = 60;
  paused = false;
  
  start = new lines();
  dog = new Sprites();
  enemy = new Sprites();
  
  started = false;
  caught = false;

  loadSounds();
  loadFonts();    
  loadImages();  
}

public void draw()
{  
  fpsCheck();
  
  frameRate(fps);  
  
  lives = start.lives;
  
  game();
}

//This method increases the fps while it's less than 500 if the score is a multiple of 2 (i.e. every 2 points that are collected) and only if the
//score in the score from the previous run of the program was different (to stop fps constantly increasing while score is a multiple of 2.
public void fpsCheck()
{ 
  if (fps < 500)
  {
    if (((start.points % 2) == 0) && (start.points != 0) && (points != start.points))
    {
      fps += 10;
    }
  }
  points = start.points;
}

public void game()
{
  if (started == false && paused == false)
  {
    background(bg3);
    fill(0);
    textFont(font, (width / 9));
    text("Press enter to start!", (width / 6), 100);
    
    fill(255, 0, 0);
    text("Collect these ", (width * 0.01f), height - 310);
    image(redStatic, width / 4.5f, height - 250);
    image(blueStatic, width / 4.5f, height - 150);
    
    fill(255, 255, 0);
    text("Avoid these", width * 0.57f, height - 310);
    image(yellowStatic, width * 0.75f, height - 250);
  }
  
 else if (lives <= 0 && paused == false)
  {
    background(bg2);
    fill(255);
    stroke(0);
    textFont(font, (width / 11));
    text("You done woofed up!", (width / 5), 100);
    text("You scored " + points, (width / 3), (height - 200));
    text("Press space to try again", (width / 5), height - 100);
 }
 
 else if (lives > 0 && paused == true)
 {
   player.pause();

   background(bg4);
   textFont(font3, (width / 5));
   fill(0);
   text("Pawsed", (width / 10), height - 10);
   
 }
  
 else
 {
   background(bg1); 
   caught = start.run(playerX);
   player();
 }
} 

public void player()
{  
  // if both keys pressed, right - left is 0.
  // if left pressed 0 - 1 is -1 so negative x direction.
  // multiply this by speed to make the amount of
  // pixels moved equal to speed.
  if (playerX <= 0)
  {
    playerX += speed;
  }
  
  else if (playerX >= (width - rectSize))
  {
    playerX += -speed;
  }
  playerX += (right - left) * speed;
  
  if (caught == false)
  {
    dog.staticSprite(playerX, playerY);
  }
  
  else
  {
    caught = dog.moveSprite(playerX, playerY);
  }
}

public void keyReleased()
{
  if (key == CODED)
  {
    if (keyCode == LEFT)
    {
      speed = 3.0f;
      left = 0;
    }
    if (keyCode == RIGHT)
    {
      speed = 3.0f;
      right = 0;
    }
  }
}

public void keyPressed()
{
  if (keyCode == LEFT && speed < 30)
  {
    if (playerX > 0)
    { 
      left = 1;
      speed += 0.3f;
    }
  }
  
  else if (keyCode == RIGHT && speed < 30)
  {
    if ((playerX + rectSize) < width)
    {
      right = 1;
      speed += 0.3f;
    }
  }
  
  else if ((key == ' ') && (lives <= 0))
  {
    start.lives = 3;
    start.points = 0;
    fps = 60;
    start.resetPositions();
    playerX = (width / 2) - (rectSize / 2) - 5;
  }
  
  else if ((keyCode == ENTER) && (started == false))
  {
    started = true;
  } 
  
  else if ((key == 'p') && (lives > 0))
  {
    player.loop();
    paused = !paused;
  }
}

public void displayHud()
{
  textFont(font2, (width / 22));
  fill(255);
  text("Press p to pause", width / 3, 40);
  text("Score: " + points, 0, height - 10);
  text("Lives: " + lives, 0, height - 50);
}
  
public void loadSounds()
{
  minim = new Minim(this);
  player = minim.loadFile("gangstMusic.mp3", 2048);
  player.loop();
  
  efx = new AudioPlayer[4];
  efx[0] = minim.loadFile("0.mp3", 2048); 
  efx[1] = minim.loadFile("1.mp3", 2048);
  efx[2] = minim.loadFile("2.mp3", 2038);
  efx[3] = minim.loadFile("3.mp3", 2038);
}

public void loadFonts()
{
  font = loadFont("Bombing-48.vlw");
  font2 = loadFont("ArcadeClassic-48.vlw"); 
  font3 = loadFont("MotherInLaw-48.vlw");
}

public void loadImages()
{
  bg1 = loadImage("gangstaDawg.jpg");
  bg1.resize(width, height);
  bg2 = loadImage("gameOvaDawg.jpg");
  bg2.resize(width, height);
  bg3 = loadImage("splashScreenDawg.jpg");
  bg3.resize(width, height);
  bg4 = loadImage("pauseDawg.jpg");
  bg4.resize(width, height);
  
  redStatic = loadImage("Red_1.png");
  redStatic.resize((int)rectSize, (int)rectSize);
  yellowStatic = loadImage("Yellow_1.png");
  yellowStatic.resize((int)rectSize, (int)rectSize);
  blueStatic = loadImage("Blue_1.png");
  blueStatic.resize((int)rectSize, (int)rectSize);
}
class Sprites
{
  int frameDog, frameRed, frameYellow, frameBlue;
  int imageCountDog = 5;
  int imageCount = 3;
  
  boolean retCaught;

  PImage[] dog, red, yellow, blue;
  int m, n;
  int Timer = millis();

  final int WAIT_TIME = (int) (0.2f * 1000);
  int startTimeR, startTimeY, startTimeB;

  Sprites()
  {
    dog = new PImage[imageCountDog];
    red = new PImage[imageCount];
    yellow = new PImage[imageCount];
    blue = new PImage[imageCount];
    retCaught = false;
    m = 0;
    Timer = 0;
    

    for (int i = 0; i < imageCountDog; i++)
    {
      String filename = "PT_dog_" + i + ".png";
      dog[i] = loadImage(filename);
      // This and all other sprites are resized to rectSize, to make everything line up with the collision detection of my original prototype of
      // falling blocks. 
      dog[i].resize((int)rectSize, (int)rectSize);
    }

    for (int i = 0; i < imageCount; i++)
    {
      String filename = "Red_" + (i + 1) + ".png";
      red[i] = loadImage(filename);
      red[i].resize((int)rectSize, (int)rectSize);
    }

    for (int i = 0; i < imageCount; i++)
    {
      String filename = "Yellow_" + (i + 1) + ".png";
      yellow[i] = loadImage(filename);
      yellow[i].resize((int)rectSize, (int)rectSize);
    }

    for (int i = 0; i < imageCount; i++)
    {
      String filename = "Blue_" + (i + 1) + ".png";
      blue[i] = loadImage(filename);
      blue[i].resize((int)rectSize, (int)rectSize);
    }
  }

  // When the dog has not caught any birds
  public void staticSprite(float playerX, float playerY)
  {
    if (n <= 30)
    {
      frameDog = 3;
    } 

    else
    {
      if (n >= 60)
      {
        n = 0;
      }
      
      else
      {
        frameDog = 4;
      }
    }
  
    n++;
    image(dog[frameDog], playerX, playerY);
  }

  // When the dog has caught a bird
  public boolean moveSprite(float playerX, float playerY)
  { 
    // m will be 0 at the 1st instance of calling this method when a bird has been caught, the first frame will be loaded
    if (m == 0)
    {
      frameDog = 4;
      frameDog = (frameDog+1) % imageCountDog;
      retCaught = true;
    } 
    
    // When m has incremented 30 times, the second frame will be loaded
    else if ((m % 30) == 0)
    {
      frameDog = (frameDog+1) % imageCountDog;
      retCaught = true;
    }

    m++;

    // After the second frame has been loaded, caught will be set to false (no bird caught) and m will be set to 0 for the next instance of this method
    if (frameDog == 2)
    {
      retCaught = false;
      m = 0;
    }
    
    image(dog[frameDog], playerX, playerY);  
    return(retCaught);
  }

  
  public void red(float x, float y)
  {
      if (hasFinishedRed()) 
      {
        frameRed = (frameRed+1) % imageCount;
        startTimeR = millis();
      }
    image(red[frameRed], x, y);
  }

  public void yellow(float x, float y)
  {

    if (hasFinishedYellow()) 
      {
        frameYellow = (frameYellow+1) % imageCount;
        startTimeY = millis();
      }   
    image(yellow[frameYellow], x, y);
  }

  public void blue(float x, float y)
  {
      if (hasFinishedBlue()) 
      {
        frameBlue = (frameBlue+1) % imageCount;
        startTimeB = millis();
      }      
    
    image(blue[frameBlue], x, y);
  }
  
  
  public boolean hasFinishedRed() 
  {
    return millis() - startTimeR > WAIT_TIME;
  }
  
  public boolean hasFinishedYellow() 
  {
    return millis() - startTimeY > WAIT_TIME;
  }
  
  public boolean hasFinishedBlue() 
  {
    return millis() - startTimeB > WAIT_TIME;
  }
  
}

class blocks
{
  float x;
  float y;
  int enemyType;
  
  blocks(float _x, float _y)
  {
    x = _x;
    y = _y;
  }
  
  public void run(int _enemyType)
  {
    // if the current row is greater than the height of the screen then the row will be set to behinf the top of the screen and the objects in that row will be randomized again
    enemyType = _enemyType;
    if (y > height)
    {
      y = (-1 - rectSize);
    }
    
    display();
    move();
  }
  
  public void display()
  {
    if (enemyType == 1)
    {
      enemy.red(x, y);
    }
    
    else if (enemyType == 2)
    {
      enemy.yellow(x, y);
    }
    
    else if (enemyType == 3)
    {
      enemy.blue(x, y);
    }
    
    // If the object is none of the above it will be set to invisible
    else
    {
      rect(x, y, rectSize, rectSize);
    }
  }
  
  public void move()
  {
    y++;
  }
  
  public float retCurPos()
  {
    return y;
  }
  
}
class lines
{
  blocks[][] lines;
 
  float y, rectSize;
  boolean[][] onOff, goodBad, extraLife;
  int i, j;
  float counter;
  int counter2, lives, points;
  
  boolean retCaught;

  lines()
  {
    lines = new blocks[6][10];
    
    rectSize = width / 10;
    y = (0 - rectSize);
    
    lives = 3;
    points = 0;
     
     
    resetPositions();
    
    onOff = new boolean[10][6];
    goodBad = new boolean[10][6];
    extraLife = new boolean[10][6];
  }
  
  public boolean run(float playerX)
  {
    movingBlocks();
    retCaught = checkPlayer();
    displayHud();
    return (retCaught);
  }


public void resetPositions()
{
   for (i = 0; i < 10; i++)
    {   
        lines[0][i] = new blocks((rectSize * i), y);
        lines[1][i] = new blocks((rectSize * i), (y * 2));
        lines[2][i] = new blocks((rectSize * i), (y * 3));
        lines[3][i] = new blocks((rectSize * i), (y * 4));
        lines[4][i] = new blocks((rectSize * i), (y * 5));
        lines[5][i] = new blocks((rectSize * i), (y * 6));
    }
}

// This deals with setting the objects to the different types (visible, enemy, point, life birds) 
// and then sends this data to the blocks class where the row of different objects will be moved downwards
public void movingBlocks()
{
  for (j = 0; j < 6; j++)
  {
    
    counter = lines[j][0].retCurPos();
    
    if (counter == (0 - rectSize)  || counter == 0 - (rectSize * (i + 1)))
    {
      for (i = 0; i < 10; i++)
      {
        onOff[i][j] = false;
        goodBad[i][j] = false;
        extraLife[i][j] = false;
        if ((int) random(1, 10) > 7)
        {
          onOff[i][j] = true;
          if ((int) random(1,10) >= 8)
          {
             if ((int) random(1, 10) == 9)
             {
               extraLife[i][j] = true;
             }
             else
             {
               goodBad[i][j] = true;
             }
          }
  
          else
          {
             goodBad[i][j] = false;
          }       
        }
    
        else
        {
          onOff[i][j] = false;
        }    
      }
    }      
  }
 
  for (j = 0; j < 6; j++)
  {
    for (i = 0; i < 10; i++)
    {
      if ((onOff[i][j]) && (goodBad[i][j]))
      {
        lines[j][i].run(1);
      }
    
      else if ((onOff[i][j]) && ((goodBad[i][j]) == false) && ((extraLife[i][j]) == false))
      {
        lines[j][i].run(2);
      }
      
      else if ((onOff[i][j]) && ((goodBad[i][j]) == false) && ((extraLife[i][j]) == true))
      {
        lines[j][i].run(3);
      }
      
      else
      {
        noStroke();
        noFill();
        lines[j][i].run(4);
      }
      
    }
  } 
}

//This method checks the position of the player against the position of the other birds i.e. the collision detecton
public boolean checkPlayer()
{
  retCaught = false;
  for (j = 0; j < 6; j++)
  {
    if ((lines[j][0].retCurPos()) > (height - (rectSize * 2)))
    {
      for (i = 0; i < 10; i++)
      {
        if ((playerX > ((i * rectSize) - 20)) && (playerX < ((i * rectSize) - 20) + rectSize) || ((playerX + rectSize) > ((i * rectSize) + 20)) && ((playerX + rectSize) < ((i * rectSize) + 20) + rectSize))
        {
          if ((onOff[i][j]) && (goodBad[i][j])) 
          {
            onOff[i][j] = false;
            efx[0].rewind();
            efx[0].play();
            retCaught = true;
            points++;
          }
        
          else if ((onOff[i][j]) && (goodBad[i][j] == false) && (extraLife[i][j] == false))
          {
            onOff[i][j] = false;
            efx[1].rewind();
            efx[1].play();
            retCaught = true;
            lives--;
          }
          
          else if ((onOff[i][j]) && (extraLife[i][j]))
          {
            onOff[i][j] = false;
            efx[2].rewind();
            efx[2].play();
            retCaught = true;
            lives++;
          }
       
          else if (caught == true && retCaught == false)
          {
             retCaught = true;
          }   
        }
      }
    }
  }
  return retCaught;
}

  
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "BirdHunt" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
