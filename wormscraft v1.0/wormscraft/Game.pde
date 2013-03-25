class Game {

  private List<GraObject> _currentUpdate;
  private List<GraObject> _nextUpdate;

  private List<Team> _team;
  private List<GraObject> _characters;
  private List<GraObject> _bullets;
  private List<GraObject> _items;  //item on the map;

  private int _currentCharacters;
  private int _currentTeam;

  private float _deltaTime; //time in milliseconds between 2 updates.
  private float _lastTime;
  private GraObject[][] _map;

  Game(int[][] map) {
  }

  public void update() {
    // switch the Update list.
    List<GraObject> tmpList = this._currentUpdate;
    this._currentUpdate = this._nextUpdate;
    this._nextUpdate = tmpList;

    //update _deltaTime
    int m = millis();
    this._deltaTime = (m - _lastTime) / 1000;
    this._lastTime = m;
    
    //Clear _nextUpdate if no empty  
    if (!this._nextUpdate.isEmpty()) {
      this._nextUpdate.clear();
    }

    //Foreach GraObject whose have to be update, current character, bullet, and co...
    while (this._currentUpdate.size () > 0) {
      this._currentUpdate.get(0).update();
      this._currentUpdate.remove(0);
    }
  }

  // draw every object

  private void drawForeach(List<GraObject> T) {
    for (int i=0; i < T.size(); i++) {
      T.get(i).draw();
    }
  }

  public void draw() {
    //Draw every Object
    drawForeach(this._characters);
    drawForeach(this._items);
    drawForeach(this._bullets);

    //Draw Map's Object
    for (int i = 0; i < this._map.length; i++) {
      for (int j = 0; j <  this._map[i].length; j++) {
        this._map[i][j].draw();
      }
    }
    //Draw HUD
  }

  public void setUpdate(GraObject target) {
    _nextUpdate.add(target);
  }

  // Items list Manager
  public void newPlayer(GraObject target) {
    this._characters.add(target);
  }

  public void destroyPlayer(GraObject target) { 
    this._characters.remove(target);
  }

  public void newBullet(GraObject target) {
    this._bullets.add(target);
  }

  public void destroyBullet(GraObject target) {
    this._bullets.remove(target);
  }
  public void newItem(GraObject target) {
    this._items.add(target);
  }

  public void destroyItem(GraObject target) {
    this._items.remove(target);
  }

 public float getDeltaTime() {
  return this._deltaTime; 
 }
 
  //Interaction with current team and current player.

  public void nextPlayerToPlay() {
    this._currentCharacters++;
    if (this._currentCharacters >= this._team.get(this._currentTeam).getNbPlayer()) {
      this._currentCharacters = 0;
      this._currentTeam++;
      if (this._currentTeam >= this._team.size()) {
        this._currentTeam = 0;
      }
      //Sinon, tous le monde est mort !
    }
  }
}

