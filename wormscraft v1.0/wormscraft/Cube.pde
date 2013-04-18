class Cube extends GraObject
{
  static final String cubetexdir = "img/cube/img_";
  PImage _texture;
  int type;
  boolean invincible;

  Cube(float x, float y, int type)
  {
	physics.tag = "GROUND";
  
    _texture = loadImage(cubetexdir + type + ".png");
    if (type == 3 || type == 7)
    {
      physics.initializePhysics(true, false);
    }
    else
    {
      physics.initializePhysics(false, false);
    }
    physics.setPosition(new PVector(x, y));
    if (type == 6)
    {
      invincible = true;
    }
    else
    {
      invincible = false;
    }
    
    pWidth = 32;
    pHeight = 32;
  }

  void update()
  {
    if (mouseClick)
    physics.update();
  }

  void draw()
  { 
    image(_texture, physics.position.x * caseSize, physics.position.y * caseSize, caseSize, caseSize);
    //rect(physics.position.x * caseSize, physics.position.y * caseSize, caseSize, caseSize);
  }
}

