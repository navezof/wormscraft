class Bomb extends Bullet
{
  int aeraEffect = 1;
  
  Bomb(float x, float y, float _angle, float _power)
  {
    super(x, y, _angle, _power);
  }
  
  void update()
  {
    super.update();
  }
  
   void draw()
  {
    fill(255, 0, 0);
    
    rect(physics.position.x * caseSize, physics.position.y * caseSize, 20, 20);

    //super.draw();
  }
 
  void draw(float x, float y)
  {
     fill(255, 0, 0);

     rect(x, y, 20, 20);
  }
 
  public void onCollision(GraObject collider)
  {    
    if (collider.physics.tag == "GROUND")
    {
      game.destroyBullet(this);
      game.removeMapCube((int )collider.physics.position.x, (int) collider.physics.position.y);
      game.removeMapCube((int )collider.physics.position.x - 1, (int) collider.physics.position.y);
      game.removeMapCube((int )collider.physics.position.x + 1, (int) collider.physics.position.y);
    }
    if (collider.physics.tag == "PLAYER")
    {
      collider.getDamage(40);
      game.destroyBullet(this);
    }
  }
}
