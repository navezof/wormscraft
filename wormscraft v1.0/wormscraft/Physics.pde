static class Physics
{
  // Reference to the object
  
  PVector position = new PVector(0, 0);
  PVector velocity = new PVector(0, 0);
  PVector acceleration = new PVector(0, 0);
  
  float mass;
  float time;
  
  // Property of the physics
  boolean  hasGravity = true;
  PVector gravity;
  
  // Wind Property
  boolean  hasWind = false;
  PVector windForce;
  
  Physics()
  {
    mass = 1;
    gravity = new PVector(0, 0.1 * mass);
    windForce = new PVector(0.01, 0);
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
  }
  
  void detectCollision()
  {
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
