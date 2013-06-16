class Creeper extends BasicAI {

  Creeper(int x, int y) {
    super(x, y, 2);
  }

  void attack() {
    List<Charater> l = game.getCharacterList();
    for (int i = 0; i < l.size(); i++) {
      if (PVector.dist(this.physics.position, l.get(i).physics.position) < 2) {
        l.get(i).getDamage(20);
      }
    }
    PVector pos = this.physics.position;
    for (int i = - 1; i < 2; i++) {
      for (int j = - 1; j < 2; j++) {
       game.removeMapCube((int)pos.x + i, (int)pos.y + j);
      }
    }
    pv = 0;
    armor = 0;
    game.destroyPlayer(this);
    game.nextPlayerToPlay();
    actif = false;
  }
}

