class Launcher extends GraObject
{
  // Position of the launcher
  PVector position;
  
  // Angle of shoot
  float angle;
  
  // Maximum power
  float maxPower;
  // Current power
  float power;
  // The higher powerLoadingSpeed is the quicker the power attain the maximum value
  float powerLoadingSpeed;
  
  // If true the mouse is down
  boolean mouseDown;
  
  Launcher(float x, float y)
  {
    position = new PVector(x, y);
    angle = 0;
    maxPower = 100;
    power = 0;
    powerLoadingSpeed = 1;
    mouseDown = false;
  }
  
  void update()
  {
    if (mouseDown)
    {
      if (power < maxPower)
        power += powerLoadingSpeed;
    }
    else
    {
      if (power > 0)
        power -= powerLoadingSpeed;
    }
    
    super.update();
  }
  
  void draw()
  {
    rectMode(CENTER);
    fill(50);
    
    if (mouseDown)
    {
      angle = atan2(mouseY - position.y, mouseX - position.x);
      
      text("power : " + power, mouseX - 20, mouseY);
      text("angle : " + angle, mouseX - 20, mouseY + 30);
      
      line(position.x, position.y, mouseX, mouseY);
    }
    rect(position.x, position.y, 20, 20);
    
    super.draw();
  }
  
  Bullet shoot(float xshoot, float yshoot)
  {     
    mouseDown = false;
    return (new Bullet(position.x, position.y, angle, power));
  } 
}
