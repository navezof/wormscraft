class MainMenu {

  private int _lignTop;
  private PImage _background;
  private MapButton[] _mapButton;

  private int _xMapButton;
  private int _yMapButton;
  private int _xSizeMapButton;
  private int _ySizeMapButton;

  MainMenu() {
    File mapFolder = new File(dataPath("map"));

    if (!mapFolder.exists()) {
       print("Error: Folder ./map/ not found");
       exit();
    }

  java.io.FilenameFilter txtFilter = new java.io.FilenameFilter() {
    boolean accept(File dir, String name) {
      return name.toLowerCase().endsWith(".txt");
    }
  };

    String[] mapFiles = mapFolder.list(txtFilter);

    _mapButton = new MapButton[mapFiles.length];

    //Charger les images des maps
    for (int i =0; i < mapFiles.length; i++) {
      print("Load map: " + mapFiles[i] + " and the image: " +  mapFiles[i].substring(0, (mapFiles[i].length() - 4)));
      _mapButton[i] = new MapButton((int)(width / 3.6), (int)(height / 8), loadImage("./map/img/" + mapFiles[i].substring(0, (mapFiles[i].length() - 4))+ ".png"),  mapFiles[i].substring(0, (mapFiles[i].length() - 4)));
    }
  }

  void update() {
    if (mousePressed) {
      for (int i =0; i < _mapButton.length; i++) {
        _mapButton[i].update((int)((height / 30) + (i % 3) * (height / 2.3)), (int)((width / 2.6) + (int)(i / 3) * (width / 8)));
      }
    }
  }

  void draw() {
      for (int i =0; i < _mapButton.length; i++) {
        _mapButton[i].draw((int)((height / 30) + (i % 3) * (height / 2.3)), (int)((width / 2.6) + (int)(i / 3) * (width / 8)));
      }
  }
}

