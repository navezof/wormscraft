class Bullet extends GraObject
{
  float power;
  float angle;

  float smoothFire;

  Bullet(float x, float y, float _angle, float _power)
  {    
    physics.position = new PVector(x, y);
    angle = _angle;
    power = _power;
    smoothFire = 200;

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

    ellipse(physics.position.x * caseSize, physics.position.y * caseSize, caseSize, caseSize);

    super.draw();
  }
}

