


class BasicAI extends Charater {

  boolean allowClimbing = false;
  Charater target = null;
  PImage eggImage;
  int sleepingTime = 2;

  void loadCreeper() {
    loadCreeperImage();
  }


  void loadCreeperImage() {
    leftImage = loadImage("CreeperSide.png");
    rightImage = loadImage("CreeperSide.png");
    waitImage = loadImage("CreeperWait.png");
    eggImage = loadImage("eggCreeper.png");
  }

  void loadEnderMan() {
    loadEnderManImage();
  }


  void loadEnderManImage() {
    leftImage = loadImage("EnderMan.png");
    rightImage = loadImage("EnderMan.png");
    waitImage = loadImage("EnderMan.png");
    eggImage = loadImage("eggEnderMan.png");
  }

  void loadZombie() {
    loadZombieImage();
    walkSpeed /= 2;
  }

  void loadZombieImage() {
    leftImage = loadImage("leftImageZombie.png");
    rightImage = loadImage("rightImageZombie.png");
    waitImage = loadImage("waitImageZombie.png");
    eggImage = loadImage("eggZombie.png");
  }

  BasicAI(int x, int y, int type) {
    super(x, y, -1);
    if (type == 1)
      loadZombie();
    if (type == 2)
      loadCreeper();
    if (type == 3)
      loadEnderMan();
    currentImage = eggImage;
  }

  boolean sleep() {
    sleepingTime--;
    if (sleepingTime > 0) {
      sleepingTime--;
      currentImage = eggImage;
      return true;
    }
    currentImage = waitImage;
    return false;
  }

  void attack() {
    target.getDamage(5.0f);
    game.nextPlayerToPlay();
    actif = false;
    //    inItemShop = false;
  }

  void getInput() {
    if (target != null && !sleep()) {
      if (this.physics.position.x > target.physics.position.x && PVector.dist(this.physics.position, target.physics.position) > 1)
        moveLeft();
      else if (this.physics.position.x < target.physics.position.x && PVector.dist(this.physics.position, target.physics.position) > 1)
        moveRight();
      else if (PVector.dist(this.physics.position, target.physics.position) <= 1)
        attack();
    }
  }

  void update() {

    println("test Zombie");
    if (actif) {
      findTarget();
      super.update();
    }
  }

  void findTarget() {
    List<Charater> l = game.getCharacterList();
    if (target  == null) {
      for (int i = 0; i < l.size(); i++) {
        if (PVector.dist(this.physics.position, l.get(i).physics.position) > 0) {
          target = l.get(i);
          break;
        }
      }

      for (int i = 0; i < l.size(); i++) {
        if (PVector.dist(this.physics.position, l.get(i).physics.position) > 0 
          && PVector.dist(this.physics.position, l.get(i).physics.position) < PVector.dist(this.physics.position, target.physics.position)) {
          target = l.get(i);
        }
      }
    }
  }
  void draw()
  {
    if (sleepingTime > 0)
      image(currentImage, physics.position.x * caseSize, (physics.position.y) * caseSize, xSizeBody, ySizeBody );
    else
      image(currentImage, physics.position.x * caseSize, (physics.position.y - 1) * caseSize, xSizeBody, ySizeBody * 2 );
    //weapon.draw();
    if (item != null) {
      item.draw();
    }
  }
}

