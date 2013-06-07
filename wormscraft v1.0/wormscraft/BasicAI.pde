


class BasicAI extends Charater {

  boolean allowClimbing = false;
  Charater target = null;


  void loadZombie() {
    loadZombieImage();
    walkSpeed /= 2;
  }

  void loadZombieImage() {
    leftImage = loadImage("leftImageZombie.png");
    rightImage = loadImage("rightImageZombie.png");
    waitImage = loadImage("waitImageZombie.png");
  }

  BasicAI(int x, int y, int type) {
    super(x, y, 1);
    if (type == 1)
      loadZombie();
  }

  void attack() {
    target.getDamage(5.0f);
    game.nextPlayerToPlay();
    actif = false;
//    inItemShop = false;
  }

  void getInput() {
    if (target != null) {
      if (this.physics.position.x > target.physics.position.x && PVector.dist(this.physics.position, target.physics.position) > 1)
        moveLeft();
      else if (this.physics.position.x < target.physics.position.x && PVector.dist(this.physics.position, target.physics.position) > 1)
        moveRight();
      else if (PVector.dist(this.physics.position, target.physics.position) <= 1)
        attack();
        else
        jump();
    }
  }

  void update() {
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
}

