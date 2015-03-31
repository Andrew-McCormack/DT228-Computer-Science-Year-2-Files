 import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

/*
    DIT OOP Assignment 2 Starter Code
    =================================
    
    Loads player properties from an xml file
    See: https://github.com/skooter500/DT228-OOP 
*/

ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Animations> animations = new ArrayList <Animations>();
Level level = new Level();
boolean[] keys = new boolean[526];
boolean startGame = false;
boolean pauseGame = false;

PFont font, font2;

AudioPlayer player;
AudioPlayer[] efx;
Minim minim;//audio context

void setup()
{
  size(1280, 1024, OPENGL);
  frameRate(200);
  noStroke();
  noSmooth();
  setUpPlayerControllers();
  loadSounds();
  loadFonts();
 }

void draw()
{
  background(90);

  if (!startGame)
  {
    menu();
  }
  
  else if (pauseGame)
  {
    pause(); 
  }
  
  else
  {
    background(220);
    players.get(1).disableMoveFrames = players.get(0).disableMoveFrames;
        
    if (players.get(0).currentLevel == 6)
    {
      fill(0);
      rect(0, 0, width, height);
      fill(255);
      textFont(font, 38);
      text("Player 1 wins!, press button 1 to return to main menu", 200, 500);
      
      if (checkKey(players.get(1).button1))
      {
         players.get(0).pos.x = width + 10;
         players.get(1).currentLevel = 2;
         players.get(0).currentLevel = 2;
         players.get(0).dead = false;
         players.get(0).finished = false;
         animations.get(0).count4 = 0;
         newLevelCleanUp();
         pauseGame = false;
         startGame = false;
      }
   }
  
    else if (players.get(1).currentLevel == 0)
    {
      fill(0);
      rect(0, 0, width, height);
      fill(255);
      textFont(font, 38);
      text("Player 2 wins! press button 1 to return to main menu", 200, 500);
      
      if (checkKey(players.get(0).button1))
      {
         players.get(0).pos.x = width + 10;
         players.get(1).currentLevel = 2;
         players.get(0).currentLevel = 2;
         players.get(0).dead = false;
         players.get(0).finished = false;
         animations.get(0).count4 = 0;
         newLevelCleanUp();
         pauseGame = false;
         startGame = false;
      }
    }
  
  
    else
    {
      for(int i = 0 ; i < players.size() ; i ++)
      {
        players.get(i).update();
        players.get(i).display();
      }
  
      if (players.get(0).dead && players.get(1).dead)
      {
        players.get(0).pos.x = width + 10;
      players.get(1).currentLevel = 2;
      players.get(0).currentLevel = 2;
      players.get(0).dead = false;
      players.get(0).finished = false;
      animations.get(0).count4 = 0;
      newLevelCleanUp();
      }
      collisionDetection();
      newLevelCleanUp();
      
      if (players.get(1).dead)
      {
        fill(players.get(0).colour);
        textFont(font, 36);
        text("Player 1 wins, move right to go to the next screen", 50, 550);
        rect(width - 400, 200, 200, 100);
        triangle(width - 200, 150, width - 100, 250, width - 200, 350);
      }
     
      else if (players.get(0).dead)
      {
        fill(players.get(0).colour);
        textFont(font, 36);
        text("Player 2 wins, move right to go to the next screen", 50, 550);
        rect(200, 200, 200, 100);
        triangle(200, 150, 100, 250, 200, 350);
      } 

  
    }
  }
}

void menu()
{
  for(int i = 0 ; i < players.size() ; i ++)
      {
        players.get(i).update();
      }
  
    textFont(font, 36);
    text("* This game requires a very powerfull computer to render all its frames, press button 1 now to", 30, 950);
    text(" frames, press button 1 now to toggle between allowing or not allowing movement frames", 30, 1000);
  textFont(font, 64);
    if (players.get(0).disableMoveFrames)
    {
      fill(255);
      text("Movement Frames are inactive", 250, 100);
    }
    else
    {
      text("Movement Frames are active", 250, 100);
    }
  if (players.get(0).menu == 1)
  {
    players.get(1).menu = 1;
    fill(255);
    text("Single Player", 450, 200);
    fill(0);
    text("Multiplayer", 450, 500);
    text("How to Play", 450, 800);
    
  }
  
  else if (players.get(0).menu == 2)
  {
    players.get(1).menu = 2;
    fill(0);
    text("Single Player", 450, 200);
    fill(255);
    text("Multiplayer", 450, 500);
    fill(0);
    text("How to Play", 450, 800);
  }
  
  else if (players.get(0).menu == 3)
  {
    players.get(1).menu = 3;
    fill(0);
    
    text("Single Player", 450, 200);
    fill(0);
    text("Multiplayer", 450, 500);
    fill(255);
    text("How to Play", 450, 800);
    fill(0);
  }
}

