class Animations 
{
  color colour;
 
  int count2;
  int count4;
  boolean dead;
  boolean currentlyStabbing;
  boolean facingRight;
  PVector pos;
  PShape leg;
  PShape ankle;
  PShape arm;
  float x, y;
  boolean finished;
  boolean armMoveToggle;
  
  Animations()
  {
    currentlyStabbing = false;
    armMoveToggle = false;
    finished = false;
    count2 = 0;
    count4 = 0;
  }
  
  boolean stabFrame(float x, float y, color colour, boolean facingRight, boolean currentlyStabbing)
  {
    this.currentlyStabbing = currentlyStabbing;
    this.colour = colour;
    PVector pos = new PVector(x, y);
    this.facingRight = facingRight;
    this.count2 = count2;
    if (count2 > 20)
    {
      currentlyStabbing = false;
      count2 = 0;
    }

    count2++;
    return(currentlyStabbing);
  }

  void armFrame(float x, float y, color colour, boolean facingRight, boolean currentlyStabbing, boolean dead)
  {
    this.dead = dead;
    this.currentlyStabbing = currentlyStabbing;
    this.colour = colour;
    PVector pos = new PVector(x, y);
    this.facingRight = facingRight;
    if (frameCount % 30 == 0)
    {
      armMoveToggle = !armMoveToggle;
    }
    if (facingRight && currentlyStabbing)
    {
      arm = createShape();
      arm.beginShape();
      arm.fill(colour);
      arm.vertex(pos.x + 5, pos.y + 18);
      arm.vertex(pos.x + 10, pos.y + 10);
      arm.vertex(pos.x + 40, pos.y + 10);
      arm.vertex(pos.x + 40, pos.y + 18);
      arm.endShape(CLOSE);

      rect(pos.x + 35, pos.y + 10, 50, 5);
      moveFrame4(pos.x, pos.y, colour, facingRight);
      moveFrame2(pos.x, pos.y, colour, facingRight);

      shape(arm, 0, 0);
    } 
    else if (currentlyStabbing)
    {
      arm = createShape();
      arm.beginShape();
      arm.fill(colour);
      arm.vertex(pos.x + 5, pos.y + 10);
      arm.vertex(pos.x + 10, pos.y + 18);
      arm.vertex(pos.x - 25, pos.y + 18);
      arm.vertex(pos.x - 25, pos.y + 10);
      arm.endShape(CLOSE);

      rect(pos.x - 65, pos.y + 10, 50, 5);
      moveFrame4(pos.x, pos.y, colour, facingRight);
      moveFrame2(pos.x, pos.y, colour, facingRight);

      shape(arm, 0, 0);
    } 
    
    else if (facingRight && dead)
    {
        arm = createShape();
        arm.beginShape();
        arm.fill(colour);
        arm.vertex(pos.x + 5, pos.y + 10);
        arm.vertex(pos.x + 10, pos.y + 15);
        arm.vertex(pos.x + 35, pos.y - 5);
        arm.vertex(pos.x + 30, pos.y - 10);
        arm.endShape(CLOSE);

        shape(arm, 0, 0);
    }
    
    else if (dead)
    {
        arm = createShape();
        arm.beginShape();
        arm.fill(colour);
        arm.vertex(pos.x + 10, pos.y + 10);
        arm.vertex(pos.x + 5, pos.y + 15);
        arm.vertex(pos.x - 30, pos.y - 5);
        arm.vertex(pos.x - 25, pos.y - 10);
        arm.endShape(CLOSE);

        shape(arm, 0, 0);
    }

    else if (facingRight)
    {
      if (armMoveToggle)
      {
        arm = createShape();
        arm.beginShape();
        arm.fill(colour);
        arm.vertex(pos.x + 5, pos.y + 15);
        arm.vertex(pos.x + 10, pos.y + 10);
        arm.vertex(pos.x + 35, pos.y + 25);
        arm.vertex(pos.x + 30, pos.y + 30);
        arm.endShape(CLOSE);

        shape(arm, 0, 0);
      }
      else
      {
        arm = createShape();
        arm.beginShape();
        arm.fill(colour);
        arm.vertex(pos.x + 5, pos.y + 20);
        arm.vertex(pos.x + 10, pos.y + 15);
        arm.vertex(pos.x + 35, pos.y + 30);
        arm.vertex(pos.x + 30, pos.y + 35);
        arm.endShape(CLOSE);

        shape(arm, 0, 0);
      }
    }
     
    else
    {
      if (armMoveToggle)
      {
        arm = createShape();
        arm.beginShape();
        arm.fill(colour);
        arm.vertex(pos.x + 5, pos.y + 10);
        arm.vertex(pos.x + 10, pos.y + 15);
        arm.vertex(pos.x - 15, pos.y + 30);
        arm.vertex(pos.x - 20, pos.y + 25);
        arm.endShape(CLOSE);

        shape(arm, 0, 0);
      }
      else
      {
        arm = createShape();
        arm.beginShape();
        arm.fill(colour);
        arm.vertex(pos.x + 5, pos.y + 15);
        arm.vertex(pos.x + 10, pos.y + 20);
        arm.vertex(pos.x - 15, pos.y + 35);
        arm.vertex(pos.x - 20, pos.y + 30);
        arm.endShape(CLOSE);

        shape(arm, 0, 0);
      }
          
     }
    }

   
    boolean deadFrames(float x, float y, color colour, boolean facingRight, boolean currentlyStabbing, boolean dead)
    {
      this.dead = dead;
      this.currentlyStabbing = currentlyStabbing;
      this.colour = colour;
      PVector pos = new PVector(x, y);
      this.facingRight = facingRight;
        
      if (count4 < 30)
      {
        rect(pos.x, pos.y, 20, 40);
        ellipse(pos.x + 8, pos.y - 10, 22, 22);
        moveFrame3(pos.x, pos.y, colour, facingRight);
        armFrame(pos.x, pos.y, colour, facingRight, currentlyStabbing, dead);
      } else if (count4 < 60)
      {
        rect(pos.x, pos.y, 20, 40);
        ellipse(pos.x + 8, pos.y - 10, 22, 22);
        moveFrame1(pos.x, pos.y, colour, facingRight);
        moveFrame4(pos.x, pos.y, colour, facingRight);
        armFrame(pos.x, pos.y, colour, facingRight, currentlyStabbing, dead);
      } 
      
      else if (count4 < 90)
      {
        rect(pos.x, pos.y + 20, 20, 40);
        ellipse(pos.x + 8, pos.y + 10, 22, 22);

        if (facingRight)
        {
          leg = createShape();
          leg.beginShape();
          leg.fill(colour);
          leg.vertex(pos.x + 5, pos.y + 60);        
          leg.vertex(pos.x + 10, pos.y + 70);
          leg.vertex(pos.x, pos.y + 80);
          leg.vertex(pos.x - 5, pos.y + 70);
          leg.endShape(CLOSE);

          ankle = createShape();
          ankle.beginShape();
          ankle.fill(colour);
          ankle.vertex(pos.x, pos.y + 80);
          ankle.vertex(pos.x - 5, pos.y + 70);
          ankle.vertex(pos.x - 25, pos.y + 70);
          ankle.vertex(pos.x - 20, pos.y + 80);
          ankle.endShape(CLOSE);
          
     
          arm = createShape();
          arm.beginShape();
          arm.fill(colour);
          arm.vertex(pos.x + 5, pos.y + 30);
          arm.vertex(pos.x + 10, pos.y + 35);
          arm.vertex(pos.x + 35, pos.y - 5);
          arm.vertex(pos.x + 30, pos.y - 10);
          arm.endShape(CLOSE);

          shape(arm, 0, 0);  
          shape(ankle, 0, 0);
          shape(leg, 0, 0);
        } 
        
        else
        {
          leg = createShape();
          leg.beginShape();
          leg.fill(colour);
          leg.vertex(pos.x + 5, pos.y + 70);        
          leg.vertex(pos.x + 10, pos.y + 60);
          leg.vertex(pos.x + 15, pos.y + 70);
          leg.vertex(pos.x + 10, pos.y + 80);
          leg.endShape(CLOSE);

          ankle = createShape();
          ankle.beginShape();
          ankle.fill(colour);
          ankle.vertex(pos.x + 15, pos.y + 70);
          ankle.vertex(pos.x  + 10, pos.y +80);
          ankle.vertex(pos.x + 35, pos.y + 80);
          ankle.vertex(pos.x + 30, pos.y + 70);
          ankle.endShape(CLOSE);
          
          arm = createShape();
          arm.beginShape();
          arm.fill(colour);
          arm.vertex(pos.x + 10, pos.y + 30);
          arm.vertex(pos.x + 5, pos.y + 35);
          arm.vertex(pos.x - 30, pos.y - 5);
          arm.vertex(pos.x - 25, pos.y - 10);
          arm.endShape(CLOSE);
          
          shape(ankle, 0, 0);
          shape(leg, 0, 0);
        }

        
      } else  
      {

        finished = true;
        if (facingRight)
        {
          fill(255, 0, 0);
          ellipse(pos.x + 48, pos.y + 70, 22, 22);
          rect(pos.x - 5, pos.y + 60, 40, 20);
          rect(pos.x - 45, pos.y + 70, 40, 10);
        } else
        {
          fill(255, 0, 0);
          ellipse(pos.x - 25, pos.y + 70, 22, 22);
          rect(pos.x - 14, pos.y + 60, 40, 20);
          rect(pos.x + 26, pos.y + 70, 40, 10);
        }
      }



      if (count4 < 250)
      {
        count4++; 
        if (!finished)
        {
          fill(255, 0, 0);
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));  
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          fill(red(colour), green(colour), blue(colour));
        } else
        {
          fill(255, 0, 0);
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));  
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          ellipse((float)random(pos.x -5, pos.x + 30), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          ellipse((float)random(pos.x -5, pos.x + 0), (float)random(pos.y, pos.y + 80), (float)random(5, 15), (float)random(5, 15));
          fill(red(colour), green(colour), blue(colour));
        }
      }
      
      return(finished);
    }

  
  void moveFrame1(float x, float y, color colour, boolean facingRight)
  {
    this.colour = colour;
    PVector pos = new PVector(x, y);
    this.facingRight = facingRight;
      if (facingRight)
      {
        leg = createShape();
        leg.beginShape();
        leg.fill(colour);
        leg.vertex(pos.x + 5, pos.y + 50);
        leg.vertex(pos.x + 10, pos.y + 40);
        leg.vertex(pos.x + 25, pos.y + 50);
        leg.vertex(pos.x + 20, pos.y + 60);
        leg.endShape(CLOSE);

        ankle = createShape();
        ankle.beginShape();
        ankle.fill(colour);
        ankle.vertex(pos.x + 20, pos.y + 50);
        ankle.vertex(pos.x + 25, pos.y + 60);
        ankle.vertex(pos.x + 10, pos.y + 80);
        ankle.vertex(pos.x + 5, pos.y + 70);
        ankle.endShape(CLOSE);

        shape(ankle, 0, 0);
        shape(leg, 0, 0);
      } else
      {
        leg = createShape();
        leg.beginShape();
        leg.fill(colour);
        leg.vertex(pos.x + 5, pos.y + 40);
        leg.vertex(pos.x + 10, pos.y + 50);
        leg.vertex(pos.x - 10, pos.y + 60);
        leg.vertex(pos.x - 15, pos.y + 50);
        leg.endShape(CLOSE);

        ankle = createShape();
        ankle.beginShape();
        ankle.fill(colour);
        ankle.vertex(pos.x - 10, pos.y + 50);
        ankle.vertex(pos.x - 15, pos.y + 60);
        ankle.vertex(pos.x + 5, pos.y + 80);
        ankle.vertex(pos.x + 10, pos.y + 70);
        ankle.endShape(CLOSE);

        shape(ankle, 0, 0);
        shape(leg, 0, 0);
      }
    }
    
    void moveFrame2(float x, float y, color colour, boolean facingRight)
    {
      this.colour = colour;
    PVector pos = new PVector(x, y);
    this.facingRight = facingRight;
      if (facingRight)
      {
        leg = createShape();
        leg.beginShape();
        leg.fill(colour);
        leg.vertex(pos.x + 5, pos.y + 50);
        leg.vertex(pos.x + 5, pos.y + 40);
        leg.vertex(pos.x + 30, pos.y + 40);
        leg.vertex(pos.x + 30, pos.y + 50);
        leg.endShape(CLOSE);

        ankle = createShape();
        ankle.beginShape();
        ankle.fill(colour);
        ankle.vertex(pos.x + 15, pos.y + 50);
        ankle.vertex(pos.x + 25, pos.y + 50);
        ankle.vertex(pos.x + 15, pos.y + 70);
        ankle.vertex(pos.x + 5, pos.y + 60);
        ankle.endShape(CLOSE);

        shape(leg, 0, 0);
        shape(ankle, 0, 0);
      } else
      {
        leg = createShape();
        leg.beginShape();
        leg.fill(colour);
        leg.vertex(pos.x + 5, pos.y + 50);
        leg.vertex(pos.x + 5, pos.y + 40);
        leg.vertex(pos.x - 15, pos.y + 40);
        leg.vertex(pos.x - 15, pos.y + 50);
        leg.endShape(CLOSE);

        ankle = createShape();
        ankle.beginShape();
        ankle.fill(colour);
        ankle.vertex(pos.x - 5, pos.y + 50);
        ankle.vertex(pos.x - 15, pos.y + 50);
        ankle.vertex(pos.x - 15, pos.y + 70);
        ankle.vertex(pos.x - 5, pos.y + 60);
        ankle.endShape(CLOSE);

        shape(leg, 0, 0);
        shape(ankle, 0, 0);
      }
    }

    void moveFrame3(float x, float y, color colour, boolean facingRight)
    {
      this.colour = colour;
    PVector pos = new PVector(x, y);
    this.facingRight = facingRight;
      leg = createShape();
      leg.beginShape();
      leg.fill(colour);
      leg.vertex(pos.x + 5, pos.y + 40);
      leg.vertex(pos.x + 15, pos.y + 40);
      leg.vertex(pos.x + 5, pos.y + 75);
      leg.vertex(pos.x - 5, pos.y + 75);
      leg.endShape(CLOSE);

      shape(leg, 0, 0);

      leg = createShape();
      leg.beginShape();
      leg.fill(colour);
      leg.vertex(pos.x + 5, pos.y + 40);
      leg.vertex(pos.x + 15, pos.y + 40);
      leg.vertex(pos.x + 25, pos.y + 75);
      leg.vertex(pos.x + 15, pos.y + 75);
      leg.endShape(CLOSE);

      shape(leg, 0, 0);
    }

    void moveFrame4(float x, float y, color colour, boolean facingRight)
    {
      this.colour = colour;
    PVector pos = new PVector(x, y);
    this.facingRight = facingRight;
      if (facingRight)
      {
        leg = createShape();
        leg.beginShape();
        leg.fill(colour);
        leg.vertex(pos.x + 5, pos.y + 40);        
        leg.vertex(pos.x + 10, pos.y + 50);
        leg.vertex(pos.x, pos.y + 60);
        leg.vertex(pos.x - 5, pos.y + 50);
        leg.endShape(CLOSE);

        ankle = createShape();
        ankle.beginShape();
        ankle.fill(colour);
        ankle.vertex(pos.x, pos.y + 60);
        ankle.vertex(pos.x - 5, pos.y + 50);
        ankle.vertex(pos.x - 20, pos.y + 60);
        ankle.vertex(pos.x - 15, pos.y + 70);
        ankle.endShape(CLOSE);


        shape(ankle, 0, 0);
        shape(leg, 0, 0);
      } else
      {
        leg = createShape();
        leg.beginShape();
        leg.fill(colour);
        leg.vertex(pos.x + 5, pos.y + 50);        
        leg.vertex(pos.x + 10, pos.y + 40);
        leg.vertex(pos.x + 15, pos.y + 50);
        leg.vertex(pos.x + 10, pos.y + 60);
        leg.endShape(CLOSE);

        ankle = createShape();
        ankle.beginShape();
        ankle.fill(colour);
        ankle.vertex(pos.x + 15, pos.y + 50);
        ankle.vertex(pos.x + 10, pos.y + 60);
        ankle.vertex(pos.x + 25, pos.y + 70);
        ankle.vertex(pos.x + 30, pos.y + 60);
        ankle.endShape(CLOSE);


        shape(ankle, 0, 0);
        shape(leg, 0, 0);
      }
    }

    void moveFrame5(float x, float y, color colour, boolean facingRight)
    {
      this.colour = colour;
    PVector pos = new PVector(x, y);
    this.facingRight = facingRight;
      if (facingRight)
      {
        leg = createShape();
        leg.beginShape();
        leg.fill(colour);
        leg.vertex(pos.x + 5, pos.y + 40);        
        leg.vertex(pos.x + 10, pos.y + 50);
        leg.vertex(pos.x, pos.y + 60);
        leg.vertex(pos.x - 5, pos.y + 50);
        leg.endShape(CLOSE);

        ankle = createShape();
        ankle.beginShape();
        ankle.fill(colour);
        ankle.vertex(pos.x, pos.y + 60);
        ankle.vertex(pos.x - 5, pos.y + 50);
        ankle.vertex(pos.x - 25, pos.y + 50);
        ankle.vertex(pos.x - 20, pos.y + 60);
        ankle.endShape(CLOSE);
        shape(ankle, 0, 0);
        shape(leg, 0, 0);
      } else
      {
        leg = createShape();
        leg.beginShape();
        leg.fill(colour);
        leg.vertex(pos.x + 5, pos.y + 50);        
        leg.vertex(pos.x + 10, pos.y + 40);
        leg.vertex(pos.x + 15, pos.y + 50);
        leg.vertex(pos.x + 10, pos.y + 60);
        leg.endShape(CLOSE);

        ankle = createShape();
        ankle.beginShape();
        ankle.fill(colour);
        ankle.vertex(pos.x + 15, pos.y + 50);
        ankle.vertex(pos.x  + 10, pos.y + 60);
        ankle.vertex(pos.x + 35, pos.y + 60);
        ankle.vertex(pos.x + 30, pos.y + 50);
        ankle.endShape(CLOSE);
        shape(ankle, 0, 0);
        shape(leg, 0, 0);
      }
    }

}
