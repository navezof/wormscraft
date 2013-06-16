class Creeper extends BasicAI {

  Creeper(int x, int y) {
    super(x, y, 2);
  }

  void attack() {
    println ("CREEEEEEPEEEEEERRRRRR");
    List<Charater> l = game.getCharacterList();
    for (int i = 0; i < l.size(); i++) {
      if (PVector.dist(this.physics.position, l.get(i).physics.position) > 3) {
        l.get(i).getDamage(20);
      }
    }
    PVector pos = this.physics.position;
    for (int i = -2; i < 3; i++) {
      for (int j = 2; j < 3; j++) {
       game.removeMapCube((int)pos.x + i, (int)pos.y + j);
      }
      
    }

    pv = 0;
    game.nextPlayerToPlay();
    actif = false;
  }
}

