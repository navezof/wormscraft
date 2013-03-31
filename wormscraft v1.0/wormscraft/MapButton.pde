class MapButton {
  private int _xSize;
  private int _ySize;
  private int _xPos = 0;
  private int _yPos = 0;
  private PImage _data;
  private String _mapName;

  private final int _mouseOverRed = 210; 
  private final int _mouseOverGreen = 105; 
  private final int _mouseOverBlue = 30; 
  private final int _mouseOverAlpha = 100;

  private int myTimer = 0;
  
  MapButton(int xSize, int ySize, PImage data, String mapName) {
    this._ySize = ySize;
    this._xSize = xSize;
    this._data = data;
    this._mapName = mapName;
  }

  void draw(int posX, int posY) {
    if (_data != null) {
      image(_data, posX, posY, _xSize, _ySize);
    }
    if (mouseX >= posX && mouseX <= posX + this._xSize 
      && mouseY >= posY && mouseY <= posY + this._ySize) {
      if (myTimer < 200)
          myTimer++;
      strokeWeight(3);
      stroke(_mouseOverRed, _mouseOverGreen, _mouseOverBlue, _mouseOverAlpha + (myTimer / 1.5));
      fill(255, 255, 255, 0);
    }
    else {
      if (myTimer != 0)
        myTimer = 0;
      stroke(100);
      fill(153, 153, 153, 100);
    }
    rect(posX, posY, _xSize, _ySize);
    textAlign(CENTER);
    textSize(26);
    fill(20);
    text(_mapName, posX + (_xSize / 2), posY + (_ySize / 1.25));
    strokeWeight(1);
  }

  void update(int posX, int posY) {
    if (mouseClick 
      && mouseX >= posX && mouseX <= posX + this._xSize 
      && mouseY >= posY && mouseY <= posY + this._ySize)
      startGame(this._mapName);
  }
}

