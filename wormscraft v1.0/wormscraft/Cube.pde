class Cube extends GraObject
{

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
    rect(physics.position.x * 32, physics.position.y * 32, 32, 32);
  }
}
