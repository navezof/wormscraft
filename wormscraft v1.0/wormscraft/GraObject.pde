class GraObject
{
  Physics physics = new Physics();
  
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
