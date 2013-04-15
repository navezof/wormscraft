class Bullet extends GraObject
{
  float power;
  float angle;

  float smoothFire;

  Bullet(float x, float y, float _angle, float _power)
  {    
    physics.position = new PVector(x, y);
    physics.tag = "BULLET";
    angle = _angle;
    power = _power;
    smoothFire = 200;

    pWidth = 10;
    pHeight = 10;

    physics.initializePhysics(true, false);
    physics.applyForce(new PVector((power/smoothFire * cos(angle)), (power/smoothFire * sin(angle))));
  }

  void update()
  {
    game._nextUpdate.add(this);
    super.update();
  }

  void draw()
  {
    fill(150);

    rect(physics.position.x * caseSize, physics.position.y * caseSize, pWidth, pHeight);

    super.draw();
  }
  
  public void onCollision(GraObject collider)
  {
    if (collider.physics.tag == "GROUND")
      game.destroyBullet(this);
    if (collider.physics.tag == "PLAYER")
      game.destroyBullet(this);
  }
}

