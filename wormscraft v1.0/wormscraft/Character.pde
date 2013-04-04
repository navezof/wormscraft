class Charater extends GraObject {
  float xSizeHead = caseSize;
  float ySizeHead = caseSize;
  float xSizeBody = caseSize;
  float ySizeBody = caseSize;
  PVector  position;
  
  float  pv = 100;
  float armor  = 0;
  
  
  Charater(int x, int y) {
    physics.position = new PVector(x, y);
      println("x charac= " + x);
      println("y charac= " + y);
  }

  void draw() {
    fill(0, 0, 255);
    rect(physics.position.x * caseSize, physics.position.y, xSizeHead, ySizeHead);
    fill(0, 255, 0);
    rect(physics.position.x * caseSize, physics.position.y + ySizeHead, xSizeBody, ySizeBody);
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

  void update() {
        getInput();
    super.update();
    physics.position.y = 3 * caseSize;
  }
}

