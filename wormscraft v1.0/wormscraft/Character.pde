class Charater extends GraObject {
  float xSizeHead = caseSize;
  float ySizeHead = caseSize;
  float xSizeBody = caseSize;
  float ySizeBody = caseSize;
  PVector  position;

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

  void update() {
        getInput();
    super.update();
    physics.position.y = 3 * caseSize;
  }
}

