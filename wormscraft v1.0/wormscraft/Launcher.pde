class Launcher extends GraObject
{
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
  
  boolean ready;

  Launcher(float x, float y)
  {
    physics.position.x = x;
    physics.position.y = y;
    angle = 0;
    maxPower = 100;
    power = 0;
    powerLoadingSpeed = 1;
    mouseDown = false;
    ready = false;
    
    physics.hasGravity = false;
    
    pWidth = 32;
    pHeight = 10;
  }

  void update(float x, float y)
  {
    physics.position.x = x;
    physics.position.y = y;

    super.update();
  }

  void draw()
  {
    fill(50);

    if (mouseDown)
    {
      angle = atan2(mouseY - (physics.position.y * caseSize), mouseX - (physics.position.x * caseSize));

      text("power : " + power, mouseX - 20, mouseY);
      text("angle : " + angle, mouseX - 20, mouseY + 30);

      line(physics.position.x * caseSize, physics.position.y * caseSize, mouseX, mouseY);
    }
    rect(physics.position.x * caseSize, physics.position.y * caseSize, pWidth, pHeight);

    super.draw();
  }

  void charge(boolean mouseDownClicked)
  {
    mouseDown = mouseDownClicked;
    if (mouseDown)
    {
      println("Charging");
      if (power < maxPower)
        power += powerLoadingSpeed;
      ready = true;  
    }
    else
    {
      if (ready)
        shoot();
      if (power > 0)
        power -= powerLoadingSpeed;
      ready = false;
    }
  }
  
  void shoot()
  {
    println("shoot");    
    mouseDown = false;
    
    Bullet bullet = new Bullet(physics.position.x -2, physics.position.y, angle, power);
    game.newBullet(bullet);
    game.setUpdate(bullet);
  }
}

