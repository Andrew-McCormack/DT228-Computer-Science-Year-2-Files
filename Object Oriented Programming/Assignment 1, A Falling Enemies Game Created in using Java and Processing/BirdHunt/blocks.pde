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
  
  void run(int _enemyType)
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
  
  void display()
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
  
  void move()
  {
    y++;
  }
  
  float retCurPos()
  {
    return y;
  }
  
}
