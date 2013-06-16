class Sword extends Bullet
{
  float initX;
  float initY;
  float po;


  Sword (float x, float y, float _angle, float _power, float powa)
  {
    super(x, y, _angle, _power);
    po = powa;
    initX = x;
    initY = y;
  }
  
  void update()
  {
    super.update();
  }
  
   void draw()
  {
  }
 
  void draw(float x, float y)
  {
    float myDist = ((x + y) - (initX + initY));
    if (myDist < -0.5 || myDist > 0.5)
      game.destroyBullet(this);
  }
 
  public void onCollision(GraObject collider)
  {    
    if (collider.physics.tag == "GROUND")
    {
      game.destroyBullet(this);
    }
    if (collider.physics.tag == "PLAYER")
    {
      collider.getDamage(po * 15);
      game.destroyBullet(this);
    }
  }  
}

