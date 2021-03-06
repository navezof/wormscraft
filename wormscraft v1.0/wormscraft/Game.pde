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

  private ArrayList<GraObject> _currentUpdate;
  private ArrayList<GraObject> _nextUpdate;

  private List<Team> _team;
  private List<Charater> _characters;
  private List<GraObject> _bullets;
  private List<GraObject> _items;  //item on the map;

  private int _currentCharacters;
  private int _currentTeam;

  private float _deltaTime; //time in milliseconds between 2 updates.
  private float _lastTime;
  private GraObject[][] _map;

  private int _mapSizeX;
  private int _mapSizeY;

  private PVector _wind;
  public  float windMaxSpeed = 7.0F;

  private PImage _background;

  private GameGI gui;
  private boolean _partyOver;
  private int _endVisualEfect = 0;
  public ItemShop itemShop;

  public List<Charater> getCharacterList() {
    return _characters;
  }

  public void addNPC(Charater npc) {
      setUpdate(npc);
    _characters.add(npc);
    _team.get(2)._pl.add(npc);
  }

  Game(int[][] map) {
    itemShop = new ItemShop();
    _team = new ArrayList<Team>();
    _team.add(new Team("Team 1"));
    _team.add(new Team("Team 2"));
    _team.add(new Team("NPC"));
    _partyOver = false;
    _characters = new ArrayList<Charater>();
    _items = new ArrayList<GraObject>();
    _bullets = new ArrayList<GraObject>();
    _currentTeam = 0;
    _currentCharacters = 0;

    _currentUpdate = new ArrayList<GraObject>();
    _nextUpdate = new ArrayList<GraObject>();
    _map = new GraObject[map.length][];

    _background = loadImage("img/background.png");

    int _currentTeam = 0;
    _mapSizeX = map[0].length;
    _mapSizeY = map.length;
    for (int mY = 0; mY < map.length; mY++) {
      _map[mY]= new GraObject[map[mY].length];
      for (int mX = 0; mX < map[mY].length; mX++) {
        if (map[mY][mX] > 0) {
          _map[mY][mX] = new Cube(mX, mY, map[mY][mX]);
        } 
        else if (map[mY][mX] == -1) {
          Charater tmp = new Charater(mX, mY, _currentTeam + 1);
          if (_currentTeam != 0 || _team.get(_currentTeam)._pl.size() > 0) {
            setUpdate(tmp);
          }
          _characters.add(tmp);
          _team.get(_currentTeam)._pl.add(tmp);
          _currentTeam++;
          _currentTeam = _currentTeam % (_team.size() - 1);
        }
      }
    }
    _team.add(new Team("Mob"));
    this.windInit();
    gui = new GameGI(this);
    if (_currentTeam < this._team.size() && this._team.get(_currentTeam) != null && _currentCharacters < this._team.get(_currentTeam)._pl.size() && this._team.get(_currentTeam)._pl.get(_currentCharacters) != null) {
      this._team.get(_currentTeam)._pl.get(_currentCharacters).actif = true;
      this.setUpdate(this._team.get(_currentTeam)._pl.get(_currentCharacters));
    }
  }

  public void update() {
    if (_partyOver) {
      if (mouseClick) {
        game = null;
      }
      return;
    }
    // switch the Update list.
    ArrayList<GraObject> tmpList = this._currentUpdate;
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

    //Update current player
    if (!(_currentTeam < this._team.size() && this._team.get(_currentTeam) != null && _currentCharacters < this._team.get(_currentTeam)._pl.size() && this._team.get(_currentTeam)._pl.get(_currentCharacters) != null)) {
      nextPlayerToPlay();
      this._team.get(_currentTeam)._pl.get(_currentCharacters).update();
    }


    //Foreach GraObject whose have to be update, current character, bullet, and co...
    while (this._currentUpdate.size () > 0) {

      this._currentUpdate.get(0).update();
      this._currentUpdate.remove(0);
    }

    gui.update();
  }

  //Init wind
  private void windInit() {    
    if (_wind == null) {
      _wind = new PVector();
    }
    _wind.x = random(-1.0F, 1.0F) * random(0.0F, windMaxSpeed);
    _wind.y = 0;
  }

  // draw every object
  private void drawForeach(List<GraObject> T) {
    for (int i=0; i < T.size(); i++) {
      T.get(i).draw();
    }
  }

  public void draw() {
    //Draw background
    if (_background != null) {
      image(_background, 0, 0, width, height);
    }

    //Draw Map's Object
    for (int i = 0; i < this._map.length; i++) {
      for (int j = 0; j <  this._map[i].length; j++) {
        if (this._map[i][j] != null)
          this._map[i][j].draw();
      }
    }

    //Draw every Object
    for (int i=0; i < this._characters.size(); i++) {
      this._characters.get(i).draw();
    }
    drawForeach(this._items);
    drawForeach(this._bullets);

    //Draw HUD
    gui.draw();

    //Game Over Screen
    if (_partyOver) {
      fill(0, 0, 0, _endVisualEfect);
      if (_endVisualEfect < 255)
        _endVisualEfect+=3;
      rect(0, 0, width, height);
      textAlign(CENTER, CENTER);
      fill(255);
      text("Game Over\n\n" + (_team.get(1)._pl.size() == 0 ? "Player 0 win" : "Player 1 win"), width / 2, height / 2);
    }
  }

  public void setUpdate(GraObject target) {
    this._nextUpdate.add(target);
  }

  public Charater getCurrentCharacter() {
    if (_team.get(0)._pl.size() == 0 || _team.get(1)._pl.size() == 0)
      _partyOver = true;
    if (_currentTeam < this._team.size() && this._team.get(_currentTeam) != null && _currentCharacters < this._team.get(_currentTeam)._pl.size() && this._team.get(_currentTeam)._pl.get(_currentCharacters) != null) {
      return this._team.get(_currentTeam)._pl.get(_currentCharacters);
    } 
    else {
      println("getCurrentCharacter");
      nextPlayerToPlay();
    }
    return null;
  }

  public Team getTeam(int tar) {
    if (this._team.get(tar) != null) {
      return this._team.get(tar);
    }
    return null;
  }

  public void newPlayer(Charater target, int teamId) {
    this._characters.add(target);
    if (teamId < _team.size()) {
      _team.get(teamId)._pl.add(target);
    }
  }

  public void destroyPlayer(GraObject target) { 
    this._characters.remove(target);
    for (int i = 0; i < _team.size(); i++) {
      _team.get(i)._pl.remove(target);
    }
    this._nextUpdate.remove(target);
  }

  public void newBullet(GraObject target) {
    this._bullets.add(target);
  }

  public void destroyBullet(GraObject target) {
    this._bullets.remove(target);
    this._nextUpdate.remove(target);
  }
  public void newItem(GraObject target) {
    this._items.add(target);
  }

  public void destroyItem(GraObject target) {
    this._items.remove(target);
    this._nextUpdate.remove(target);
  }

  public float getDeltaTime() {
    return this._deltaTime;
  }

  public int getMapSizeX() {
    return this._mapSizeX;
  }

  public int getMapSizeY() {
    return this._mapSizeY;
  }

  public GraObject getMapCube(int trgX, int trgY) {
    if (trgX > 0 && trgX < this._mapSizeX
      &&trgY > 0 && trgY < this._mapSizeY) {
      return this._map[trgX][trgY];
    }
    return null;
  }

  public void setMapCube(int trgX, int trgY, GraObject target) {
    if (trgX > 0 && trgX < this._mapSizeX
      &&trgY > 0 && trgY < this._mapSizeY) {
      this._map[trgY][trgX] = target;
    }
  }

  public void removeMapCube(int trgX, int trgY) {
    if (trgX > 0 && trgX < this._mapSizeX
      &&trgY > 0 && trgY < this._mapSizeY) {
      this._map[trgY][trgX] = null;
    }
  }

  public float getWind() {
    return this._wind.x;
  }
  
  public boolean isInventoryOpen()
  {
    return (gui._isInventoryOpen);
  }
  //Interaction with current team and current player.

  public void nextPlayerToPlay() {
    println("Std ENTER");
    println("_currentCharacters " + _currentCharacters);
    println("_currentTeam " + _currentTeam);
    this._currentCharacters++;
    if (this._currentCharacters >= this._team.get(this._currentTeam)._pl.size()) {
      this._currentCharacters = 0;
      this._currentTeam++;
      if (this._currentTeam >= this._team.size()) {
        this._currentTeam = 0;
      }
    }
    if (!(this._currentCharacters >= this._team.get(this._currentTeam)._pl.size())) {
      this._team.get(this._currentTeam)._pl.get(this._currentCharacters).restartTimer();
      this._team.get(this._currentTeam)._pl.get(this._currentCharacters).actif = true;
      this.setUpdate(this._team.get(_currentTeam)._pl.get(_currentCharacters));
    }
    this.windInit();
    if (gui != null)
    {
      gui.updateData();
      gui._currentPlayer = this._team.get(_currentTeam)._pl.get(_currentCharacters);
    }
    println("Std OUT");
    println("_currentCharacters " + _currentCharacters);
    println("_currentTeam " + _currentTeam);
  }
}

