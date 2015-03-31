/************************************************************************************************************************************************
  Author: Andrew McCormack
  Student ID: C13569113
  Date: 11/04/2014
  Summary: The objective of this game is to avoid the yellow birds while collecting the red and blue birds. The red birds give the player points
           while the blue ones give the player lives. Player movement is done using the left and right arrow keys. The game gets increasingly 
           faster and thus harder as more points are gained.
***********************************************************************************************************************************************/  

//The minim library allows for music to be played
import ddf.minim.*;

lines start;
Sprites dog;
Sprites enemy;

float playerX, playerY, rectSize, widthBox, heightBox, left, right;

boolean started, caught, paused;

int lives, points, fps;
int counter = 0;

float speed = 3.0;

char again;

PImage bg1, bg2, bg3, bg4, redStatic, yellowStatic, blueStatic;
PFont font, font2, font3;

AudioPlayer player;
AudioPlayer[] efx;
Minim minim;//audio context

void setup()
{
  size (1920, 1080);
  
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

void draw()
{  
  fpsCheck();
  
  frameRate(fps);  
  
  lives = start.lives;
  
  game();
}

//This method increases the fps while it's less than 500 if the score is a multiple of 2 (i.e. every 2 points that are collected) and only if the
//score in the score from the previous run of the program was different (to stop fps constantly increasing while score is a multiple of 2.
void fpsCheck()
{ 
  if (fps < 500)
  {
    if (((start.points % 2) == 0) && (start.points != 0) && (points != start.points))
    {
      fps += 20;
    }
  }
  points = start.points;
}

void game()
{
  if (started == false && paused == false)
  {
    background(bg3);
    fill(0);
    textFont(font, (width / 9));
    text("Press enter to start!", (width / 6), 100);
    
    fill(255, 0, 0);
    text("Collect these ", (width * 0.01), height - 310);
    image(redStatic, width / 4.5, height - 250);
    image(blueStatic, width / 4.5, height - 150);
    
    fill(255, 255, 0);
    text("Avoid these", width * 0.57, height - 310);
    image(yellowStatic, width * 0.75, height - 250);
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

void player()
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

void keyReleased()
{
  if (key == CODED)
  {
    if (keyCode == LEFT)
    {
      speed = 3.0;
      left = 0;
    }
    if (keyCode == RIGHT)
    {
      speed = 3.0;
      right = 0; 
    }
  }
}

void keyPressed()
{
  if (keyCode == LEFT && speed < 30)
  {
    if (playerX > 0)
    { 
      left = 1;
      speed += 0.3;
    }
  }
  
  else if (keyCode == RIGHT && speed < 30)
  {
    if ((playerX + rectSize) < width)
    {
      right = 1;
      speed += 0.3;
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

void displayHud()
{
  textFont(font2, (width / 22));
  fill(255);
  text("Press p to pause", width / 3, 40);
  text("Score: " + points, 0, height - 10);
  text("Lives: " + lives, 0, height - 50);
}
  
void loadSounds()
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

void loadFonts()
{
  font = loadFont("Bombing-48.vlw");
  font2 = loadFont("ArcadeClassic-48.vlw"); 
  font3 = loadFont("MotherInLaw-48.vlw");
}

void loadImages()
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
