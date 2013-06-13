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
    
    equipWeapon(9);
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
    if (game.isInventoryOpen() == false)
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
        if (ready && power > 10)
          shoot();
        if (power > 0)
          power -= powerLoadingSpeed;
        ready = false;
      }
    }
  }
  
  void shoot()
  {
    if (owner.actif == true && game.isInventoryOpen() == false)
    {
      mouseDown = false;
      
      Bullet bullet = createBullet();
      if (bullet != null)
      {
        game.newBullet(bullet);
        game.setUpdate(bullet);
      }
      game.nextPlayerToPlay();
      owner.actif = false;
      owner.inItemShop = false;
      power = 0;
    }
  }
 
  Bullet createBullet()
  {
    switch (currentWeaponIndex)
    {
      case (5):
        println("Zombie selected");
        return (new ZombieBomb(aimPosx / caseSize, aimPosy / caseSize, angle, power));
      case (9):
        println("Bow selected");
        return (new Bullet(aimPosx / caseSize, aimPosy / caseSize, angle, power));
      case (10):
        println("Fireball selected");
        return (new Fireball(aimPosx / caseSize, aimPosy / caseSize, angle, power));
        /*
      case (18):
        println("Bomb selected");
        return (new Bomb(aimPosx / caseSize, aimPosy / caseSize, angle, power));
        */
      default:
         println("The weapon ; " + currentWeaponIndex + " doesn't exist");
    }
    return (null);
  }
  
  void equipWeapon(int nb)
  {
    currentWeaponIndex = nb;
    switch (currentWeaponIndex)
    {
      case (5):
        println("Zombie selected");
        currentWeapon = (new ZombieBomb(aimPosx / caseSize, aimPosy / caseSize, angle, power));
        break;
      case (9):
        println("Bow selected");
        currentWeapon = (new Bullet(aimPosx / caseSize, aimPosy / caseSize, angle, power));
        break;
      case (10):
        println("Fireball selected");
        currentWeapon = (new Fireball(aimPosx / caseSize, aimPosy / caseSize, angle, power));
        break;
        /*
      case (18):
        println("Bomb selected");
        currentWeapon = (new Bomb(aimPosx / caseSize, aimPosy / caseSize, angle, power));
        break;
        */
      default:
         println("The weapon ; " + currentWeaponIndex + " doesn't exist");
         break;   
    }
  }
}


