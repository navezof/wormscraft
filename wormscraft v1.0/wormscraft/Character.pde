class Charater extends GraObject {
  int TIMERDEFAULT = 300000;
  float xSizeHead = caseSize;
  float ySizeHead = caseSize;
  float xSizeBody = caseSize;
  float ySizeBody = caseSize;

  Consumable item;
  float  pv = 100;
  float armor  = 0;

  int timer;
  int startTimer;

  public boolean actif = false;
 // Direction of the character 1 = right, -1 = left
  float direction;

  Launcher weapon;

  Charater(int x, int y) {
    item = new Pickaxe(this, 20);
    physics.position = new PVector(x, y);
    println("x charac= " + x);
    println("y charac= " + y);

    physics.tag = "PLAYER";
    
    pWidth = 32;
    pHeight = 32;
    
    weapon = new Launcher(x, y);
  }

  void draw()
  {
    fill(0, 0, 255);
    rect(physics.position.x * caseSize, (physics.position.y - 1) * caseSize, xSizeHead, ySizeHead);
    fill(0, 255, 0);
    rect(physics.position.x * caseSize, physics.position.y * caseSize, xSizeBody, ySizeBody);
    
    //weapon.draw();
    if (item != null) {
     item.draw(); 
    }
  }

  void  getInput() {
    physics.velocity.x = 0;
    if (keyPressed) {
      if (key == 'q' || key == 'Q')
        physics.velocity.x = -0.1;
      if (key == 'd' || key == 'D' )
        physics.velocity.x = 0.1;
    }
    
    if (mousePressed)
    {
      //weapon.charge(true);
    }
    else
    {
      weapon.charge(false);
    }
    
    text(  physics.position.x + " \n" +  physics.position. y, physics.position.x + 100, physics.position.y + 100 + ySizeHead * 2);
  }

  void healPv(float heal) {
    pv += heal;
    if (pv > 100) {
      pv = 100;
    }
  }

  void addArmor(float addA) {
    armor += addA;
    if (armor > 100) {
      armor = 100;
    }
  }

  void getDamage(float damage) {
    if (armor <=  0) {
      pv-= damage;
    }
    else if (armor < damage) {
      pv -= (damage - armor);
    }
    else {
      armor -= damage;
    }
  }

  public float getXPos() {
    return this.physics.position.x; 
  }

  public float getYPos() {
    return this.physics.position.y; 
  }

  public float getPv() {
    return  this.pv;
  }

  public float getArmor() {
    return this.armor;
  }

  public float getTimer() {
    return (float)this.timer / 100;
  }

  public void restartTimer() {
    this.startTimer = millis();
  }
 
  void update() {
    weapon.update(physics.position.x, physics.position.y);
    if (actif) {
      getInput();
    }
    float tmpX = this.physics.position.x;
    float tmpY = this.physics.position.y;

    super.update();
    physics.checkGround();
    if (actif || tmpX != this.physics.position.x || tmpY != this.physics.position.y) {
     game.setUpdate(this); 
    }

    if (item != null) {
     item.update(); 
    }

    this.timer = millis();
     if (startTimer + TIMERDEFAULT <= this.timer) {
       game.nextPlayerToPlay();
       actif = false;
    }
  }

  void onCollision(GraObject collider)
  {
    if (collider.physics.tag == "BULLET")
    {
      game.destroyPlayer(this);
    }
  }
}


