class Charater extends GraObject {
  int TIMERDEFAULT = 5000;
  float xSizeHead = caseSize - 10;
  float ySizeHead = caseSize;
  float xSizeBody = caseSize - 10;
  float ySizeBody = caseSize;

  float walkSpeed = 0.1;
  float jumpForce = 0.2;
  float airSpeedCoef = 0.5;

  Consumable item;
  float  pv = 100;
  float armor  = 0;

  int timer;
  int startTimer;

  PImage leftImage;
  PImage rightImage;
  PImage waitImage;

  PImage currentImage;
  int nbTeam = 1;

  public boolean inItemShop = false;
  public boolean actif = false;
  // Direction of the character 1 = right, -1 = left
  float direction;

  Launcher weapon;

  Charater(int x, int y, int team) {
    physics.position = new PVector(x, y);
    nbTeam = team;
    if (nbTeam == 1) {
      leftImage = loadImage("leftImage.png");
      rightImage = loadImage("rightImage.png");
      waitImage = loadImage("waitImage.png");
    }
    else if (nbTeam == 2) {
      leftImage = loadImage("leftImageOpp.png");
      rightImage = loadImage("rightImageOpp.png");
      waitImage = loadImage("waitImageOpp.png");
    }
    physics.tag = "PLAYER";

    currentImage = waitImage;
    pWidth = xSizeBody;
    pHeight = 32;

    weapon = new Launcher(this, x, y);
  }

  void draw()
  {
    image(currentImage, physics.position.x * caseSize, (physics.position.y - 1) * caseSize, xSizeBody, ySizeBody *2 );

    weapon.draw();
    if (item != null) {
      item.draw();
    }
  }

  boolean moveLeft() {
    if (physics.position.x - 1 > 0 && physics.position.y - 2 > 0 && (physics.checkCollision(game._map[(int) physics.position.y][(int) physics.position.x]) == false) && 
      (physics.checkCollision(game._map[(int) physics.position.y - 2][(int) physics.position.x - 1]) == false))
    {
      if (!physics.hasGravity && physics.checkCollision(game._map[(int) (physics.position.y - 1)][(int) (physics.position.x)]) == false)
      {
        if (physics.checkCollision(game._map[(int) (physics.position.y)][(int) (physics.position.x)]) == false)
        {
          currentImage = leftImage;
          physics.velocity.x = -walkSpeed;
          return true;
        }
      }
      else 
      {
        if ((game._map[(int) (physics.position.y)][(int) (physics.position.x - 1)] == null) &&
          (game._map[(int) (physics.position.y + 1)][(int) (physics.position.x - 1)] == null))
        {
          currentImage = leftImage;
          physics.velocity.x = -walkSpeed * airSpeedCoef;
          return true;
        }
      }
    }
    return false;
  }

  boolean moveRight() {
    if (physics.position.x + 1 < game.getMapSizeX() && physics.checkCollision(game._map[(int) physics.position.y][(int) physics.position.x + 1]) == false)
    {
      if (!physics.hasGravity && physics.checkCollision(game._map[(int) (physics.position.y - 1)][(int) (physics.position.x + 1)]) == false)
      {
        if (physics.checkCollision(game._map[(int) (physics.position.y)][(int) (physics.position.x + 1)]) == false)
        {
          currentImage = rightImage;
          physics.velocity.x = walkSpeed;
          return true;
        }
      }
      else
      {   
        if (physics.position.y - 1 > 0 && physics.position.y + 1 < game.getMapSizeY() && physics.position.x - 1 > 0 && physics.position.x + 1 < game.getMapSizeX())
        {
          if ((game._map[(int) (physics.position.y)][(int) (physics.position.x)] == null) &&
            (game._map[(int) (physics.position.y + 1)][(int) (physics.position.x)] == null) &&
            (game._map[(int) (physics.position.y - 1)][(int) (physics.position.x)] == null) &&
            (game._map[(int) (physics.position.y)][(int) (physics.position.x + 1)] == null) &&
            (game._map[(int) (physics.position.y + 1)][(int) (physics.position.x + 1)] == null) &&
            (game._map[(int) (physics.position.y - 1)][(int) (physics.position.x + 1)] == null))
          {
            currentImage = rightImage;
            physics.velocity.x = walkSpeed * airSpeedCoef;
            return true;
          }
        }
      }
    }
    return false;
  }

  boolean jump() {
    if ((game._map[(int) (physics.position.y - 1)][(int) (physics.position.x)] == null))
    {
      currentImage = rightImage;
      physics.velocity.y = -0.2;
      return true;
    }
    return false;
  }
  void  getInput()
  {
    currentImage = waitImage;
    physics.velocity.x = 0;
    if (keyPressed)
    {
      if (key == 'i') {
        if (!inItemShop) {
          inItemShop = true; 
          game.itemShop.init();
        }
      }
      if (key == 'q' || key == 'Q')
      {
        moveLeft();
      }
      if (key == 'd' || key == 'D' )
      {
        moveRight();
      }

      if (key == ' ' && physics.velocity.y == 0) {
        println("test jump");
        jump();
      }
    }
    if (mousePressed)
    {
      if (inItemShop) {
        game.itemShop.update();
      } 
      else {
        weapon.charge(true);
      }
    }
    else
    {
      weapon.charge(false);
    }

    text(physics.position.x + " \n" +  physics.position. y, physics.position.x + 100, physics.position.y + 100 + ySizeHead * 2);
  }

  public void healPv(float heal) {
    pv += heal;
    if (pv > 100) {
      pv = 100;
    }
  }

  void addArmor(float addA) {
    armor += addA;
    if (armor > 100) {
      armor = 100;
    }
  }

  void getDamage(float damage) {
    if (armor <=  0) {
      pv-= damage;
    }
    else if (armor < damage) {
      pv -= (damage - armor);
    }
    else {
      armor -= damage;
    }
    if (pv <= 0)
      game.destroyPlayer(this);
  }

  public float getXPos() {
    return this.physics.position.x;
  }

  public float getYPos() {
    return this.physics.position.y;
  }

  public float getPv() {
    return  this.pv;
  }

  public float getArmor() {
    return this.armor;
  }

  public float getTimer() {
    return (float)this.timer / 100;
  }

  public void restartTimer() {
    println("* Restart TImer");
    this.startTimer = millis();
    this.timer = millis();
  }

  void update() {
    weapon.update(physics.position.x, physics.position.y);
    if (actif) {
      getInput();
    }
    float tmpX = this.physics.position.x;
    float tmpY = this.physics.position.y;

    super.update();
    physics.checkGround();
    if (actif || tmpX != this.physics.position.x || tmpY != this.physics.position.y || physics.velocity.x != 0 || physics.velocity.y != 0) {
      game.setUpdate(this);
    }

    if (item != null) {
      item.update();
    }

    this.timer = millis();
    if (actif && this.timer >= startTimer + TIMERDEFAULT) {
      println("---- Next Player Call");
      game.nextPlayerToPlay();
      actif = false;
      inItemShop = false;
    }
    //if (!actif && (physics.velocity.x != 0 || physics.velocity.y != 0))
    //    game.setUpdate(this);
  }

  float getTimeRemaning() {
    return 1 + ( startTimer + TIMERDEFAULT - this.timer) / 1000;
  }

  void onCollision(GraObject collider)
  {
    if (collider.physics.tag == "BULLET")
    {
      //game.destroyPlayer(this);
    }
  }

  void takeWeapon(int nb)
  {
    weapon.equipWeapon(nb);
    //nb étant le numéro de l'arme par rapport à l'inventaire.
    // TDla new weapon, ect...
  }
}

