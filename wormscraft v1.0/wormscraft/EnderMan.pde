class EnderMan extends BasicAI {

  EnderMan(int x, int y) {
    super(x, y, 3);
  }

  void Tp() {
    this.physics.position.x = target.physics.position.x + .1f;
    this.physics.position.y = target.physics.position.y;
    game.nextPlayerToPlay();
    actif = false;
  }

  void attack() {
    target.getDamage(10.0f);
    game.nextPlayerToPlay();
    actif = false;
  }

  void getInput() {
    if (target != null && !sleep()) {
      if (this.physics.position.x > target.physics.position.x && PVector.dist(this.physics.position, target.physics.position) > 1)
        Tp();
      else if (this.physics.position.x < target.physics.position.x && PVector.dist(this.physics.position, target.physics.position) > 1)
        Tp();
      else if (PVector.dist(this.physics.position, target.physics.position) <= 1)
        attack();
    }
  }
}

