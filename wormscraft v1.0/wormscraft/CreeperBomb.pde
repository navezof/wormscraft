class CreeperBomb extends Bullet
{  
  CreeperBomb(float x, float y, float _angle, float _power)
  {
    super(x, y, _angle, _power);
  }
  
  void update()
  {
    super.update();
  }
  
   void draw()
  {
    fill(0, 255, 0);
    
    ellipse(physics.position.x * caseSize, physics.position.y * caseSize, pWidth, pHeight);

    //super.draw();
  }
 
  void draw(float x, float y)
  {
     fill(0, 255, 0);

     ellipse(x, y, pWidth, pHeight);
  }
 
  public void onCollision(GraObject collider)
  {    
    if (collider.physics.tag == "GROUND")
    {
      Creeper test = new Creeper((int)this.physics.position.x + 1, (int)this.physics.position.y);
      game.addNPC(test);
      game.destroyBullet(this);
    }
  }
}
