class Sprites
{
  int frameDog, frameRed, frameYellow, frameBlue;
  int imageCountDog = 5;
  int imageCount = 3;
  
  boolean retCaught;

  PImage[] dog, red, yellow, blue;
  int m, n;
  int Timer = millis();

  final int WAIT_TIME = (int) (0.2 * 1000);
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
  void staticSprite(float playerX, float playerY)
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
  boolean moveSprite(float playerX, float playerY)
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

  
  void red(float x, float y)
  {
      if (hasFinishedRed()) 
      {
        frameRed = (frameRed+1) % imageCount;
        startTimeR = millis();
      }
    image(red[frameRed], x, y);
  }

  void yellow(float x, float y)
  {

    if (hasFinishedYellow()) 
      {
        frameYellow = (frameYellow+1) % imageCount;
        startTimeY = millis();
      }   
    image(yellow[frameYellow], x, y);
  }

  void blue(float x, float y)
  {
      if (hasFinishedBlue()) 
      {
        frameBlue = (frameBlue+1) % imageCount;
        startTimeB = millis();
      }      
    
    image(blue[frameBlue], x, y);
  }
  
  
  boolean hasFinishedRed() 
  {
    return millis() - startTimeR > WAIT_TIME;
  }
  
  boolean hasFinishedYellow() 
  {
    return millis() - startTimeY > WAIT_TIME;
  }
  
  boolean hasFinishedBlue() 
  {
    return millis() - startTimeB > WAIT_TIME;
  }
  
}

