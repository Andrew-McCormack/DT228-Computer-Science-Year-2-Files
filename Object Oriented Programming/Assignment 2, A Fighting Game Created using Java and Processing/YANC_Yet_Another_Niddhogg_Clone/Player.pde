class Player 
{
  PVector pos;

  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  char m;
  int index;
  color colour;
  PVector speed = new PVector(0, 0);
  PVector gravity = new PVector(0.6, 0.6);

  boolean help = false;
  boolean isJumping;
  boolean facingRight;
  boolean currentlyKicking;
  boolean currentlyStabbing;
  boolean right2;
  boolean dead = false;
  boolean finished = false;
  boolean onPlatform = false;
  boolean stopJump = false;
  boolean disableMoveFrames;
  int count = 0;
  int count2 = 0;
  int count3 = 0;
  int count4 = 0;
  int currentLevel = 3;
  int currentFloor = 100;
  int menu;
  int pauseChoice;
  Player()
  {
    pos = new PVector(width / 2, height / 2);
    menu = 1; 
    pauseChoice = 1;
  }

  Player(int index, color colour, char up, char down, char left, char right, char start, char button1, char button2)
  {
    this();
    this.index = index;
    this.colour = colour;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    if (index != 1)
    {
    this.start = start;
    }
    else
    {
      this.start = m;
    }
    this.button1 = button1;
    this.button2 = button2;
    isJumping = false;
    facingRight = true;
    currentlyKicking = false;
    currentlyStabbing = false;
    count2 = 0;
  }

  Player(int index, color colour, XML xml)
  {
    this(index
      , colour
      , buttonNameToKey(xml, "up")
      , buttonNameToKey(xml, "down")
      , buttonNameToKey(xml, "left")
      , buttonNameToKey(xml, "right")
      , buttonNameToKey(xml, "start")
      , buttonNameToKey(xml, "button1")
      , buttonNameToKey(xml, "button2")
      );
  }

  void update()
  {
    if (!finished)
    {
      if (checkKey(up))
      {
        if (frameCount % 20 == 0 && !startGame)
        {
          if (menu > 1)
          {
            menu--;
          }
        }
        
        else if (frameCount  % 20 == 0 && pauseGame)
        {
          if (pauseChoice == 2)
          {
            players.get(0).pauseChoice--;
          }
        }
            
      }
      if (checkKey(down))
      {
        if (frameCount % 20 == 0 && !startGame)
          {
          if (menu < 3)
          {
            menu++;
          }
        }
        
        else if (frameCount  % 20 == 0 && pauseGame)
        {
          if (pauseChoice == 1)
          {
            players.get(0).pauseChoice++;
          }
        }
      }
      if (checkKey(left))
      {
        facingRight = false;
        pos.x -= 3;
        
      }    
      if (checkKey(right))
      {
        facingRight = true;
        pos.x += 3;
        
      }
      if (checkKey(start))
      {
        if (frameCount % 20 == 0)
        {
          if (startGame == false)
          {
            startGame = true;
          }
        
          else
          {
            pauseGame = !pauseGame;
          } 
        } 
      }
      if (checkKey(button1))
      {
        
        if (!startGame && frameCount % 20 == 0)
        {
          disableMoveFrames = !disableMoveFrames;
        }
        
        if (pauseGame)
        {
          println("j");
          if (players.get(0).pauseChoice == 1)
          {
            players.get(0).pos.x = width + 10;
            players.get(1).currentLevel = 2;
            players.get(0).currentLevel = 2;
            players.get(0).dead = false;
            players.get(0).finished = false;
            animations.get(0).count4 = 0;
            newLevelCleanUp();
            pauseGame = false;
          }
          
          else if (players.get(0).pauseChoice == 2)
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
            
        if(!stopJump)
        {
          jump();
        }
      }
      if (checkKey(button2) && !dead)
      {
        
        if(currentFloor == 440)
        {
          currentlyStabbing = true;
          efx[0].rewind();
          efx[0].play();
        }
        
        else if (pos.y < height - 100 && currentlyKicking == false && isJumping)
        {
          currentlyKicking = true;
          efx[0].rewind();
          efx[0].play();
        }
        
        
        
        else 
        {
          if (count3 == 0)
          {
            currentlyStabbing = true;
            efx[0].rewind();
            efx[0].play();
            count3 = 50;
          }
        }
      }
    }
  }

  void jump() 
  {
    if (isJumping == false) {
      speed.x = -15;
      speed.y = -15;
      isJumping = true;
    }
  }

  void moving()
  {
    if (!disableMoveFrames)
    {
      if (count < 5)
      {
        animations.get(index).moveFrame1(pos.x, pos.y, colour, facingRight);
        animations.get(index).moveFrame4(pos.x, pos.y, colour, facingRight);
      } 
      else if (count < 10)
      {
        animations.get(index).moveFrame2(pos.x, pos.y, colour, facingRight);
        animations.get(index).moveFrame5(pos.x, pos.y, colour, facingRight);
      } 
      else if (count < 15)
      {
        animations.get(index).moveFrame1(pos.x, pos.y, colour, facingRight);
        animations.get(index).moveFrame4(pos.x, pos.y, colour, facingRight);
      } 
      else if (count < 25)
      {
        animations.get(index).moveFrame3(pos.x, pos.y, colour, facingRight);
      } 
      else 
      {
        count = 0;
      }
    }
    
    else
    {
      rect(pos.x + 5, pos.y + 40, 10, 40);
    }
      

    count++;
  }


  void display()
  {    
    fill(colour); 
    level.levelSelector(currentLevel, colour); 
    
    if (menu == 1)
    {
      runAI();
    }
    
    if (!dead)
    {
      if (count3 > 0)
      {
        count3--;
      }  
      
      rect(pos.x, pos.y, 20, 40);
      ellipse(pos.x + 8, pos.y - 10, 22, 22);   
      animations.get(index).armFrame(pos.x, pos.y, colour, facingRight, currentlyStabbing, dead);

      if (currentlyStabbing)
      {
        currentlyStabbing = animations.get(index).stabFrame(pos.x, pos.y, colour, facingRight, currentlyStabbing);
        if (facingRight)
        {
          pos.x += 2;
        } 
        else
        {
          pos.x -= 2;
        }
      }

      if (facingRight && !currentlyStabbing)
      {
        if(animations.get(index).armMoveToggle)
        {
          rect(pos.x + 29, pos.y - 15, 5, 50);  
        }
        
        else
        {
          rect(pos.x + 29, pos.y - 10, 5, 50);  
        }
      } 
      else if (!currentlyStabbing)
      {
        if(animations.get(index).armMoveToggle)
        {
          rect(pos.x - 20, pos.y - 15, 5, 50);
        }
        
        else
        {
          rect(pos.x - 20, pos.y - 10, 5, 50);
        }
      }

      if (!currentlyStabbing)
      {
        if (!currentlyKicking)
        {
          if (checkKey(right) || checkKey(left))
          {
            moving();
          } 
          else 
          {
            rect(pos.x + 5, pos.y + 40, 10, 40);
            count = 0;
          }
        } 
        else if (currentlyKicking && facingRight)
        {
          rect(pos.x + 5, pos.y + 40, 40, 10);
        } else
        {
          rect(pos.x + 5, pos.y + 40, -40, -10);
        }
      }

      if (isJumping) 
      {
        speed.add(gravity);
        pos.y = pos.y + speed.y;
        if (pos.y > height - currentFloor) 
        {
          pos.y = height - currentFloor;
          speed.y = 0;
          isJumping = false;
        }

        if (currentlyKicking && pos.y < height - currentFloor)
        {
          if (facingRight && pos.x < width - 22)
          {
            speed.add(gravity);
            pos.x = pos.x + speed.x;
          } else if (pos.x > 12)
          {
            speed.add(gravity);
            pos.x = pos.x - speed.x;
          }
        } else
        {
          currentlyKicking = false;
        }
      }
    } 
    else
    {
      finished = animations.get(index).deadFrames(pos.x, pos.y, colour, facingRight, currentlyStabbing, dead);
      
      if (pos.y < (height - currentFloor))
      {
        pos.y += 4;
      }
    }
  }
  
  void runAI()
  {
    
      if (players.get(0).pos.x + 30 < players.get(1).pos.x && !players.get(0).dead)
      {
        if (!level.onOff && !players.get(1).dead)
        {
            players.get(1).facingRight = false;
            players.get(1).pos.x -= 0.6;
        } 
        
      
        if (players.get(0).pos.y < players.get(1).pos.y)
        {
          players.get(1).jump();
        }
      } 
    
    else if (players.get(0).pos.x - 30 > players.get(1).pos.x && !players.get(0).dead)
    {
     
      if (!level.onOff && !players.get(1).dead)
      {
        players.get(1).facingRight = true;
        players.get(1).pos.x += 0.6;   
      }
      
      
      if (players.get(0).pos.y < players.get(1).pos.y)
      {
        players.get(1).jump();
      }
    }
    
    else if (!players.get(0).dead)
    {
       players.get(1).currentlyStabbing = true;
       efx[0].rewind();
       efx[0].play();
       players.get(1).count3 = 50;
    }
    
    else
    {
      players.get(1).pos.x -= 0.6;
    }  
    
     
  }

}
