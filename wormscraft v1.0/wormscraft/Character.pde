class Charater extends GraObject {
  float xSizeHead = 20;
  float ySizeHead = 20;
  float xSizeBody = 20;
  float ySizeBody = 20;
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
        physics.velocity.x = -1;
      if (key == 'd')
        physics.velocity.x = 1;
    }
    text( physics.velocity.x, physics.position.x, physics.position.y + ySizeHead * 2);
  }

  void update() {
        getInput();
    super.update();
    physics.position.y = height/2;
  }
}

