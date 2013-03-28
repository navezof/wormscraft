class Cube extends GraObject
{

  int type;

  Cube(float x, float y)
  {

    physics.initializePhysics(true, false);
    physics.setPosition(new PVector(x, y));
  }

  void update()
  {
    physics.update();
  }

  void draw()
  { 
    println(physics.position.x);
    println(physics.position.y);
    rect(physics.position.x * caseSize, physics.position.y * caseSize, caseSize, caseSize);
  }
}

