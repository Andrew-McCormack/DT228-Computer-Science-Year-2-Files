class Level
{
  int currentLevel;
  int counter = 0;
  boolean onOff = false;
  int downUp;
  color colour;
  
  Level()
  {
  }
  
  void boundaryCheck()
  {
    if (players.get(0).pos.x > width - 32 && !players.get(1).dead)
    {
      players.get(0).pos.x = width - 32;
    }
    
    else if (players.get(1).pos.x > width - 32)
    {
      players.get(1).pos.x = width - 32;
    }
    
    else if (players.get(0).pos.x < 12)
    {
      players.get(0).pos.x = 12;
    }
    
    else if (players.get(1).pos.x < 12 && !players.get(0).dead)
    {
      players.get(1).pos.x = 12;
    }
  }
  
  void levelSelector(int currentLevel, color colour)
  {
     this.colour = colour;
     this.currentLevel = currentLevel;
     if (currentLevel == 1)
     {
       level1(colour);
     }
    
     else if (currentLevel == 2)
     {
        level2(colour);
     }
   
     else if (currentLevel == 3)
     {
        level3(colour);
     }
 
     else if (currentLevel == 4)
     {
        level4(colour);
     }
 
     else
     {
        level5(colour);
     }
  }
  
  void level1(color colour)
  {
    this.colour = colour;
    fill(90);
    rect(0, 400, 350, 800);
    rect(485, 400, 350, 800);
    rect(980, 400, 350, 800);
    ellipse(500, 400, 10,10);
    
    if (players.get(0).pos.x < 980 && players.get(0).pos.x > 835 && players.get(1).pos.y + 100 > 400 && players.get(0).dead == false)
    {
      players.get(0).onPlatform = false;
      players.get(0).pos.y+= 5;
    }
    
    else if (players.get(0).pos.x < 485 && players.get(0).pos.x > 385  && players.get(0).pos.y + 100 > 400 && players.get(0).dead == false)
    {
      players.get(0).onPlatform = false;
      players.get(0).pos.y+= 5;
    }
    
    else if (players.get(1).pos.x < 980 && players.get(1).pos.x > 835  && players.get(1).pos.y + 100 > 400 && players.get(1).dead == false)
    {
      players.get(1).onPlatform = false;
      players.get(1).pos.y+= 5;
    }
    
    else if (players.get(1).pos.x < 485 && players.get(1).pos.x > 385  && players.get(1).pos.y + 100 > 400 && players.get(1).dead == false)
    {
      players.get(1).onPlatform = false;
      players.get(1).pos.y+= 5;
    }
    
    
    if (players.get(0).pos.y > height)
    {
      players.get(0).dead = true;
      efx[1].rewind();
      efx[1].play();
    }
    
    else if (players.get(1).pos.y > height)
    {
      players.get(1).dead = true;
      efx[1].rewind();
      efx[1].play();
    }

    boundaryCheck();
    fill(colour);
  }
  
  void level2(color colour)
  {
    this.colour = colour;
    fill(90);
    rect(0, 0, width, 860);
    rect(0, height - 20, width, 20);    
    
    if(players.get(0).pos.y < height - 140)
    {
      players.get(0).speed.y = 0;
    }
    
    else if (players.get(1).pos.y < height - 140)
    {
      players.get(1).speed.y = 0;
    }
    
    if (counter > 240)
    {
      counter = 0;
      onOff = !onOff;
    }
    
    
    
    if (onOff)
    {
      
      downUp = height - 120;
      
      if (players.get(0).pos.x < (width / 5) + 10 && players.get(0).pos.x > (width / 5) || players.get(0).pos.x < ((width / 5) * 2) + 10 && players.get(0).pos.x > ((width / 5) * 2) || players.get(0).pos.x < ((width / 5) * 3) + 10 && players.get(0).pos.x > ((width / 5) * 3) || players.get(0).pos.x < ((width / 5) * 4) + 10 && players.get(0).pos.x > ((width / 5) * 4))
      {
       if (players.get(0).dead == false)
       {
          players.get(0).dead = true;
          efx[1].rewind();
          efx[1].play();
       }
      }
    
      else if (players.get(1).pos.x < (width / 5) + 10 && players.get(1).pos.x > (width / 5) || players.get(1).pos.x < ((width / 5) * 2) + 10 && players.get(1).pos.x > ((width / 5) * 2) || players.get(1).pos.x < ((width / 5) * 3) + 10 && players.get(1).pos.x > ((width / 5) * 3) || players.get(1).pos.x < ((width / 5) * 4) + 10 && players.get(1).pos.x > ((width / 5) * 4))
      {
       if (players.get(1).dead == false)
       {
          players.get(1).dead = true;
          efx[2].rewind();
          efx[2].play();
       }
      }
             
    }    
    else
    {
      downUp = height - 20;
    }
    
    if (players.get(0).dead == true || players.get(1).dead == true)
    {
      downUp = height - 20;
      onOff = false;
    }
    fill(255, 0, 0);
    rect(width / 5, downUp, 10, 100);
    rect((width / 5) * 2, downUp, 10, 100);
    rect((width / 5) * 3, downUp, 10, 100);
    rect((width / 5) * 4, downUp, 10, 100);
    
    counter++;
    boundaryCheck();   
    fill(colour);
  }
  
  void level3(color colour)
  {
    this.colour = colour;
    fill(90);
    rect(0, height - 20, width, 20);
    
    rect(0, height - 180, 400, 20);
    rect(width - 400, height - 180, 400, 20);
    rect(400, height - 360, 460, 20);
    rect(0, 0, width, 560);
    
    if (players.get(0).pos.y < height - 185 && players.get(0).pos.x < 400 || players.get(0).pos.y < height - 185 && players.get(0).pos.x > width - 400)
    {
      players.get(0).onPlatform = true;
      players.get(0).currentFloor = 260;
    }
    
    else if (players.get(0).pos.x >400 && players.get(0).onPlatform && !players.get(0).isJumping || players.get(0).pos.x < width - 400 && players.get(0).onPlatform && !players.get(0).isJumping)
    {
      players.get(0).onPlatform = false;
      players.get(0).isJumping = true;
      players.get(0).currentFloor = 100;
    }
    
    if (players.get(0).pos.y < height - 405 && players.get(0).pos.x > 400 && players.get(0).pos.x < 865)
    {
      players.get(0).currentFloor = 440;;
      players.get(0).onPlatform = true;
    }
    
    else if (players.get(0).pos.x < 400 && players.get(0).pos.y < height - 355 && !players.get(0).isJumping || players.get(0).pos.x > 865 && players.get(0).pos.y < height - 355 && !players.get(0).isJumping)
    {
      players.get(0).isJumping = true;
      players.get(0).currentFloor = 260;
    }
    
    
    if (players.get(1).pos.y < height - 185 && players.get(1).pos.x < 400 || players.get(1).pos.y < height - 185 && players.get(1).pos.x > width - 400)
    {
      players.get(1).onPlatform = true;
      players.get(1).currentFloor = 260;
    }
    
    else if (players.get(1).pos.x >400 && players.get(1).onPlatform && !players.get(1).isJumping || players.get(1).pos.x < width - 400 && players.get(1).onPlatform && !players.get(1).isJumping)
    {
      players.get(1).onPlatform = false;
      players.get(1).isJumping = true;
      players.get(1).currentFloor = 100;
    }
    
    if (players.get(1).pos.y < height - 405 && players.get(1).pos.x > 400 && players.get(1).pos.x < 865)
    {
      players.get(1).currentFloor = 440;;
      players.get(1).onPlatform = true;
    }
    
    else if (players.get(1).pos.x < 400 && players.get(1).pos.y < height - 355 && !players.get(1).isJumping || players.get(1).pos.x > 865 && players.get(1).pos.y < height - 355 && !players.get(1).isJumping)
    {
      players.get(1).isJumping = true;
      players.get(1).currentFloor = 260;
    }
    
    boundaryCheck();
    fill(colour);
  }
  
  void level4(color colour)
  {
    this.colour = colour;
    fill(90);
    rect(0, 0, width, 860);
    rect(0, height - 20, width, 20);    
    
    if(players.get(0).pos.y < height - 140)
    {
      players.get(0).speed.y = 0;
    }
    
    else if (players.get(1).pos.y < height - 140)
    {
      players.get(1).speed.y = 0;
    }
    
    if (counter > 240)
    {
      counter = 0;
      onOff = !onOff;
    }
    
    
    
    if (onOff)
    {
      
      downUp = height - 120;
      
      if (players.get(0).pos.x < (width / 5) + 10 && players.get(0).pos.x > (width / 5) || players.get(0).pos.x < ((width / 5) * 2) + 10 && players.get(0).pos.x > ((width / 5) * 2) || players.get(0).pos.x < ((width / 5) * 3) + 10 && players.get(0).pos.x > ((width / 5) * 3) || players.get(0).pos.x < ((width / 5) * 4) + 10 && players.get(0).pos.x > ((width / 5) * 4))
      {
       if (players.get(0).dead == false)
       {
          players.get(0).dead = true;
          efx[1].rewind();
          efx[1].play();
       }
      }
    
      else if (players.get(1).pos.x < (width / 5) + 10 && players.get(1).pos.x > (width / 5) || players.get(1).pos.x < ((width / 5) * 2) + 10 && players.get(1).pos.x > ((width / 5) * 2) || players.get(1).pos.x < ((width / 5) * 3) + 10 && players.get(1).pos.x > ((width / 5) * 3) || players.get(1).pos.x < ((width / 5) * 4) + 10 && players.get(1).pos.x > ((width / 5) * 4))
      {
       if (players.get(1).dead == false)
       {
          players.get(1).dead = true;
          efx[2].rewind();
          efx[2].play();
       }
      }
             
    }    
    else
    {
      downUp = height - 20;
    }
    
    if (players.get(0).dead == true || players.get(1).dead == true)
    {
      downUp = height - 20;
      onOff = false;
    }
    fill(255, 0, 0);
    rect(width / 5, downUp, 10, 100);
    rect((width / 5) * 2, downUp, 10, 100);
    rect((width / 5) * 3, downUp, 10, 100);
    rect((width / 5) * 4, downUp, 10, 100);
    
    counter++;
    boundaryCheck();   
    fill(colour);
  }
  
  void level5(color colour)
  {
   this.colour = colour;
    fill(90);
    rect(0, 400, 350, 800);
    rect(485, 400, 350, 800);
    rect(980, 400, 350, 800);
    ellipse(500, 400, 10,10);
    
    if (players.get(0).pos.x < 980 && players.get(0).pos.x > 835 && players.get(1).pos.y + 100 > 400 && players.get(0).dead == false)
    {
      players.get(0).onPlatform = false;
      players.get(0).pos.y+= 5;
    }
    
    else if (players.get(0).pos.x < 485 && players.get(0).pos.x > 385  && players.get(0).pos.y + 100 > 400 && players.get(0).dead == false)
    {
      players.get(0).onPlatform = false;
      players.get(0).pos.y+= 5;
    }
    
    else if (players.get(1).pos.x < 980 && players.get(1).pos.x > 835  && players.get(1).pos.y + 100 > 400 && players.get(1).dead == false)
    {
      players.get(1).onPlatform = false;
      players.get(1).pos.y+= 5;
    }
    
    else if (players.get(1).pos.x < 485 && players.get(1).pos.x > 385  && players.get(1).pos.y + 100 > 400 && players.get(1).dead == false)
    {
      players.get(1).onPlatform = false;
      players.get(1).pos.y+= 5;
    }
    
    
    if (players.get(0).pos.y > height)
    {
      players.get(0).dead = true;
      efx[1].rewind();
      efx[1].play();
    }
    
    else if (players.get(1).pos.y > height)
    {
      players.get(1).dead = true;
      efx[1].rewind();
      efx[1].play();
    }

    boundaryCheck();
    fill(colour);
  }
  
}