void pause()
{
  players.get(1).pauseChoice =4;
  players.get(0).update();
  textFont(font, 186);
  text("Paused", 360, 400);
  textFont(font, 86);
  
    if (players.get(0).pauseChoice == 1)
    {
      fill(255);
      text("Restart match?", 350, 800);
      fill(0);
      text("Return to menu?", 350, 900);
      fill(players.get(0).colour);
    }
  
    else
    {
      fill(0);
      text("Restart match?", 350, 800);
      fill(255);
      text("Return to menu?", 350, 900);
      fill(players.get(0).colour);
      }
   
    }
  
 

void collisionDetection()
{
  if (players.get(0).currentlyStabbing)
  {
    if (players.get(0).facingRight)
    {
      if ((players.get(0).pos.x + 35) > (players.get(1).pos.x) && (players.get(0).pos.x + 35) < (players.get(1).pos.x + 20) && players.get(0).pos.y > (players.get(1).pos.y - 20) && players.get(0).pos.y < (players.get(1).pos.y + 80) || (players.get(0).pos.x + 85) > (players.get(1).pos.x) && (players.get(0).pos.x + 85) < (players.get(1).pos.x + 20) && players.get(0).pos.y > (players.get(1).pos.y - 20) && players.get(0).pos.y < (players.get(1).pos.y + 80))
      { 
        if (!players.get(1).currentlyStabbing && !players.get(0).dead)
        {
          players.get(1).dead = true;
          efx[2].rewind();
          efx[2].play();
        }
        
        else if (!players.get(1).dead)
        {
          players.get(0).pos.x -= 20;
          players.get(1).pos.x += 20;
          efx[3].rewind();
          efx[3].play();
        }
      }
    }
  
    
    else
    {
      if ((players.get(0).pos.x - 15) < (players.get(1).pos.x + 20) && (players.get(0).pos.x - 15) > (players.get(1).pos.x) && players.get(0).pos.y > (players.get(1).pos.y - 20) && players.get(0).pos.y < (players.get(1).pos.y + 80) || (players.get(0).pos.x - 60) < (players.get(1).pos.x + 20) && (players.get(0).pos.x - 60) > (players.get(1).pos.x) && players.get(0).pos.y > (players.get(1).pos.y - 20) && players.get(0).pos.y < (players.get(1).pos.y + 80))
      { 
        if (!players.get(1).currentlyStabbing && !players.get(0).dead)
        {
          players.get(1).dead = true;
          efx[2].rewind();
          efx[2].play();
        }
        
        else if (!players.get(1).dead)
        {
          players.get(0).pos.x -= 20;
          players.get(1).pos.x += 20;
          efx[3].rewind();
          efx[3].play();
        }
      }
    }
  }
  
  if (players.get(1).currentlyStabbing)
  {
    if (players.get(1).facingRight)
    {
      if ((players.get(1).pos.x + 35) > (players.get(0).pos.x) && (players.get(1).pos.x + 35) < (players.get(0).pos.x + 20) && players.get(1).pos.y > (players.get(0).pos.y - 20) && players.get(1).pos.y < (players.get(0).pos.y + 80) || (players.get(1).pos.x + 85) > (players.get(0).pos.x) && (players.get(1).pos.x + 85) < (players.get(0).pos.x + 20) && players.get(1).pos.y > (players.get(0).pos.y - 20) && players.get(1).pos.y < (players.get(0).pos.y + 80))
      { 
        if (!players.get(0).currentlyStabbing && !players.get(1).dead)
        {
          players.get(0).dead = true;
          efx[1].rewind();
          efx[1].play();
        }
        
        else if (!players.get(1).dead)
        {
          players.get(0).pos.x -= 20;
          players.get(1).pos.x += 20;
          efx[3].rewind();
          efx[3].play();
        }
      }
    }
    
    else
    {
      if ((players.get(1).pos.x - 15) < (players.get(0).pos.x + 20) && (players.get(1).pos.x - 15) > (players.get(0).pos.x) && players.get(1).pos.y > (players.get(0).pos.y - 20) && players.get(1).pos.y < (players.get(0).pos.y + 80) || (players.get(1).pos.x - 60) < (players.get(0).pos.x + 20) && (players.get(1).pos.x - 60) > (players.get(0).pos.x) && players.get(1).pos.y > (players.get(0).pos.y - 20) && players.get(1).pos.y < (players.get(0).pos.y + 80))
      { 
        if (!players.get(0).currentlyStabbing && !players.get(1).dead)
        { 
          players.get(0).dead = true;
          efx[1].rewind();
          efx[1].play();
        }
        
        else if (!players.get(1).dead)
        {
          players.get(0).pos.x -= 20;
          players.get(1).pos.x += 20;
          efx[3].rewind();
          efx[3].play();
        }
      }
    }
  }
}

