class GameGI {
  Team _currentTeam;
  Game _myGame;
  boolean _isInventoryOpen;

  PFont font;

  //Images Data
  PImage gui;
  //armor
  PImage _armorFull;
  PImage _armorHalf;
  PImage _armorNone;
  //Health
  PImage _healthFull;
  PImage _healthHalf;
  PImage _healthNone;
  //wind
  PImage _windLeftFull;
  PImage _windLeftNone;
  PImage _windCenterFull;
  PImage _windCenterNone;
  PImage _windRightFull;
  PImage _windRightNone;
  //team
  PImage _team1;
  PImage _team2;

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
  private int _playerBoxSizeY = 3 * height / 100;
  //TO UPDATE
  private float playerPv;
  private float playerArmor;
  public Charater _currentPlayer;

  /*
 **  TEAM BOX
   */
  //STATIC
  private int _teamBoxPosX = 42 * width / 100;
  private int _teamBoxPosY = 92 * height / 100;
  private int _teamBoxSizeX = 25 * width / 100;
  private int _teamBoxSizeY = 3 * height / 100;

  /*
 **  TIME BOX
   */
  //STATIC
  private int _timeBoxSizeX = 5 *  width / 100;
  private int _timeBoxSizeY = 4 *  width / 100;
  private int _timeBoxPosX = (50 * width / 100) - (_timeBoxSizeX / 2);
  private int _timeBoxPosY = (int)(2.5 * width / 100) - (_timeBoxSizeY / 2);

  private long _lastTimer;
  private long _updateTimer = 500;

  private PFont fontbgTime;

