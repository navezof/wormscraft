class Bullet extends GraObject
{
  float power;
  float angle;

  float smoothFire;
  
  float bWidth;
  float bHeight;
  
  Bullet(float x, float y, float _angle, float _power)
  {    
    position = new PVector(x, y);
    angle = _angle;
    power = _power;
    smoothFire = 10;
    bWidth = 50;
    bHeight = 50;
    
    physics.initializePhysics(true, true);
    physics.applyForce(new PVector((power/smoothFire * cos(angle)), (power/smoothFire * sin(angle))));
  }
    
  void update()
  {    
    super.update();
  }
  
  void draw()
  {
    fill(150);
    ellipse(position.x, position.y, bWidth, bHeight);
    
    super.draw();
  }
}
