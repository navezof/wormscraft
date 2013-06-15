class Bomb extends Bullet
{
  int bombDamage = 50;
  
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
      GraObject tmp_charac;
      
      for (int tx = (int) collider.physics.position.x - 1; tx < (int) collider.physics.position.x + 1; tx++)
      {
        for (int ty = (int) collider.physics.position.y - 1; ty < (int) collider.physics.position.y + 1; ty++)
        {
          game.removeMapCube(tx, ty);
          if ((tmp_charac = collider.physics.detectCharacterCollisionInPosition(tx, ty)) != null)
            tmp_charac.getDamage(bombDamage);
        }
      }
    }
    if (collider.physics.tag == "PLAYER")
    {
      collider.getDamage(100);
      game.destroyBullet(this);
      
      GraObject tmp_charac;
      for (int tx = (int) collider.physics.position.x - 1; tx < (int) collider.physics.position.x + 1; tx++)
      {
        for (int ty = (int) collider.physics.position.y - 1; ty < (int) collider.physics.position.y + 1; ty++)
        {
          game.removeMapCube(tx, ty);
          if ((tmp_charac = collider.physics.detectCharacterCollisionInPosition(tx, ty)) != null)
            tmp_charac.getDamage(bombDamage);
        }
      }
    }
  }
}