void newLevelCleanUp()
{
  if (players.get(0).pos.x > width)
    {
      players.get(0).pos.x = 40;
      animations.get(1).count4 = 0;
      players.get(1).pos.x = width - 40;
      players.get(0).pos.y = height - 100;
      players.get(1).pos.y = height - 100;
      players.get(0).onPlatform = false;
      players.get(1).onPlatform = false;
      players.get(0).currentFloor = 100;
      players.get(1).currentFloor = 100;
      players.get(1).dead = false;
      players.get(1).finished = false;
      players.get(0).currentLevel++;
      players.get(1).currentLevel++;
      
      if (players.get(0).currentLevel == 5)
      {
        players.get(0).pos.y = 700;
        players.get(1).pos.y = 700;
        players.get(0).currentFloor = 700;
        players.get(1).currentFloor = 700;
        players.get(0).onPlatform = true;
        players.get(1).onPlatform = true;
        players.get(0).isJumping = true;
        players.get(1).isJumping = true;
      }
    }
    
    else if (players.get(1).pos.x < 0)
    {
     
      players.get(0).pos.x = 40;
      animations.get(0).count4 = 0;
      players.get(1).pos.x = width - 40;
      players.get(0).pos.y = height - 100;
      players.get(1).pos.y = height - 100;
      players.get(0).onPlatform = false;
      players.get(1).onPlatform = false;
      players.get(0).currentFloor = 100;
      players.get(1).currentFloor = 100;
      players.get(0).dead = false;
      players.get(0).finished = false;
      players.get(1).currentLevel--;
      players.get(0).currentLevel--;

      if (players.get(1).currentLevel == 1)
      {
        players.get(0).pos.y = 700;
        players.get(1).pos.y = 700;
        players.get(0).currentFloor = 700;
        players.get(1).currentFloor = 700;
        players.get(0).onPlatform = true;
        players.get(1).onPlatform = true;
        players.get(0).isJumping = true;
        players.get(1).isJumping = true;
      }
      
    }
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

boolean checkKey(char theKey)
{
  return keys[Character.toUpperCase(theKey)];
}

char buttonNameToKey(XML xml, String buttonName)
{
  String value =  xml.getChild(buttonName).getContent();
  if ("LEFT".equalsIgnoreCase(value))
  {
    return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value))
  {
    return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value))
  {
    return UP;
  }
  if ("DOWN".equalsIgnoreCase(value))
  {
    return DOWN;
  }
  //.. Others to follow
  return value.charAt(0);  
}

void setUpPlayerControllers()
{
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  int gap = width / (children.length + 1);
  
  for(int i = 0 ; i < children.length ; i ++)  
  {
    XML playerXML = children[i];
    Player p = new Player(i, color(0, random(0, 255), random(0, 255)), playerXML);
    Animations a = new Animations();
    int x = (i + 1) * gap;
    p.pos.x = x;
    p.pos.y = height - 100;
    players.add(p); 
    animations.add(a);

    if (i == 1)
    {
      players.get(i).facingRight = false;
    }    
  }
}

void loadSounds()
{
  minim = new Minim(this);
  player = minim.loadFile("mainMusic.mp3", 2048);
  player.loop();
  
  efx = new AudioPlayer[4];
  efx[0] = minim.loadFile("sword.mp3", 2048); 
  efx[1] = minim.loadFile("player1Death.mp3", 2048);
  efx[2] = minim.loadFile("player2Death.mp3", 2048);
  efx[3] = minim.loadFile("Clash.mp3", 2048);
}

void loadFonts()
{
  font = loadFont("ArcadeClassic-48.vlw"); 
  
}
