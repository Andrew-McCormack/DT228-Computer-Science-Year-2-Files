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
  
  boolean run(float playerX)
  {
    movingBlocks();
    retCaught = checkPlayer();
    displayHud();
    return (retCaught);
  }


void resetPositions()
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
void movingBlocks()
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
boolean checkPlayer()
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