  GameGI(Game tr) {
    gui = loadImage("img/gui.png");
    //INIT ARMOR IMG
    _armorFull = gui.get(22, 32, 16, 18);
    _armorHalf = gui.get(38, 32, 16, 18);
    _armorNone = gui.get(54, 32, 16, 18);
    //INIT PV IMG
    _healthFull = gui.get(22, 52, 16, 18);
    _healthHalf = gui.get(38, 52, 16, 18);
    _healthNone = gui.get(54, 52, 16, 18);
    //WIND IMG
    _windLeftFull = gui.get(0, 36, 20, 10);
    _windLeftNone = gui.get(0, 24, 20, 10);
    _windCenterFull = gui.get(0, 0, 20, 10);
    _windCenterNone = gui.get(0, 12, 20, 10);
    _windRightFull = gui.get(0, 48, 20, 10);
    _windRightNone = gui.get(0, 60, 20, 10);
    //TEAM IMG
    _team1 = gui.get(61, 0, 9, 10);
    _team1.resize(20, 20);
    _team2 = gui.get(51, 0, 9, 10);
    _team2.resize(20, 20);
    font = createFont("Minecraftia.ttf", 14);
    fontbgTime = createFont("Minecraftia.ttf", 16);
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
    strokeWeight(3);
    stroke(51);

    fill(198);
    int sizeX =  (int)((_windBoxSizeX / 2) * windPower / windMax);
    if (sizeX < 0) {
      sizeX *= -1;
    }
    if (windPower < 0) {
      //
      // WIND POW < 0
      //
      if (windPower * -100 / 7 > 90) {
        image(_windLeftFull, _windBoxPosX, _windBoxPosY);
      } 
      else {
        image(_windLeftNone, _windBoxPosX, _windBoxPosY);
      }
      for (int i = 0; i < 4; i++) {
        //println(100 - (i * 20));
        //println(windPower * -100 / 7);        
        if (windPower * -100 / 7 >= 100 - (i * 20)) {
          image(_windCenterFull, _windBoxPosX + (_windCenterFull.width * (i + 1)), _windBoxPosY);
        } 
        else {
          image(_windCenterNone, _windBoxPosX + (_windCenterFull.width * (i + 1)), _windBoxPosY);
        }
      }
      for (int i = 0; i < 4; i++) {
        image(_windCenterNone, _windBoxPosX + (_windCenterFull.width * (i + 5)), _windBoxPosY);
      }
      image(_windRightNone, _windBoxPosX + (_windCenterFull.width * 9), _windBoxPosY);
    } 
    else {
      //
      // WIND POW > 0
      //
      for (int i = 1; i < 5; i++) {
        image(_windCenterNone, _windBoxPosX + (_windCenterFull.width * i), _windBoxPosY);
      }
      image(_windLeftNone, _windBoxPosX, _windBoxPosY);
      if (windPower * 100 / 7 > 90) {
        image(_windRightFull, _windBoxPosX + (_windCenterFull.width * 9), _windBoxPosY);
      } 
      else {
        image(_windRightNone, _windBoxPosX + (_windCenterFull.width * 9), _windBoxPosY);
      }
      for (int i = 4; i < 8; i++) {
        //println(100 - (i * 20));
        //println(windPower * 100 / 7);        
        if (windPower * 100 / 7 >= ((i - 4) * 20)) {
          image(_windCenterFull, _windBoxPosX + (_windCenterFull.width * (i + 1)), _windBoxPosY);
        } 
        else {
          image(_windCenterNone, _windBoxPosX + (_windCenterFull.width * (i + 1)), _windBoxPosY);
        }
      }
    }
    stroke(126, 0, 0);
    fill(126, 0, 0);
    textFont(font);
    textAlign(CENTER, CENTER);
    fill(48);
    text("Wind", _windBoxPosX + (_windBoxSizeX / 2), _windBoxPosY - 15);

    //
    //display team name and nbr player
    //
    textAlign(LEFT, TOP);
    text(game.getTeam(0).getName() + " x" + game.getTeam(0).getNbMember(), _teamBoxPosX + (_teamBoxSizeX / 2) + 22, _teamBoxPosY - 2);
    text(game.getTeam(1).getName() + " x" + game.getTeam(1).getNbMember(), _teamBoxPosX + (_teamBoxSizeX / 2) + 22, _teamBoxPosY + _teamBoxSizeY - 2);
    image(_team1, _teamBoxPosX + (_teamBoxSizeX / 2), _teamBoxPosY);
    image(_team2, _teamBoxPosX + (_teamBoxSizeX / 2), _teamBoxPosY + _teamBoxSizeY); 
    //
    //display player life
    //
    //HEALTH
    float tmp = playerPv / 10;
    for (int nb = 0; nb < 10; nb ++) { 
      if (tmp > 0.9F) {
        image(_healthFull, _playerBoxPosX + (_playerBoxSizeX / 2) + (nb * (_armorNone.width + 1)), _playerBoxPosY);
        tmp--;
      } 
      else if (tmp > 0.0F) {
        image(_healthHalf, _playerBoxPosX + (_playerBoxSizeX / 2) + (nb * (_armorNone.width + 1)), _playerBoxPosY);
        tmp = 0.0F;
      } 
      else {
        image(_healthNone, _playerBoxPosX + (_playerBoxSizeX / 2) + (nb * (_armorNone.width + 1)), _playerBoxPosY);
      }
    }

    //ARMOR
    tmp = playerArmor / 10;
    for (int nb = 0; nb < 10; nb ++) { 
      if (tmp > 0.9F) {
        image(_armorFull, _playerBoxPosX + (_playerBoxSizeX / 2) + (nb * (_armorNone.width + 1)), _playerBoxPosY + _playerBoxSizeY);
        tmp--;
      } 
      else if (tmp > 0.0F) {
        image(_armorHalf, _playerBoxPosX + (_playerBoxSizeX / 2) + (nb * (_armorNone.width + 1)), _playerBoxPosY + _playerBoxSizeY);
        tmp = 0.0F;
      } 
      else {
        image(_armorNone, _playerBoxPosX + (_playerBoxSizeX / 2) + (nb * (_armorNone.width + 1)), _playerBoxPosY + _playerBoxSizeY);
      }
    }

    //TIMER
     textAlign(LEFT, BOTTOM);
     fill(45);
     textFont(fontbgTime, 17);
     text((int)_currentPlayer.getTimeRemaning(), _timeBoxPosX + (_timeBoxSizeX / 2), _timeBoxSizeY);
     fill(198);
     textFont(font);
     text((int)_currentPlayer.getTimeRemaning(), _timeBoxPosX + (_timeBoxSizeX / 2), _timeBoxSizeY);

    if (_currentPlayer.inItemShop)
      game.itemShop.display();
  }
}

