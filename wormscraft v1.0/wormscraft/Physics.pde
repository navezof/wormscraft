class Physics
{ 
  // Reference to the object
  GraObject  graObject;

  PVector position = new PVector(0, 0);
  PVector velocity = new PVector(0, 0);
  PVector acceleration = new PVector(0, 0);

  String tag;

  float mass;
  float time;
  
  float bouncingcoefficient;
  float bounce = 1;

  // Property of the physics
  boolean  hasGravity = true;
  PVector gravity;

  // Wind Property
  boolean  hasWind = false;
  PVector windForce;

  int detectionSize = 1;

  Physics(GraObject obj)
  {
    graObject = obj;
    mass = 1;
    gravity = new PVector(0, 0.01 * mass);
    windForce = new PVector(0.001, 0);
  }

  Physics(float nMass, float nGravity, float nWindForce)
  {
    mass = nMass;
    gravity = new PVector(0, nGravity * mass);
    windForce = new PVector(nWindForce, 0);
  }

  void setPosition(PVector location)
  {
    position = location;
  }

  void initializePhysics(boolean nHasGravity, boolean nHasWind)
  {
    hasGravity = nHasGravity;
    hasWind = nHasWind;
  }

  void update()
  {
    time++;

    detectCollision();
    applyForces();

    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    detectBorder();
  }

  void detectCollision()
  {
    float dx;
    float dy;

    if ((dx = position.x - detectionSize) < 0)
      dx = 0;
    if ((dy = position.y - detectionSize) < 0)
      dy = 0;
    for (float x = dx; x <= position.x + detectionSize; x++)
    {
      for (float y = dy; y <= position.y + detectionSize; y++)
      {
        if (x >= 0 && x < game.getMapSizeX() - 1 && y >= 0 && y < game.getMapSizeY() - 1)
        {
          if (checkCollision(game._map[(int) y][(int) x]))
          {
            graObject.onCollision(game._map[(int) y][(int) x]);
             //hasGravity = false;
             //acceleration.mult(0);
             //velocity.mult(0);
          }
        }
      }
    } 
  }

  boolean checkCollision(GraObject collider)
  {
    if (collider != null)
    {
      if (position.y > collider.physics.position.y + caseSize)
        return (false);
      if (position.y + caseSize < collider.physics.position.y)
        return (false);
      if (position.x > collider.physics.position.x + caseSize)
        return (false);
      if (position.x + caseSize < collider.physics.position.x)
        return (false);
       return (true);
    }
    return (false);
  }

  void detectBorder()
  {
    if (position.x < 0)
    {
      position.x = 0;
      velocity.x = 0;
    }
    else if (position.x > (caseWidth - 1))
    {
      position.x = caseWidth - 1;
      velocity.x = 0;
    }
    if (position.y > (caseHeight - 1))
    {
      position.y = caseHeight - 1;
      velocity.y = 0;
    }
  }

  void applyForces()
  {
    if (hasGravity)
      applyForce(gravity);
    if (hasWind)
      applyForce(windForce);
  }

  void applyForce(PVector force)
  {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
}

