class GraObject
{
  Physics physics = new Physics(this);

  float pWidth;
  float pHeight;
  
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
  
  public void onCollision(GraObject collider)
  {
  }
}

