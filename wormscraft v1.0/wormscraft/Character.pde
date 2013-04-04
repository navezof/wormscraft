class Charater extends GraObject {
  float xSizeHead = caseSize;
  float ySizeHead = caseSize;
  float xSizeBody = caseSize;
  float ySizeBody = caseSize;
  PVector  position;

  Charater(int x, int y) {
    position = new PVector(x, y);

  }

  void draw() {
    fill(0, 0, 255);
    rect(physics.position.x, physics.position.y, xSizeHead, ySizeHead);
    fill(0, 255, 0);
    rect(physics.position.x, physics.position.y + ySizeHead, xSizeBody, ySizeBody);
  }

  void  getInput() {
    physics.velocity.x = 0;
    if (keyPressed) {
      if (key == 'q')
        physics.velocity.x = -caseSize;
      if (key == 'd')
        physics.velocity.x = caseSize;
    }
    text( physics.velocity.x, physics.position.x, physics.position.y + ySizeHead * 2);
  }

  void update() {
        getInput();
    super.update();
    physics.position.y = height/2;
  }
}

