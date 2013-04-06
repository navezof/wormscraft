class GameGI {
  Team _currentTeam;
  Game _myGame;
  boolean _isInventoryOpen;

  PFont font;

  private int _textSize = 16;
  /*
 **  WIND BOX
   */
  //STATIC
  private int _windBoxPosX = 73 * width / 100;
  private int _windBoxPosY = 95 * height / 100;
  private int _windBoxSizeX = 25 * width / 100;
  private int _windBoxSizeY = 3 * height / 100;
  //TO UPDATE
  private float windPower;
  private float windMax;

  /*
 **  PLAYER BOX
   */
  //STATIC
  private int _playerBoxPosX = 5 * width / 100;
  private int _playerBoxPosY = 92 * height / 100;
  private int _playerBoxSizeX = 25 * width / 100;
  private int _playerBoxSizeY = 5 * height / 100;
  //TO UPDATE
  private float playerPv;
  private float playerArmor;
  private Charater _currentPlayer;

  /*
 **  TEAM BOX
   */
  //STATIC
  private int _teamBoxPosX = 42 * width / 100;
  private int _teamBoxPosY = 92 * height / 100;
  private int _teamBoxSizeX = 25 * width / 100;
  private int _teamBoxSizeY = 5 * height / 100;

  /*
 **  TIME BOX
   */
  //STATIC
  private int _timeBoxPosX;
  private int _timeBoxPosY;
  private int _timeBoxSizeX;
  private int _timeBoxSizeY;

  private long _lastTimer;
  private long _updateTimer = 500;

  GameGI(Game tr) {
    font = createFont("Minecraftia.ttf", 14);
    this._myGame = tr;
    windMax = _myGame.windMaxSpeed;
    this.updateData();
  }


  public void updateData() {
    _currentPlayer = _myGame.getCurrentCharacter();
    windPower = _myGame.getWind();
    _lastTimer = 0;
  }

  void update() {
    long newTime = millis();

    if (newTime > _lastTimer + _updateTimer && _currentPlayer != null) {
      _lastTimer = newTime;
      playerPv = _currentPlayer.getPv();
      playerArmor = _currentPlayer.getArmor();
    }
  }

  public void draw() {
    //
    //display wind
    //
    fill(139);
    stroke(51);

    rect(_windBoxPosX, _windBoxPosY, _windBoxSizeX, _windBoxSizeY);
    fill(198);
    int sizeX =  (int)((_windBoxSizeX / 2) * windPower / windMax);
    if (sizeX < 0) {
      sizeX *= -1;
    }
    rect((windPower < 0 ? _windBoxPosX + (_windBoxSizeX / 2) - sizeX: _windBoxPosX +  (_windBoxSizeX / 2)), _windBoxPosY, sizeX, _windBoxSizeY);

    stroke(126, 0, 0);
    fill(126, 0, 0);
    rect((_windBoxPosX + _windBoxSizeX / 2) - 1, _windBoxPosY - 2, 3, _windBoxSizeY + 4);
    textFont(font);
    textAlign(CENTER, CENTER);
    fill(48);
    text("Wind", _windBoxPosX + (_windBoxSizeX / 2), _windBoxPosY - 15);

    //
    //display team name and nbr player
    //
    textAlign(LEFT, CENTER);
    text(game.getTeam(0).getName() + "   x" + game.getTeam(0).getNbMember(), _teamBoxPosX + (_teamBoxSizeX / 2), _teamBoxPosY);
    text(game.getTeam(1).getName() + "   x" + game.getTeam(1).getNbMember(), _teamBoxPosX + (_teamBoxSizeX / 2), _teamBoxPosY + _teamBoxSizeY);

    //
    //display player life
    //
    textAlign(LEFT, CENTER);
    text(playerPv, _playerBoxPosX + (_playerBoxSizeX / 2), _playerBoxPosY);
    text(playerArmor, _playerBoxPosX + (_playerBoxSizeX / 2), _playerBoxPosY + _playerBoxSizeY);
 


    //
    //display time remaining
    //
    //display current weapon
    //display weapon inventory
    //display weapon inventory button
    //display Exit button
  }
}

