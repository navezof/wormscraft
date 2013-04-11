class Charater extends GraObject {
  float xSizeHead = caseSize;
  float ySizeHead = caseSize;
  float xSizeBody = caseSize;
  float ySizeBody = caseSize;
  PVector  position;

  float  pv = 100;
  float armor  = 0;

  float timer;

  Charater(int x, int y) {
    physics.position = new PVector(x, y);
    println("x charac= " + x);
    println("y charac= " + y);

    physics.tag = "PLAYER";
  }

  void draw() {
    fill(0, 0, 255);
    rect(physics.position.x * caseSize, physics.position.y * caseSize, xSizeHead, ySizeHead);
    fill(0, 255, 0);
    rect(physics.position.x * caseSize, (physics.position.y + 1) * caseSize, xSizeBody, ySizeBody);
  }

  void  getInput() {
    physics.velocity.x = 0;
    if (keyPressed) {
      if (key == 'q' || key == 'Q')
        physics.velocity.x = -0.1;
      if (key == 'd' || key == 'D' )
        physics.velocity.x = 0.1;
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

  public float getPv() {
    return  this.pv;
  }

  public float getArmor() {
    return this.armor;
  }

  public float getTimer() {
    return this.timer;
  }

  void update() {
    getInput();
    super.update();
    physics.checkGround();
    //physics.position.y = 3 * caseSize;
  }

  void onCollision(GraObject collider)
  {
    if (collider.physics.tag == "BULLET")
    {
      game.destroyPlayer(this);
    }
  }
}

