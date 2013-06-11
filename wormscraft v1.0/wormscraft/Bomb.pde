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
    
    ellipse(physics.position.x * caseSize, physics.position.y * caseSize, pWidth, pHeight);

    //super.draw();
  }
 
  void draw(float x, float y)
  {
     fill(255, 0, 0);

     ellipse(x, y, pWidth, pHeight);
  }
 
  public void onCollision(GraObject collider)
  {    
    if (collider.physics.tag == "GROUND")
    {
      game.destroyBullet(this);
      game.removeMapCube((int )collider.physics.position.x, (int) collider.physics.position.y);
    }
    if (collider.physics.tag == "PLAYER")
    {
        game.destroyBullet(this);
    }
  }
}
