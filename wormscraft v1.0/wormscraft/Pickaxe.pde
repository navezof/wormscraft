class Pickaxe extends Bullet
{
  float initX;
  float initY;
  float po;


  Pickaxe(float x, float y, float _angle, float _power, float powa)
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
    if (myDist < -1 || myDist > 1)
      game.destroyBullet(this);
  }
 
  public void onCollision(GraObject collider)
  {    
    if (collider.physics.tag == "GROUND")
    {
      game.destroyBullet(this);
      game.removeMapCube((int )collider.physics.position.x, (int) collider.physics.position.y);
      if (po > 1)
        game.removeMapCube((int )collider.physics.position.x + 1, (int) collider.physics.position.y);
      if (po > 2)
        game.removeMapCube((int )collider.physics.position.x + 1, (int) collider.physics.position.y + 1);
    }
  }  
}

