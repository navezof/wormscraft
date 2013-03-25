class GraObject
{
  PVector position = new PVector(0,0);

  Physics physics = new Physics(this);
  
  GraObject()
  {
    physics.initializePhysics(true, false);
  }
  
  void update()
  {
    physics.update();
  }
  
  void draw()
  {
  }
}
