void startGame(String mapName) {
  int sizeX;
  int sizeY;

  int map[][];
  String lines[] = loadStrings("./map/"+mapName+".txt");
  if (lines != null && lines.length > 2) {
    String sizes[] = lines[0].split(" ");
    if (sizes != null && sizes.length == 2) {
      sizeX =  Integer.parseInt(sizes[0]); 
      sizeY =  Integer.parseInt(sizes[1]); 

      map = new int[sizeY][];
      for (int i = 1; i < lines.length; i++) {
        map[i - 1] = new int[sizeX];
        String block[] = lines[i].split(" ");
        if (block.length > sizeX) {
          println("Error: In File map `" +  mapName + "`: Line " + i + " Line too long;");
          break;
        }
        for (int j = 0; j < block.length; j++) {
          map[i - 1][j] = Integer.parseInt(block[j]);
        }
      }
      game = new Game(map);
    } 
    else {
      println("Error: In File map `" +  mapName + "` size X and Y are Unvalid");
    }
  }
  else {
    println("Error: In File map `" +  mapName + "` Bad File or Not found");
  }
}

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
    _team = new ArrayList<Team>();
    _team.add(new Team("Team 1"));
    _team.add(new Team("Team 2"));
    _characters = new ArrayList<GraObject>();
    _items = new ArrayList<GraObject>();
    _bullets = new ArrayList<GraObject>();
    
    _currentUpdate = new ArrayList<GraObject>();
    _nextUpdate = new ArrayList<GraObject>();
    _map = new GraObject[map.length][];
    
    int _currentTeam = 0;
    for (int mY = 0; mY < map.length; mY++) {
    _map[mY]= new GraObject[map[mY].length];
      for (int mX = 0; mX < map[mY].length; mX++) {
        if (map[mY][mX] > 0) {
          println("New cube in:  x=" + mX * caseWidth + " && y=" + mY * caseWidth);
          _map[mY][mX] = new Cube(mX, mY, map[mY][mX]);
        } else if (map[mY][mX] != -1) {
            Charater tmp = new Charater(mX, mY);
            _characters.add(tmp);
            _team.get(_currentTeam)._pl.add(tmp);
            _currentTeam++;
            _currentTeam = _currentTeam % _team.size();
        }
      }
    }
    _team.add(new Team("Mob"));
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
        if (_map[i][j] != null)
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
    if (this._currentCharacters >= this._team.get(this._currentTeam)._pl.size()) {
      this._currentCharacters = 0;
      this._currentTeam++;
      if (this._currentTeam >= this._team.size()) {
        this._currentTeam = 0;
      }
      //Sinon, tous le monde est mort !
    }
  }
}

