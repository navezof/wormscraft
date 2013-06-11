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
  
  float aimPosx;
  float aimPosy;
  
  Charater owner;
  
  int currentWeaponIndex = 0;
  Bullet currentWeapon;
  
  Launcher(Charater newOwner, float x, float y)
  {
    physics.position.x = x;
    physics.position.y = y;
    owner = newOwner;
    
    println("Launcher pos : " + physics.position.x + " / " + physics.position.y);
    angle = 0;
    maxPower = 100;
    power = 0;
    powerLoadingSpeed = 1;
    mouseDown = false;
    ready = false;
    
    physics.hasGravity = false;
    
    pWidth = 32;
    pHeight = 10;
    
    equipWeapon(0);
  }

  void update(float x, float y)
  {
    if (owner.actif == true)
    {
      physics.position.x = x;
      physics.position.y = y;
    
      super.update();
    }
  }

  void draw()
  {
    if (owner.actif == true)
      {
      fill(50);
  
      if (mouseDown)
      {
        angle = atan2(mouseY - (physics.position.y * caseSize), mouseX - (physics.position.x * caseSize));
  
        text("power : " + power, mouseX - 20, mouseY);
        text("angle : " + angle, mouseX - 20, mouseY + 30);
  
        //line(physics.position.x * caseSize, physics.position.y * caseSize, mouseX, mouseY);
        
        aimPosx = physics.position.x * caseSize;
        aimPosy = physics.position.y * caseSize;
        
        atan2(mouseY - (physics.position.y * caseSize), mouseX - (physics.position.x * caseSize));
        float r = atan2(mouseX - (physics.position.x * caseSize), mouseY - (physics.position.y * caseSize));
        aimPosx = sin(r) * 30 + (physics.position.x * caseSize);
        aimPosy = sin(r + PI/2) * 40 + (physics.position.y * caseSize);
        
        //rect(aimPosx, aimPosy, 10, 10);
        if (currentWeapon != null)
        {
          currentWeapon.draw(aimPosx, aimPosy);
        }
      }
      //rect(physics.position.x  + caseSize, physics.position.y * caseSize, pWidth, pHeight);
      
      super.draw();
      }
  }

  void charge(boolean mouseDownClicked)
  {
    mouseDown = mouseDownClicked;
    if (mouseDown)
    {
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
    if (owner.actif == true)
    {
      mouseDown = false;
      
      Bullet bullet = createBullet();
      if (bullet != null)
      {
        game.newBullet(bullet);
        game.setUpdate(bullet);
      }
    }
  }
 
  Bullet createBullet()
  {
    if (currentWeaponIndex == 0)
    {
        return (new Bullet(aimPosx / caseSize, aimPosy / caseSize, angle, power));
    }
    else if (currentWeaponIndex == 1)
    {
        return (new Bomb(aimPosx / caseSize, aimPosy / caseSize, angle, power));
    }
    else if (currentWeaponIndex == 5)
    {
      return (new ZombieBomb(aimPosx / caseSize, aimPosy / caseSize, angle, power));
    }
    else
    {
      println("The weapon ; " + currentWeaponIndex + " doesn't exist");
    }
    return (null);
  }
  
  void equipWeapon(int nb)
  {
    currentWeaponIndex = nb;
    if (currentWeaponIndex == 0)
    {
        currentWeapon = (new Bullet(aimPosx / caseSize, aimPosy / caseSize, angle, power));
    }
    else if (currentWeaponIndex == 1)
    {
        currentWeapon = (new Bomb(aimPosx / caseSize, aimPosy / caseSize, angle, power));
    }
    else if (currentWeaponIndex == 5)
    {
      currentWeapon = (new ZombieBomb(aimPosx / caseSize, aimPosy / caseSize, angle, power));
    }
    else
    {
      println("The weapon ; " + currentWeaponIndex + " doesn't exist");
    }
  }
}


